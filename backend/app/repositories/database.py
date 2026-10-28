import os
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

url = os.getenv('DATABASE_URL') or URL.create(
    'mysql+pymysql', username=os.getenv('MYSQL_USER', 'hotel_app'),
    password=os.getenv('MYSQL_PASSWORD', 'change_me_locally'),
    host=os.getenv('MYSQL_HOST', '127.0.0.1'),
    port=int(os.getenv('MYSQL_PORT', '3306')),
    database=os.getenv('MYSQL_DATABASE', 'hotel_kong_arthur'),
)
engine = create_engine(url, pool_pre_ping=True, isolation_level='READ COMMITTED',
                       connect_args={'init_command': "SET time_zone = '+00:00'"})

class Repository:
    def __init__(self, connection):
        self.db = connection

    def rows(self, sql, **params):
        return [dict(r) for r in self.db.execute(text(sql), params).mappings()]

    def one(self, sql, **params):
        rows = self.rows(sql, **params)
        return rows[0] if rows else None

    def execute(self, sql, **params):
        return self.db.execute(text(sql), params)

    def health(self):
        return self.one('SELECT 1 ok')

    def now(self):
        return self.one('SELECT UTC_TIMESTAMP() now')['now']

    def room_types(self):
        return self.rows('SELECT id,name,capacity FROM room_types WHERE active ORDER BY id')

    def rooms(self, room_id=None, lock=False):
        return self.rows('''SELECT r.*, rt.name room_type, rt.capacity,
            rt.active type_active FROM rooms r JOIN room_types rt ON rt.id=r.room_type_id
            WHERE (:id IS NULL OR r.id=:id) ORDER BY r.id''' +
            (' FOR UPDATE' if lock else ''), id=room_id)

    def bookings(self, booking_id=None, lock=False):
        if lock:
            self.one('SELECT id FROM bookings WHERE id=:id FOR UPDATE', id=booking_id)
        return self.rows('''SELECT b.*, r.room_number, rt.name room_type, rt.capacity,
            g.first_name, g.last_name, g.email, g.phone, g.country_code
            FROM bookings b JOIN rooms r ON r.id=b.room_id
            JOIN room_types rt ON rt.id=r.room_type_id JOIN guests g ON g.id=b.guest_id
            WHERE (:id IS NULL OR b.id=:id) ORDER BY b.id''', id=booking_id)

    def booking_page(self, status, page, page_size, room_id=None, guest_id=None, start=None, end=None):
        filters = dict(status=status, room=room_id, guest=guest_id, start=start, end=end)
        predicate = """(:status IS NULL OR b.status=:status)
            AND (:room IS NULL OR b.room_id=:room) AND (:guest IS NULL OR b.guest_id=:guest)
            AND (:start IS NULL OR b.check_out>:start) AND (:end IS NULL OR b.check_in<:end)"""
        total = self.one('SELECT COUNT(*) n FROM bookings b WHERE '+predicate, **filters)['n']
        rows = self.rows("""SELECT b.*, r.room_number, rt.name room_type, rt.capacity,
            g.first_name, g.last_name, g.email, g.phone, g.country_code
            FROM bookings b JOIN rooms r ON r.id=b.room_id
            JOIN room_types rt ON rt.id=r.room_type_id JOIN guests g ON g.id=b.guest_id
            WHERE """+predicate+""" ORDER BY b.id
            LIMIT :limit OFFSET :offset""", **filters, limit=page_size, offset=(page-1)*page_size)
        return rows, total

    def overlaps(self, room_id, start, end, exclude=0):
        return self.one('''SELECT id FROM bookings WHERE room_id=:room
            AND status='confirmed' AND check_in<:end AND check_out>:start
            AND id<>:exclude LIMIT 1''', room=room_id, start=start, end=end, exclude=exclude)

    def prices(self, room_type_id):
        return self.rows('''SELECT p.price_per_night, s.id season_id, s.code season,
            sp.start_month, sp.start_day, sp.end_month, sp.end_day
            FROM room_type_prices p JOIN seasons s ON s.id=p.season_id
            JOIN season_periods sp ON sp.season_id=s.id
            WHERE p.room_type_id=:id AND p.active AND s.active''', id=room_type_id)

    def nights(self, start, end, country=None, room_type=None, season=None):
        return self.rows('''SELECT l.night_date, l.line_total, l.price_per_night, l.quantity, s.code season,
            b.id booking_id, b.guest_id, b.room_id, r.room_type_id, b.guests_count, g.country_code, g.country_name,
            rt.name room_type, r.room_number FROM booking_price_lines l
            JOIN bookings b ON b.id=l.booking_id JOIN guests g ON g.id=b.guest_id
            JOIN rooms r ON r.id=b.room_id JOIN room_types rt ON rt.id=r.room_type_id
            JOIN seasons s ON s.id=l.season_id
            WHERE b.status='confirmed' AND l.night_date>=:start AND l.night_date<:end
            AND (:country IS NULL OR g.country_code=:country)
            AND (:room_type IS NULL OR r.room_type_id=:room_type)
            AND (:season IS NULL OR s.code=:season)
            ORDER BY l.night_date, b.id''', start=start, end=end, country=country, room_type=room_type, season=season)

    def sales(self, start, end, employee):
        return self.rows('''SELECT p.name product, p.category, s.quantity, s.unit_price,
            s.employee_name, s.sold_at FROM bar_sales s JOIN bar_products p ON p.id=s.product_id
            WHERE s.sold_at>=:start AND s.sold_at<:end
            AND (:employee IS NULL OR s.employee_name=:employee)''', start=start, end=end, employee=employee)

    def save_guest(self, guest):
        return self.execute("""INSERT INTO guests(first_name,last_name,email,phone,country_code,country_name)
            VALUES(:first,:last,:email,:phone,:country,:country)
            ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), email=VALUES(email), phone=VALUES(phone)""", **guest).lastrowid

    def save_booking(self, values, booking_id=None, replace_lines=True):
        if booking_id is not None:
            self.execute("""UPDATE bookings SET guest_id=:guest, room_id=:room, check_in=:start, check_out=:end,
                guests_count=:count, price_total=:total WHERE id=:id""", id=booking_id, **values)
            if replace_lines:
                self.execute('DELETE FROM booking_price_lines WHERE booking_id=:id', id=booking_id)
        else:
            booking_id = self.execute("""INSERT INTO bookings(guest_id,room_id,check_in,check_out,guests_count,price_total)
                VALUES(:guest,:room,:start,:end,:count,:total)""", **values).lastrowid
        return booking_id

    def add_price_line(self, booking_id, line):
        self.execute("""INSERT INTO booking_price_lines(booking_id,night_date,season_id,price_per_night,line_total)
            VALUES(:booking,:night_date,:season_id,:price_per_night,:line_total)""", booking=booking_id, **line)

    def cancel_booking(self, booking_id):
        self.execute("UPDATE bookings SET status='cancelled', cancelled_at=UTC_TIMESTAMP() WHERE id=:id", id=booking_id)

    def season_periods(self, season=None):
        return self.rows("""SELECT s.code, p.* FROM season_periods p
            JOIN seasons s ON s.id=p.season_id WHERE s.active
            AND (:season IS NULL OR s.code=:season)""", season=season)

    def review(self, booking_id):
        return self.one('SELECT booking_id,rating,created_at,updated_at FROM booking_reviews WHERE booking_id=:id', id=booking_id)

    def save_review(self, booking_id, rating):
        self.execute("""INSERT INTO booking_reviews(booking_id,rating) VALUES(:id,:rating)
            ON DUPLICATE KEY UPDATE rating=VALUES(rating)""", id=booking_id, rating=rating)
        return self.review(booking_id)

    def satisfaction_rows(self, start, end, today, country=None, room_type=None, season=None):
        return self.rows("""SELECT b.id, b.check_out, v.rating FROM bookings b
            JOIN guests g ON g.id=b.guest_id JOIN rooms r ON r.id=b.room_id
            LEFT JOIN booking_reviews v ON v.booking_id=b.id
            WHERE b.status='confirmed' AND b.check_out>=:start AND b.check_out<:end
            AND b.check_out<=:today AND (:country IS NULL OR g.country_code=:country)
            AND (:room_type IS NULL OR r.room_type_id=:room_type)
            AND (:season IS NULL OR EXISTS (
                SELECT 1 FROM booking_price_lines l JOIN seasons s ON s.id=l.season_id
                WHERE l.booking_id=b.id AND s.code=:season))""",
            start=start, end=end, today=today, country=country, room_type=room_type, season=season)

    def bar_products(self):
        return self.rows("SELECT id,name,category,price,'DKK' currency FROM bar_products WHERE active ORDER BY id")

    def bar_product(self, product_id):
        return self.one('SELECT * FROM bar_products WHERE id=:id AND active FOR UPDATE', id=product_id)

    def save_sale(self, values):
        sale_id = self.execute("""INSERT INTO bar_sales(product_id,sold_at,quantity,unit_price,employee_name)
            VALUES(:product_id,:sold_at,:quantity,:unit_price,:employee_name)""", **values).lastrowid
        return self.one('SELECT * FROM bar_sales WHERE id=:id', id=sale_id)

    def revenue_dimensions(self):
        return (
            self.rows('SELECT id,name FROM room_types ORDER BY id'),
            self.rows('SELECT id,code,name FROM seasons ORDER BY id'),
        )

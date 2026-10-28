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

    def booking_page(self, status, page, page_size):
        total = self.one("SELECT COUNT(*) n FROM bookings WHERE (:status IS NULL OR status=:status)", status=status)['n']
        rows = self.rows("""SELECT b.*, r.room_number, rt.name room_type, rt.capacity,
            g.first_name, g.last_name, g.email, g.phone, g.country_code
            FROM bookings b JOIN rooms r ON r.id=b.room_id
            JOIN room_types rt ON rt.id=r.room_type_id JOIN guests g ON g.id=b.guest_id
            WHERE (:status IS NULL OR b.status=:status) ORDER BY b.id
            LIMIT :limit OFFSET :offset""", status=status, limit=page_size, offset=(page-1)*page_size)
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

    def nights(self, start, end):
        return self.rows('''SELECT l.night_date, l.line_total, s.code season,
            b.id booking_id, b.guests_count, g.country_code,
            rt.name room_type, r.room_number FROM booking_price_lines l
            JOIN bookings b ON b.id=l.booking_id JOIN guests g ON g.id=b.guest_id
            JOIN rooms r ON r.id=b.room_id JOIN room_types rt ON rt.id=r.room_type_id
            JOIN seasons s ON s.id=l.season_id
            WHERE b.status='confirmed' AND l.night_date>=:start AND l.night_date<:end
            ORDER BY l.night_date, b.id''', start=start, end=end)

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
            self.execute("""UPDATE bookings SET guest_id=:guest, check_in=:start, check_out=:end,
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

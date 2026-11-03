#!/bin/sh
set -eu
: "${POSTGRES_HOST:=db}"
: "${POSTGRES_DB:?POSTGRES_DB must be set}"
: "${POSTGRES_USER:?POSTGRES_USER must be set}"
: "${POSTGRES_PASSWORD:?POSTGRES_PASSWORD must be set}"
export PGHOST="$POSTGRES_HOST" PGDATABASE="$POSTGRES_DB" PGUSER="$POSTGRES_USER" PGPASSWORD="$POSTGRES_PASSWORD" PGOPTIONS='-c timezone=UTC'

# Validate before running even the first database command.
if [ "${RESET_TEST_DATABASE:-0}" = "1" ]; then
 if [ "$POSTGRES_DB" != 'hotel_kong_arthur_test' ] || [ "$POSTGRES_HOST" != 'test-db' ]; then
  echo 'Refusing reset outside the dedicated test database/host' >&2
  exit 1
 fi
fi
until pg_isready -q; do sleep 2; done
if [ "${RESET_TEST_DATABASE:-0}" = "1" ]; then
 psql -X -v ON_ERROR_STOP=1 -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
fi
psql -X -v ON_ERROR_STOP=1 -c 'CREATE TABLE IF NOT EXISTS schema_migrations (version varchar(255) PRIMARY KEY, applied_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP);'
for file in /migrations/*.sql /seed/*.sql; do
 version="$(basename "$(dirname "$file")")_$(basename "$file")"
 applied=$(psql -X -At -v ON_ERROR_STOP=1 -c "SELECT count(*) FROM schema_migrations WHERE version='$version'")
 if [ "$applied" = '1' ]; then echo "Skipping $version"; continue; fi
 echo "Applying $version"
 # Schema/seed and its marker commit together. A failed script is safe to retry.
 { cat "$file"; echo "INSERT INTO schema_migrations(version) VALUES('$version');"; } | psql -X -q -v ON_ERROR_STOP=1 --single-transaction
 done
if [ "${RUN_CHECKS:-0}" = '1' ]; then
 for file in /tests/*.sql; do
  [ -f "$file" ] || continue
  psql -X -v ON_ERROR_STOP=1 --single-transaction -f "$file"
 done
fi
# Runtime credentials have DML access, never superuser or schema ownership.
if [ -n "${APP_DATABASE_USER:-}" ]; then
 psql -X -v ON_ERROR_STOP=1 -v app_user="$APP_DATABASE_USER" -v app_password="$APP_DATABASE_PASSWORD" <<'SQL'
SELECT format('CREATE ROLE %I LOGIN PASSWORD %L', :'app_user', :'app_password')
 WHERE NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname=:'app_user')
\gexec
GRANT USAGE ON SCHEMA public TO :"app_user";
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO :"app_user";
REVOKE ALL ON schema_migrations FROM :"app_user";
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO :"app_user";
SQL
fi
echo 'PostgreSQL setup completed.'

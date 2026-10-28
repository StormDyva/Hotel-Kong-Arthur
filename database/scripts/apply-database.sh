#!/bin/sh

set -eu

: "${MYSQL_HOST:=db}"
: "${MYSQL_DATABASE:?MYSQL_DATABASE must be set}"
: "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD must be set}"

mysql_root() {
    mysql --protocol=TCP \
        --host="${MYSQL_HOST}" \
        --user=root \
        --password="${MYSQL_ROOT_PASSWORD}" \
        "${MYSQL_DATABASE}" "$@"
}

echo "Waiting for MySQL at ${MYSQL_HOST}..."
until mysqladmin --protocol=TCP \
    --host="${MYSQL_HOST}" \
    --user=root \
    --password="${MYSQL_ROOT_PASSWORD}" \
    ping --silent >/dev/null 2>&1; do
    sleep 2
done

mysql_root <<'SQL'
CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(255) NOT NULL,
    applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
SQL

for migration in /migrations/*.sql; do
    version=$(basename "${migration}")
    applied=$(mysql_root -Nse \
        "SELECT COUNT(*) FROM schema_migrations WHERE version = '${version}';")

    if [ "${applied}" = "1" ]; then
        echo "Skipping applied migration ${version}"
        continue
    fi

    echo "Applying migration ${version}"
    mysql_root < "${migration}"
    mysql_root -e \
        "INSERT INTO schema_migrations (version) VALUES ('${version}');"
done

for seed in /seed/*.sql; do
    version="seed_$(basename "${seed}")"
    applied=$(mysql_root -Nse "SELECT COUNT(*) FROM schema_migrations WHERE version = '${version}';")
    if [ "${applied}" = "1" ]; then
        echo "Skipping applied seed ${version}"
        continue
    fi
    echo "Applying seed ${seed}"
    mysql_root < "${seed}"
    mysql_root -e "INSERT INTO schema_migrations (version) VALUES ('${version}');"
done

if [ "${RUN_CHECKS:-0}" = "1" ]; then
    for check in /tests/*.sql; do
        if [ "$(basename "${check}")" = "customer_import_checks.sql" ] && [ "${RUN_CUSTOMER_IMPORT_CHECKS:-0}" != "1" ]; then
            echo "Skipping customer import checks: import fixture is not loaded"
            continue
        fi
        echo "Running database check ${check}"
        mysql_root < "${check}"
    done
fi

echo "Database setup completed."

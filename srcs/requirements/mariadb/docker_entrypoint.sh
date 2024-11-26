#!/bin/bash
set -e

mysqld_safe --skip-grant-tables &

echo "Waiting for MariaDB socket..."
while [ ! -S /run/mysqld/mysqld.sock ]; do
    sleep 1
done

while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

mysql -uroot <<-EOSQL
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

exec mysqld

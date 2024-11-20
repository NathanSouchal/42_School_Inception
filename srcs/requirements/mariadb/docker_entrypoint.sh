#!/bin/bash
set -e

# Debug : Afficher les variables d'environnement
echo "SQL_USER=$SQL_USER"
echo "SQL_ROOT_PASSWORD=$SQL_ROOT_PASSWORD"
echo "SQL_PASSWORD=$SQL_PASSWORD"
echo "SQL_DATABASE=$SQL_DATABASE"

# Démarrer MariaDB temporairement avec --skip-grant-tables pour contourner l'authentification
mysqld_safe --skip-grant-tables &

echo "Waiting for MariaDB socket..."
while [ ! -S /run/mysqld/mysqld.sock ]; do
    sleep 1
done

echo "MariaDB socket found. Starting initialization..."

# Attendre que le serveur soit prêt
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

echo "Setting the root password..."
mysql -uroot <<-EOSQL
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Stopping temporary MariaDB instance..."
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

echo "MariaDB initialization complete. Starting MariaDB in normal mode..."
exec mysqld

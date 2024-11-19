#!/bin/bash

# Attendre que MariaDB soit prêt
until mysql -h "mariadb" -u"${SQL_USER}" -p"${SQL_PASSWORD}" -e 'select 1' &>/dev/null; do
  echo "Waiting for MariaDB to be ready..."
  sleep 5
done

echo "MariaDB is ready!"

# Configurer WordPress avec WP-CLI
cd /var/www/wordpress
wp config create --dbname="${SQL_DATABASE}" --dbuser="${SQL_USER}" --dbpass="${SQL_PASSWORD}" --dbhost="mariadb:3306" --path='/var/www/wordpress' --allow-root
wp core install --url="localhost" --title="A beautiful website" --admin_user="nsouchal" --admin_password="${ADMIN_PASSWORD}" --admin_email="admin@example.com" --path='/var/www/wordpress' --allow-root
wp user create myuser myuser@example.com --role=author --user_pass="${USER_PASSWORD}" --path='/var/www/wordpress' --allow-root

# Exécuter le processus principal (PHP-FPM)
exec "$@"
#!/bin/bash

set -e

# Démarrer MariaDB en arrière-plan
service mysql start

# Exécuter les commandes SQL d'initialisation
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Démarrer MariaDB au premier plan
exec mysqld

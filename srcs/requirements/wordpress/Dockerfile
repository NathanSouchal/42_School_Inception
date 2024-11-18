# Utiliser l'image de base Debian Bullseye
FROM debian:bullseye

# Mettre à jour et installer les dépendances nécessaires
RUN apt update && apt upgrade -y && \
    apt-get install -y wget curl less php7.3 php-fpm php-mysql mariadb-client

# Télécharger et installer WordPress
RUN wget https://fr.wordpress.org/wordpress-6-0-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6-0-fr_FR.tar.gz && \
    rm wordpress-6-0-fr_FR.tar.gz

# Changer le propriétaire des fichiers WordPress
RUN chown -R www-data:www-data /var/www/wordpress

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configurer PHP-FPM
RUN echo "clear_env = no" >> /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i "s/^listen = .*/listen = wordpress:9000/" /etc/php/7.3/fpm/pool.d/www.conf

# Exécuter WP-CLI pour générer wp-config.php et configurer WordPress
RUN cd /var/www/wordpress && \
    wp config create --dbname="${SQL_DATABASE}" --dbuser="${SQL_USER}" --dbpass="${SQL_PASSWORD}" --dbhost="mariadb:3306" --path='/var/www/wordpress' --allow-root && \
    wp core install --url="http://nsouchal.42.fr" --title="A beautiful website" \
    --admin_user="nsouchal" --admin_password="${ADMIN_PASSWORD}" --admin_email="admin@example.com" --path='/var/www/wordpress' --allow-root && \
    wp user create myuser myuser@example.com --role=author --user_pass="${USER_PASSWORD}" --path='/var/www/wordpress' --allow-root

# Exposer le port pour PHP-FPM
EXPOSE 9000

# Démarrer PHP-FPM en mode premier plan
CMD ["php-fpm7.3", "-F"]

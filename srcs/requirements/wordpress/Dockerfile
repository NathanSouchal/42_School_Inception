# Utiliser l'image de base Debian Bullseye
FROM debian:bullseye

# Mettre à jour et installer les dépendances nécessaires
RUN apt update && apt upgrade -y && \
    apt-get install -y wget curl less php7.4 php7.4-fpm php-mysql mariadb-client

# Télécharger et installer WordPress
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.0.tar.gz && \
    rm wordpress-6.0.tar.gz

# Changer le propriétaire des fichiers WordPress
RUN chown -R www-data:www-data /var/www/wordpress

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configurer PHP-FPM
RUN echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s/^listen = .*/listen = wordpress:9000/" /etc/php/7.4/fpm/pool.d/www.conf

COPY config_wp.sh /config_wp.sh

RUN chmod +x /config_wp.sh

# # Exposer le port pour PHP-FPM
# EXPOSE 9000

# Définir le script config_wp.sh comme point d'entrée
ENTRYPOINT ["/config_wp.sh"]

# Démarrer PHP-FPM en mode premier plan
CMD ["php-fpm7.4", "-F"]


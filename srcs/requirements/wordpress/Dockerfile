FROM debian:bullseye

# Mise à jour et installation des paquets nécessaires
RUN apt update && apt upgrade -y && \
    apt-get install -y wget php7.3 php7.3-fpm php7.3-mysql mariadb-client

# Télécharger WordPress
RUN wget https://fr.wordpress.org/wordpress-6-0-fr_FR.tar.gz -P /var/www

# Extraire WordPress et supprimer l'archive
RUN cd /var/www && \
    tar -xzf wordpress-6-0-fr_FR.tar.gz && \
    rm wordpress-6-0-fr_FR.tar.gz

# Changer le propriétaire des fichiers WordPress
RUN chown -R root:root /var/www/wordpress

# Modifier la configuration de PHP-FPM
RUN echo "clear_env = no" >> /etc/php/7.3/fpm/pool.d/www.conf && \
    sed -i 's/^listen = .*/listen = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf
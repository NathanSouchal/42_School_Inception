FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt-get install -y wget curl less php7.4 php7.4-fpm php-mysql mariadb-client

RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.0.tar.gz && \
    rm wordpress-6.0.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s/^listen = .*/listen = wordpress:9000/" /etc/php/7.4/fpm/pool.d/www.conf

COPY config_wp.sh /config_wp.sh

RUN chmod +x /config_wp.sh

ENTRYPOINT ["/config_wp.sh"]

CMD ["php-fpm7.4", "-F"]


FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42/CN=nsouchal.42.fr/UID=nsouchal"

RUN chown www-data:www-data /etc/nginx/ssl/inception.* && \
chmod 644 /etc/nginx/ssl/inception.crt && \
chmod 600 /etc/nginx/ssl/inception.key

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
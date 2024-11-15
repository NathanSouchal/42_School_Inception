FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install -y nginx openssl

# Repertoire ou seront stocker les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Generation d'un certificat SSL auto-signe, x509 format standard de cert SSL, -nodes pas de mot de passe pour la key
RUN openssl req -x509 -nodes -out 
/etc/nginx/ssl/inception.crt -keyout
/etc/nginx/ssl/inception.key -subj
"/C=FR/ST=ARA/L=Lyon/0=42/OU=42/CN=nsouchal.42.fr/UID=nsouchal"

# Repertoire ou seront stocker les fichiers temporaires de config de Nginx
RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf
/etc/nginx/nginx.conf

# Permet au proprietaire de lire et d'executer les fichiers de ce repertoire (fichiers que le server web sert aux utilisateurs)
RUN chmod 755 /var/www/html

# Attribue la propriete de /var/www/html a www-data(l'utilisateur par defaut avec lequel fonctionne Nginx)
RUN chown -R www-data:www-data
/var/www/html

# Lance Nginx et fait en sorte qu'il s'execute au premier plan
CMD [ "nginx", "-g", "deamon off;" ]
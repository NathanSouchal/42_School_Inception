FROM debian:bullseye

# Met à jour le système et installe Nginx et OpenSSL
RUN apt update -y && apt upgrade -y && \
    apt install -y nginx openssl

# Crée le répertoire pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Génère un certificat SSL auto-signé
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42/CN=nsouchal.42.fr/UID=nsouchal"

# Ajuster les permissions des certificats SSL
RUN chown www-data:www-data /etc/nginx/ssl/inception.* && \
chmod 644 /etc/nginx/ssl/inception.crt && \
chmod 600 /etc/nginx/ssl/inception.key

# Crée un répertoire pour les fichiers temporaires de configuration de Nginx
RUN mkdir -p /var/run/nginx

# Copie le fichier nginx.conf dans le conteneur
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Assure que les fichiers dans /var/www/html ont les bonnes permissions pour l'utilisateur www-data
RUN chmod 755 /var/www/html

# Attribue la propriété de /var/www/html à www-data (utilisateur par défaut de Nginx)
RUN chown -R www-data:www-data /var/www/html

# Ouvre le port 443 pour le trafic HTTPS
EXPOSE 443

# Démarre Nginx en mode premier plan
CMD ["nginx", "-g", "daemon off;"]
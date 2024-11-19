FROM debian:bullseye

# Mise à jour et installation de MariaDB
RUN apt update -y && apt upgrade -y && \
    apt-get install mariadb-server -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier le fichier de configuration personnalisé
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copier le script d'initialisation
COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh

# Définir le script d'entrée et démarrer MariaDB
ENTRYPOINT ["/docker_entrypoint.sh"]

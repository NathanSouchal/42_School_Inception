FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt-get install mariadb-server -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh

ENTRYPOINT ["/docker_entrypoint.sh"]

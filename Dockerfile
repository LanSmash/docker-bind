FROM ubuntu:16.04

# Ubuntu updates
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DOCKERBIND_VERSION 2
ENV DATA_DIR=/data
ENV BIND_USER=bind

RUN apt-get update && apt-get install -y bind9 perl dnsutils && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 53/udp 53/tcp 953/tcp
VOLUME ["/etc/bind"]
VOLUME ["/var/lib/bind"]

RUN tar czvfP /etc/bind-defaults.tgz /etc/bind/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]


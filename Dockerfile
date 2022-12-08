FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    postgresql-client \
    pgpool2

COPY pgpool.conf /etc/pgpool2/pgpool.conf
COPY syslog.conf /etc/syslog.conf
COPY .env /app/.env

CMD ["pgpool", "-n"]
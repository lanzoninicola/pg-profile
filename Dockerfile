FROM ubuntu:18.04

# Update the package lists
RUN apt-get update

# Install wget
RUN apt-get -y install wget

# Install pgpool 2: https://www.pgpool.net/mediawiki/index.php/Apt_Repository
# ---
# Create the file repository configuration
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the repository signing key:
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install the latest version of Pgpool-II. Specify the specific version of PostgreSQL which you are using, e.g. postgresql-15-pgpool2:
RUN apt-get -y install pgpool2 libpgpool2 postgresql-10-pgpool2

# Install sqlite
RUN apt-get -y install sqlite3

COPY pgpool.conf /etc/pgpool2/pgpool.conf
COPY syslog.conf /etc/syslog.conf

VOLUME /var/lib/pglogger.db

CMD ["pgpool", "-n"]
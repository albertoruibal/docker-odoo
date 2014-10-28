FROM debian:stable
MAINTAINER Alberto Alonso Ruibal @albertoruibal

#
# Configure APT packages and upgrade
#
RUN echo deb http://nightly.odoo.com/7.0/nightly/deb/ ./ > /etc/apt/sources.list.d/openerp-70.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install locales

#
# Locale setup (if not set, PostgreSQL creates the database in SQL_ASCII)
#
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

#
# Install PostgreSQL, OpenERP and Supervisor
#
RUN apt-get install --allow-unauthenticated -y supervisor postgresql python2.6 openerp

#
# PostgreSQL: add user openerp
#
VOLUME  ["/var/lib/postgresql"]
RUN /etc/init.d/postgresql start && su postgres -c "createuser -s openerp"

#
# Supervisor setup
#
ADD etc/supervisor/conf.d/10_postgresql.conf /etc/supervisor/conf.d/10_postgresql.conf
ADD etc/supervisor/conf.d/20_openerp.conf /etc/supervisor/conf.d/20_openerp.conf

EXPOSE 8069
CMD ["/usr/bin/supervisord", "-n"]

FROM debian:stable

MAINTAINER Alberto Alonso Ruibal @albertoruibal

#
# APT packages
#
RUN echo deb http://nightly.odoo.com/7.0/nightly/deb/ ./ > /etc/apt/sources.list.d/openerp-70.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install --allow-unauthenticated -y supervisor postgresql python2.6 openerp

#
# PostgreSQL: recreate database with UTF-8 and create user openerp
#
ADD etc/supervisor/conf.d/10_postgresql.conf /etc/supervisor/conf.d/10_postgresql.conf
VOLUME  ["/var/lib/postgresql"]

RUN pg_dropcluster --stop 9.1 main
RUN pg_createcluster --locale en_US -e UTF-8 --start 9.1 main

RUN /etc/init.d/postgresql start && su postgres -c "createuser -s openerp "

#
# OpenERP
#
ADD etc/supervisor/conf.d/20_openerp.conf /etc/supervisor/conf.d/20_openerp.conf

EXPOSE 8069
CMD ["/usr/bin/supervisord", "-n"]

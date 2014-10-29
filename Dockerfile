FROM debian:stable
MAINTAINER Alberto Alonso Ruibal @albertoruibal

#
# Configure APT packages and upgrade
#
RUN echo deb http://nightly.odoo.com/7.0/nightly/deb/ ./ > /etc/apt/sources.list.d/openerp-70.list
RUN apt-get update
RUN apt-get upgrade -y

#
# Locale setup (if not set, PostgreSQL creates the database in SQL_ASCII)
#
RUN echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections &&\
    echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections
RUN apt-get install locales -qq
RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8

#
# Install PostgreSQL, OpenERP and Supervisor
#
RUN apt-get install --allow-unauthenticated -y supervisor postgresql python2.6 openerp

#
# Clean
#
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

#
# PostgreSQL: add user openerp and fix permissions
#
RUN /etc/init.d/postgresql start && su postgres -c "createuser -s openerp"
RUN chown -R postgres.postgres /var/lib/postgresql
#VOLUME  ["/var/lib/postgresql"]

#
# Supervisor setup
#
ADD etc/supervisor/conf.d/10_postgresql.conf /etc/supervisor/conf.d/10_postgresql.conf
ADD etc/supervisor/conf.d/20_openerp.conf /etc/supervisor/conf.d/20_openerp.conf

EXPOSE 8069
CMD ["/usr/bin/supervisord", "-n"]

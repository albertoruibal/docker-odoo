Docker-Odoo
===========
Odoo is an Python-powered open source ERP, previously called OpenERP http://www.odoo.com.

This is a Docker image with Odoo 7 and PostgreSQL ready to use.

It is based on Debian stable and includes:

* Odoo 7
* PostgreSQL 9.1
* Supervisor to run both

It only exposes the Odoo web interface at the port 8069.
The database can be created, backed-up and restored, etc. with this web interface.

Sample usage:

 docker run -d -p 8069:8069 --name myodoo7 albertoruibal/odoo7

and then access the web interface with your browser at http://localhost:8069
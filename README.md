Docker-Odoo
===========
Odoo is an Python-powered open source ERP, previously called OpenERP (http://www.odoo.com).

This is a Docker image with Odoo and PostgreSQL ready to use.

It is based on Debian stable and includes:

* Odoo 7 or 8 (selected with the repository tag)
* PostgreSQL 9.1
* Supervisor to run both

It only exposes the Odoo web interface at the port 8069.
The database can be created, backed-up and restored with this web interface.

Sample usage:

```
docker pull albertoruibal/odoo:7
docker run -d -p 8069:8069 --name myodoo albertoruibal/odoo:7
```

and then access the web interface with your browser at http://localhost:8069
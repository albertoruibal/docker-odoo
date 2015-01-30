Docker-Odoo
===========
Odoo is an Python-powered open source ERP, previously called OpenERP (http://www.odoo.com).

This is a Docker image with Odoo and PostgreSQL ready to use.

It is based on Debian stable and includes:

* Odoo 7 or 8 (selected with the repository tag)
* PostgreSQL 9.1
* Supervisor to run both

It only exposes the Odoo web interface at the port 8069.

This is a sample usage, create a container with name "myodoo":

```
docker pull albertoruibal/odoo:7
docker run -d -p 8069:8069 --name myodoo albertoruibal/odoo:7
```

and then access the Odoo web interface with your browser at http://localhost:8069

Backup and restore
==================

The databases can be created, backed-up and restored from the Odoo web interface accessing to the
link in the login page "Manage Databases". The default master password is "admin".

If the web interface fails to restore your database in OpenERP 7, you can restore it using the command line:
```
docker exec -i odoo7_mobialia /bin/su openerp -s /bin/bash -c "/usr/bin/createdb DATABASE_NAME -E utf8"
docker exec -i CONTAINER_NAME /bin/su openerp -s /bin/bash -c "/usr/bin/pg_restore -c -d DATABASE_NAME" < FILE_TO_RESTORE.dump
```
Where:

* CONTAINER_NAME: is the name of your Docker container, like "myodoo"
* DATABASE_NAME: name of the PosgreSQL database where you are going to restore the backup
* FILE_TO_RESTORE: a PostgreSQL dump file with the backup (the web interface backup generates this kind of files)
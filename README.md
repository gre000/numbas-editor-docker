**Numbas** is an open-source system for creating tests which run entirely in the browser. It has been developed by [Newcastle University's School of Mathematics, Statistics and Physics](http://www.ncl.ac.uk/maths-physics).

For more information about Numbas and what it does, see on their website at [numbas.org.uk](http://www.numbas.org.uk).

### Numbas-docker
Now you can run your local or cloud instance of Numbas in several minutes.  

* Dockerfile - describes how to build the image.
* stack.yml - describes how to run Numbas with PostgreSQL db.
  - docker stack deploy --compose-file stack.yml stack
  - please be sure you don't use default PostgreSQL password

* Migrations (on empty db)
 - should be patched editor/migrations/0014_version_2_data_migration.py
 - comment out 458-470
 - python manage.py migrate



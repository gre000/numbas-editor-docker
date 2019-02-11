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


### Copyright

> Copyright 2019 Yura Beznos
> 
> Licensed under the Apache License, Version 2.0 (the "License");
> you may not use this file except in compliance with the License.
> You may obtain a copy of the License at
> 
> http://www.apache.org/licenses/LICENSE-2.0
> 
> Unless required by applicable law or agreed to in writing, software
> distributed under the License is distributed on an "AS IS" BASIS,
> WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> See the License for the specific language governing permissions and
> limitations under the License.

You can see a plain-English explanation of the license and what it allows at [tl;drLegal](https://tldrlegal.com/license/apache-license-2.0-%28apache-2.0%29)
   
Copyright in the content produced using Numbas-docker resides with the author.

This repository contains files to build a Docker image for the Numbas editor, and run it.

For more information about Numbas and what it does, see the Numbas website: [numbas.org.uk](http://www.numbas.org.uk).

This has only been tested on a desktop PC; some changes might need to be made to get this running on a cloud service.

### What you need

* [Docker](https://www.docker.com/). If you haven't used Docker before, follow the [installation guide for Docker CE](https://docs.docker.com/install/) on your desktop.

### How to run it

This uses several Docker secrets, which must be set up before you run the containers.

Run the following, after changing the passwords:

```
python -c 'from string import ascii_letters as chars; import random; result = "".join([random.choice(chars) for i in range(50)]); print(result)' | docker secret create numbas_editor -
echo "adminpass" | docker secret create numbas_admin_password -
echo "postgrespass" | docker secret create postgres_password -
```

(Remember to change the passwords!)

Run:

```
docker build --tag=numbas .
```

to build the Numbas Docker image.

Then, start it up with:

```
docker stack up --compose-file stack.yml numbas
```

If everything goes well, the Numbas editor will be available at http://localhost:8080.
You can log in with the username `admin` and the password you saved under the secret `numbas_admin_password`.

If things don't work, you can look at which containers are running with ``docker ps -a``, and see the output of a container with ``docker logs $CONTAINER_ID``.

### Copyright

> Copyright 2019 Yura Beznos, Christian Lawson-Perfect
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

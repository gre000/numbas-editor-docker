#!/bin/bash
python3 -c 'from string import ascii_letters as chars; import random; result = "".join([random.choice(chars) for i in range(50)]); print(result)' >> ./secrets/numbas_editor
echo "adminpass" >> ./secrets/numbas_admin_password
echo "postgrespass" >> ./secrets/postgres_password
#!/bin/bash

create_superuser="
import django
django.setup()
from django.contrib.auth.models import User

with open('/run/secrets/numbas_admin_password') as f:
    password = f.read().strip()

try:
    User.objects.create_superuser('$ADMIN_USERNAME', '$ADMIN_EMAIL', password)
except Exception:
    pass
"
echo "Running migrations"
# Apply database migrations
python3 manage.py migrate
# Collect static files
echo "Running collectstatic"
python3 manage.py collectstatic --noinput

if [ -z "$ADMIN_USERNAME" ] || [ -z "$ADMIN_EMAIL" ]; then
    echo "Environment variables for database not set, not creating superuser."
else
    echo "Creating superuser"
    DJANGO_SETTINGS_MODULE=numbas.settings python3 -c "$create_superuser"
fi

apachectl -D FOREGROUND

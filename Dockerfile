FROM ubuntu:bionic

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y update;\
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
    git-core \
    mysql-common \
    python3 \
    acl \
    python-dev \
    python-tk \
    tcl-dev \
    tk-dev \
    python3-pip \
    python3-virtualenv \
    virtualenv \
    sudo \
    libjpeg-dev \
    apache2 \
    apache2-dev \
    libapache2-mod-wsgi-py3 &&\
    mkdir /srv/numbas &&\
    mkdir /srv/numbas/compiler &&\
    mkdir /srv/numbas/media &&\
    mkdir /srv/numbas/previews &&\
    mkdir /srv/numbas/static &&\
    git clone git://github.com/numbas/Numbas /srv/numbas/compiler --branch v3.0 &&\
    git clone git://github.com/numbas/editor /srv/www/numbas_editor --branch v3.0


RUN groupadd numbas &&\
    useradd numbas -g numbas -ms /bin/bash

SHELL ["/bin/bash", "-c"]
ADD settings.py /srv/www/numbas_editor/numbas/settings.py
ADD apache2_ubuntu.conf /etc/apache2/sites-available/numbas_editor.conf
RUN mkdir /opt/python &&\
    setfacl -dR -m g:numbas:rwx /opt/python &&\
    virtualenv -p python3 /opt/python/numbas-editor &&\
    source /opt/python/numbas-editor/bin/activate &&\
    cd /srv/numbas &&\
    chmod 2770 media previews &&\
    chmod 2750 compiler static &&\
    chgrp www-data compiler media previews static &&\
    setfacl -dR -m g::rwX media previews &&\
    setfacl -dR -m g::rX compiler static &&\
    pip install -r /srv/www/numbas_editor/requirements.txt &&\
    pip install -r /srv/numbas/compiler/requirements.txt &&\
    pip install psycopg2-binary mod_wsgi &&\
    cd /srv/www/numbas_editor &&\
    python manage.py collectstatic --noinput

RUN a2dissite 000-default &&\
    a2ensite numbas_editor.conf &&\
    echo "python_home = '/opt/python/numbas-editor'" >> /srv/www/numbas_editor/web/django.wsgi &&\
    echo "activate_this = python_home + '/bin/activate_this.py'" >> /srv/www/numbas_editor/web/django.wsgi && \
    echo "exec(open(activate_this).read(), dict(__file__=activate_this))" >> /srv/www/numbas_editor/web/django.wsgi &&\
    cat /srv/www/numbas_editor/web/django.wsgi.dist >> /srv/www/numbas_editor/web/django.wsgi &&\
    ln -sf /proc/self/fd/1 /var/log/apache2/access.log &&\
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

    
CMD EXPOSE 80
CMD apachectl -D FOREGROUND


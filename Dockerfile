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
    sudo \
    libjpeg-dev \
    apache2 \
    apache2-dev \
    libapache2-mod-wsgi-py3

RUN mkdir /srv/numbas &&\
    mkdir /srv/numbas/compiler &&\
    mkdir /srv/numbas/media &&\
    mkdir /srv/numbas/previews &&\
    mkdir /srv/numbas/static

RUN git clone git://github.com/numbas/Numbas /srv/numbas/compiler --branch master &&\
    git clone git://github.com/numbas/editor /srv/www/numbas_editor --branch master

RUN groupadd numbas &&\
    useradd numbas -g numbas -ms /bin/bash

SHELL ["/bin/bash", "-c"]

RUN cd /srv/numbas &&\
    chmod 2770 media previews &&\
    chmod 2750 compiler static &&\
    chgrp www-data compiler media previews static &&\
    setfacl -dR -m g::rwX media previews &&\
    setfacl -dR -m g::rX compiler static &&\
    pip3 install -r /srv/www/numbas_editor/requirements.txt &&\
    pip3 install -r /srv/numbas/compiler/requirements.txt &&\
    pip3 install psycopg2-binary mod_wsgi

ADD apache2_ubuntu.conf /etc/apache2/sites-available/numbas_editor.conf

RUN a2dissite 000-default &&\
    a2ensite numbas_editor.conf &&\
    cp /srv/www/numbas_editor/web/django.wsgi.dist /srv/www/numbas_editor/web/django.wsgi &&\
    ln -sf /proc/self/fd/1 /var/log/apache2/access.log &&\
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

WORKDIR /srv/www/numbas_editor

ADD settings.py /srv/www/numbas_editor/numbas/settings.py

RUN python3 manage.py collectstatic --noinput

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ADD content/* editor/templates/

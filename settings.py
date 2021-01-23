"""
For more information on this file, see
https://docs.djangoproject.com/en/2.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/2.0/ref/settings/
"""

import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

try:
    with open('/var/run/secrets/numbas_editor') as f:
        SECRET_KEY = f.read()
except FileNotFoundError:
    SECRET_KEY = os.environ.get('SECRET_KEY','secret')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('DEBUG',False)

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = [
    'accounts',
    'editor',

    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',

    'django.contrib.humanize',
    'sanitizer',
    'notifications',
    'analytical',
    'reversion',
    'registration',
    'django_tables2',
    'taggit',
    'el_pagination',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'numbas.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                "django.template.context_processors.i18n",
                "django.template.context_processors.media",
                "django.template.context_processors.static",
                "editor.context_processors.global_settings",
                "editor.context_processors.site_root",
            ],
        },
    },
]

SITE_ID = 1

# Database
# https://docs.djangoproject.com/en/2.0/ref/settings/#databases

try:
    with open('/var/run/secrets/postgres_password') as f:
        postgres_password = f.read().strip()
except FileNotFoundError:
    postgres_password = os.environ.get('POSTGRES_PASSWORD','postgrs')


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': postgres_password,
        'HOST': 'postgres',
        'PORT': '',
    }
}


# Password validation
# https://docs.djangoproject.com/en/2.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/2.0/topics/i18n/

LANGUAGE_CODE = 'en-gb'

TIME_ZONE = 'Europe/London'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.0/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = '/srv/numbas/static/'

SITE_TITLE = 'Quizhopper'

MATHJAX_URL = 'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0'

MEDIA_ROOT = '/srv/numbas/media/'
MEDIA_URL = '/media/'

GLOBAL_SETTINGS = {
    'NUMBAS_PATH': '/srv/numbas/compiler/',
    'PREVIEW_PATH': '/srv/numbas/previews/',
    'PREVIEW_URL': '/previews/',    # a URL which serves files from PREVIEW_PATH
    'HELP_URL': 'https://docs.numbas.org.uk/en/latest/',        # the URL of the Numbas webdocs
    'PYTHON_EXEC': 'python3',
    'NUMBAS_THEMES': [('Standard', 'default'), ('Printable worksheet', 'worksheet'), ('School', 'school')],
    'NUMBAS_LOCALES': [
        ('English','en-GB'),
        ('Deutsch','de-DE'),
        ('Nederlands','nl-NL'),
        ('Polski (incomplete)','pl-PL'),
        ('Shqip','sq-AL'),
        ('Svenska','sv-SE'),
        ('School English','en-school'),
    ],
    #Uncomment the line below and provide a path to a minification tool to minify javascript files
    #'MINIFIER_PATH': 'uglifyjs',
}

EVERYTHING_VISIBLE = False  # Set this to True to allow every user to see all content, regardless of access settings

ALLOW_REGISTRATION = True
ACCOUNT_ACTIVATION_DAYS = 10

LOGIN_REDIRECT_URL = '/'
LOGIN_URL = '/login/'
CAN_LOGOUT = True
CAN_CHANGE_PASSWORD = True

sys.path.append(os.path.join(GLOBAL_SETTINGS['NUMBAS_PATH'],'bin'))

SANITIZER_ALLOWED_TAGS = ['a', 'p', 'img','br','strong','em','div','code','i','b', 'ul', 'ol', 'li', 'table','thead','tbody','td','th','tr']
SANITIZER_ALLOWED_ATTRIBUTES = ['href','title']

DEFAULT_FROM_EMAIL = 'admin@quizhopper.de'

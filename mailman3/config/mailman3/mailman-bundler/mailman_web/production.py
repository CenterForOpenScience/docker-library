#-*- coding: utf-8 -*-
"""
Django settings for HyperKitty + Postorius
"""

import os
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
VAR_DIR = "/var/spool"

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'change-that-at-install-time'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

TEMPLATE_DEBUG = DEBUG

ADMINS = (
     ('Mailman Admin', 'root@localhost'),
)

# Hosts/domain names that are valid for this site; required if DEBUG is False
# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
ALLOWED_HOSTS = ["localhost", "mechanysm.com", "*"]
# And for BrowserID too, see
# http://django-browserid.rtfd.org/page/user/settings.html#django.conf.settings.BROWSERID_AUDIENCES
BROWSERID_AUDIENCES = [ "http://localhost", "http://localhost:8000", "http://mechanysm.com:18000", "http://mechanysm.com:8000" ]

# Mailman API credentials
MAILMAN_REST_API_URL = 'http://mailman.local:8001'
MAILMAN_REST_API_USER = 'apollo'
MAILMAN_REST_API_PASS = 'FPbM!!yfU!GaQpPSkYl3'
MAILMAN_ARCHIVER_KEY = 'SecretArchiverAPIKey'
MAILMAN_ARCHIVER_FROM = ('127.0.0.1', '::1', '::ffff:127.0.0.1')

# Application definition

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    #'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # Uncomment the next line to enable the admin:
    'django.contrib.admin',
    # Uncomment the next line to enable admin documentation:
    # 'django.contrib.admindocs',
    'hyperkitty',
    'social.apps.django_app.default',
    'rest_framework',
    'django_gravatar',
    'crispy_forms',
    'paintstore',
    'compressor',
    'django_browserid',
    'haystack',
    'django_extensions',
    'postorius',
)


MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    # Uncomment the next line for simple clickjacking protection:
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'hyperkitty.middleware.SSLRedirect',
    'hyperkitty.middleware.TimezoneMiddleware',
)

ROOT_URLCONF = 'mailman_web.urls'


#
# Postorius
#

# CSS theme for postorius
MAILMAN_THEME = "default"

## Email confirmation / address activation
# Add a from-address for email-confirmation:
# EMAIL_CONFIRMATION_FROM = 'postmaster@example.org'

# These can be set to override the defaults but are not mandatory:
# EMAIL_CONFIRMATION_TEMPLATE = 'postorius/address_confirmation_message.txt'
# EMAIL_CONFIRMATION_SUBJECT = 'Confirmation needed'



# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2', # Last part is one of 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'mailmanweb',  # Example, change as needed
        'USER': 'mailmanweb',  # Example, change as needed
        'PASSWORD': 'change-this-password',  # Example, obviously
        'HOST': '127.0.0.1',   # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
        'PORT': '',            # Set to empty string for default.
    }
}


# If you're behind a proxy, use the X-Forwarded-Host header
# See https://docs.djangoproject.com/en/1.5/ref/settings/#use-x-forwarded-host
#USE_X_FORWARDED_HOST = True
# And if your proxy does your SSL encoding for you, set SECURE_PROXY_SSL_HEADER
# see https://docs.djangoproject.com/en/1.5/ref/settings/#secure-proxy-ssl-header
#SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'America/Chicago'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/var/www/example.com/media/"
MEDIA_ROOT = ''

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://example.com/media/", "http://media.example.com/"
MEDIA_URL = ''

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/var/www/example.com/static/"
#STATIC_ROOT = ''
STATIC_ROOT = os.path.join(VAR_DIR, "mailman-web", "static")

# URL prefix for static files.
# Example: "http://example.com/static/", "http://static.example.com/"
STATIC_URL = '/static/'

# Additional locations of static files
STATICFILES_DIRS = (
    # Put strings here, like "/home/html/static" or "C:/www/django/static".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
    'compressor.finders.CompressorFinder',
)


TEMPLATE_CONTEXT_PROCESSORS = (
    "django.contrib.auth.context_processors.auth",
    "django.contrib.messages.context_processors.messages",
    "django.core.context_processors.debug",
    "django.core.context_processors.i18n",
    "django.core.context_processors.media",
    "django.core.context_processors.static",
    "django.core.context_processors.csrf",
    "django.core.context_processors.request",
    "django.core.context_processors.tz",
    "django.contrib.messages.context_processors.messages",
    "social.apps.django_app.context_processors.backends",
    "social.apps.django_app.context_processors.login_redirect",
    "hyperkitty.context_processors.export_settings",
    "hyperkitty.context_processors.postorius_info",
    "postorius.context_processors.postorius",
)

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
)

# Django 1.6+ defaults to a JSON serializer, but it won't work with django-openid, see
# https://bugs.launchpad.net/django-openid-auth/+bug/1252826
SESSION_SERIALIZER = 'django.contrib.sessions.serializers.PickleSerializer'


LOGIN_URL          = 'hk_user_login'
LOGOUT_URL         = 'hk_user_logout'
LOGIN_REDIRECT_URL = 'hk_root'

# Use the email username as identifier, but truncate it because
# the User.username field is only 30 chars long.
def username(email):
    return email.rsplit('@', 1)[0][:30]
BROWSERID_USERNAME_ALGO = username
BROWSERID_VERIFY_CLASS = "django_browserid.views.Verify"



#
# Social auth
#

AUTHENTICATION_BACKENDS = (
    #'social.backends.open_id.OpenIdAuth',
    # http://python-social-auth.readthedocs.org/en/latest/backends/google.html
    'social.backends.google.GoogleOpenId',
    #'social.backends.google.GoogleOAuth2',
    #'social.backends.twitter.TwitterOAuth',
    'social.backends.yahoo.YahooOpenId',
    'django_browserid.auth.BrowserIDBackend',
    'django.contrib.auth.backends.ModelBackend',
)

# http://python-social-auth.readthedocs.org/en/latest/pipeline.html#authentication-pipeline
SOCIAL_AUTH_PIPELINE = (
    'social.pipeline.social_auth.social_details',
    'social.pipeline.social_auth.social_uid',
    'social.pipeline.social_auth.auth_allowed',
    'social.pipeline.social_auth.social_user',
    'social.pipeline.user.get_username',
    # Associates the current social details with another user account with
    # a similar email address. Disabled by default, enable with care:
    # http://python-social-auth.readthedocs.org/en/latest/use_cases.html#associate-users-by-email
    #'social.pipeline.social_auth.associate_by_email',
    'social.pipeline.user.create_user',
    'social.pipeline.social_auth.associate_user',
    'social.pipeline.social_auth.load_extra_data',
    'social.pipeline.user.user_details',
    'hyperkitty.lib.mailman.add_user_to_mailman',
)



#
# Gravatar
# https://github.com/twaddington/django-gravatar
#
# Gravatar base url.
#GRAVATAR_URL = 'http://cdn.libravatar.org/'
# Gravatar base secure https url.
#GRAVATAR_SECURE_URL = 'https://seccdn.libravatar.org/'
# Gravatar size in pixels.
#GRAVATAR_DEFAULT_SIZE = '80'
# An image url or one of the following: 'mm', 'identicon', 'monsterid', 'wavatar', 'retro'.
#GRAVATAR_DEFAULT_IMAGE = 'mm'
# One of the following: 'g', 'pg', 'r', 'x'.
#GRAVATAR_DEFAULT_RATING = 'g'
# True to use https by default, False for plain http.
#GRAVATAR_DEFAULT_SECURE = True

#
# django-compressor
# https://pypi.python.org/pypi/django_compressor
#
COMPRESS_PRECOMPILERS = (
   ('text/x-scss', 'sass {infile} {outfile}'),
   ('text/x-sass', 'sass {infile} {outfile}'),
)
COMPRESS_OFFLINE = True
# needed for debug mode
#INTERNAL_IPS = ('127.0.0.1',)

# Django Crispy Forms
CRISPY_TEMPLATE_PACK = 'bootstrap3'
CRISPY_FAIL_SILENTLY = not DEBUG

# Compatibility with Bootstrap 3
from django.contrib.messages import constants as messages
MESSAGE_TAGS = {
    messages.ERROR: 'danger'
}


#
# Full-text search engine
#
HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.whoosh_backend.WhooshEngine',
        'PATH': os.path.join(VAR_DIR, "mailman-web", "fulltext_index"),
    },
}


# A sample logging configuration. The only tangible logging
# performed by this configuration is to send an email to
# the site admins on every HTTP 500 error when DEBUG=False.
# See http://docs.djangoproject.com/en/dev/topics/logging for
# more details on how to customize your logging configuration.
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'file':{
            'level': 'INFO',
            #'class': 'logging.handlers.RotatingFileHandler',
            'class': 'logging.handlers.WatchedFileHandler',
            'filename': '/var/log/mailman-web/mailman-web.log',
            'formatter': 'verbose',
        },
    },
    'loggers': {
        #'django.request': {
        #    'handlers': ['mail_admins'],
        #    'level': 'ERROR',
        #    'propagate': True,
        #},
        'django.request': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        },
        'django': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        },
        'hyperkitty': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        },
        'postorius': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        },
    },
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'root': {
        'handlers': ['file'],
        'level': 'INFO',
    },
}


## Cache: use the local memcached server
#CACHES = {
#    'default': {
#        'BACKEND': 'django.core.cache.backends.memcached.PyLibMCCache',
#        'LOCATION': '127.0.0.1:11211',
#    }
#}



#
# HyperKitty-specific
#

APP_NAME = 'Mailing-list archives'

# Allow authentication with the internal user database?
# By default, only a login through Persona or your email provider is allowed.
USE_INTERNAL_AUTH = True

# Use SSL when logged in. You need to enable the SSLRedirect middleware for
# this feature to work.
USE_SSL = False

# Only display mailing-lists from the same virtual host as the webserver
FILTER_VHOST = False

# This is for development purposes
USE_MOCKUPS = False


try:
    from settings_local import *
except ImportError:
    pass

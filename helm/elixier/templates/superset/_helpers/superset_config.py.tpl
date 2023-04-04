# vim: set syntax=python:
{{ define "superset-config" }}
from celery.schedules import crontab
from flask_caching.backends.rediscache import RedisCache
from selenium import webdriver

import os

FEATURE_FLAGS = {
    'THUMBNAILS': True,
    'THUMBNAILS_SQLA_LISTENERS': True,
    'ALERT_REPORTS': True,
    'ALERTS_ATTACH_REPORTS': True,
    'ENABLE_EXPLORE_DRAG_AND_DROP': True,
    'EMBEDDED_SUPERSET': True,
    'DASHBOARD_RBAC': True,
    'ENABLE_DND_WITH_CLICK_UX': True,
    'LISTVIEWS_DEFAULT_CARD_VIEW': True,
    'DASHBOARD_CROSS_FILTERS': True,
}

ALERT_REPORTS_NOTIFICATION_DRY_RUN = False

SCREENSHOT_LOCATE_WAIT = 100
SCREENSHOT_LOAD_WAIT = 600

SECRET_KEY = os.environ.get('SUPERSET_SECRET_KEY', "{{ .Values.secrets.secret_key }}")
if os.environ.get('SUPERSET_PREVIOUS_SECRET_KEY', "{{ .Values.secrets.previous_secret_key }}"):
    PREVIOUS_SECRET_KEY = os.environ.get('SUPERSET_PREVIOUS_SECRET_KEY')

SQLALCHEMY_DATABASE_URI='{{ include "elixier.superset.db_uri" . }}'
DATA_DIR = "/var/lib/superset"
class CeleryConfig:  # pylint: disable=too-few-public-methods
    BROKER_URL = 'redis://{{ include "elixier.fullname" . }}-redis:6379/3'
    CELERY_IMPORTS = ("superset.sql_lab", "superset.tasks",
                      "superset.tasks.thumbnails")
    CELERY_RESULT_BACKEND = 'redis://{{ include "elixier.fullname" . }}-redis:6379/4'
    CELERYD_LOG_LEVEL = '{{ .Values.superset.celeryd_debug_level | default "INFO" }}'
    CELERYD_PREFETCH_MULTIPLIER = 10
    CELERY_ACKS_LATE = True
    CELERY_ANNOTATIONS = {
        "sql_lab.get_sql_results": {"rate_limit": "100/s"},
        "email_reports.send": {
            "rate_limit": "1/s",
            "time_limit": 120,
            "soft_time_limit": 150,
            "ignore_result": True,
        },
    }
    CELERYBEAT_SCHEDULE = {
        "email_reports.schedule_hourly": {
            "task": "email_reports.schedule_hourly",
            "schedule": crontab(minute=1, hour="*"),
        },
        "reports.scheduler": {
            "task": "reports.scheduler",
            "schedule": crontab(minute="*", hour="*"),
        },
        "reports.prune_log": {
            "task": "reports.prune_log",
            "schedule": crontab(minute=0, hour=0),
        },
    }

CELERY_CONFIG = CeleryConfig

RESULTS_BACKEND = RedisCache(
    host='{{ include "elixier.fullname" . }}-redis', 
    port=6379, db=5, key_prefix='superset_results')

THUMBNAIL_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24 * 7,
    'CACHE_KEY_PREFIX': 'superset_thumbnail',
    'CACHE_REDIS_URL': 'redis://{{ include "elixier.fullname" . }}-redis:6379/6',
}

DATA_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,
    'CACHE_KEY_PREFIX': 'superset_datacache',
    'CACHE_REDIS_URL': 'redis://{{ include "elixier.fullname" . }}-redis:6379/6',
}

FILTER_STATE_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,
    'CACHE_KEY_PREFIX': 'superset_filterstate',
    'CACHE_REDIS_URL': 'redis://{{ include "elixier.fullname" . }}-redis:6379/6',
}

EXPLORE_FORM_DATA_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,
    'CACHE_KEY_PREFIX': 'superset_exploreform',
    'CACHE_REDIS_URL': 'redis://{{ include "elixier.fullname" . }}-redis:6379/6',
}

{{ if .Values.smtp.enabled }}
# smtp server configuration
EMAIL_NOTIFICATIONS = True  # all the emails are sent using dryrun
SMTP_HOST = {{ .Values.smtp.host | quote }}
{{ if .Values.smtp.use_tls }}
SMTP_STARTTLS = True
{{ else }}
SMTP_STARTTLS = False
{{ end }}
{{ if .Values.smtp.use_ssl }}
SMTP_SSL = True
{{ else }}
SMTP_SSL = False
{{ end }}
SMTP_USER = {{ .Values.smtp.username | quote }}
SMTP_PORT = {{ .Values.smtp.port }}
SMTP_PASSWORD = {{ .Values.smtp.password | quote }}
SMTP_MAIL_FROM = {{ .Values.smtp.from | quote }}
{{ end }}

PREFERRED_DATABASES = [
    "Trino",
    "PostgreSQL",
    "MySQL",
]

WEBDRIVER_BASEURL = 'http://{{ include "elixier.fullname" . }}-superset/'
WEBDRIVER_BASEURL_USER_FRIENDLY = 'http://superset.{{ .Values.ingress.domain }}'
WEBDRIVER_TYPE = "chrome"
WEBDRIVER_OPTION_ARGS = [
    "--headless",
]

webdrv_opts = webdriver.ChromeOptions()
webdrv_opts.add_argument("--headless")
webdrv_opts.add_argument("--no-sandbox")
webdrv_opts.add_argument("--window-size=800,600")
webdrv_opts.add_argument("--disable-dev-shm-usage")
webdrv_opts.add_argument("--ignore-certificate-errors")

WEBDRIVER_CONFIGURATION = {
   "executable_path": "/usr/bin/chromedriver",
   "service_log_path": "/var/log/superset/chromedriver",
   "options": webdrv_opts
}

UPLOAD_FOLDER = '/var/lib/superset/uploads'
UPLOAD_FOLDER = '/var/lib/superset/'

{{ if .Values.keycloak.enabled }}
from flask_appbuilder.security.manager import AUTH_OAUTH

AUTH_ROLES_SYNC_AT_LOGIN = True
AUTH_ROLES_MAPPING = {
  "superset_admin": ["Admin"],
  "superset_alpha": ["Alpha"],
  "superset_gamma": ["Gamma"],
}

AUTH_TYPE = AUTH_OAUTH

from elixier_ss_custom import KeycloakSecurityManager

CUSTOM_SECURITY_MANAGER = KeycloakSecurityManager

AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = 'Public'
PUBLIC_ROLE_LIKE = "Gamma"

OAUTH_PROVIDERS = [
    {
        'name': 'keycloak',
        'token_key': 'access_token',
        'icon': 'fa-address-card',
        'remote_app': {
            'client_id': '{{ .Values.keycloak.client_id }}',
            'client_secret': '{{ .Values.keycloak.client_secret }}',
            'client_kwargs': {
                'scope': 'openid email profile roles'
            },
            'access_token_method': 'POST',
            'api_base_url': '{{ include "elixier.keycloak.api_base_url" . }}/',
            'access_token_url': '{{ include "elixier.keycloak.token_endpoint" . }}',
            'authorize_url': '{{ include "elixier.keycloak.authorization_endpoint" . }}',
            'server_metadata_url': '{{ include "elixier.keycloak.server_metadata_url" . }}'
        },
    }
]
{{ end }}

{{ if .Values.superset.mapbox_token }}
MAPBOX_API_KEY = {{ .Values.superset.mapbox_token | quote }}
{{ end }}

{{- end }}



# vim: set syntax=python: 
{{- define "airflow-webserver-config" }}

"""Default configuration for the Airflow webserver"""
import os

from airflow.www.fab_security.manager import AUTH_DB
basedir = os.path.abspath(os.path.dirname(__file__))
WTF_CSRF_ENABLED = True
AUTH_TYPE = AUTH_DB

{{ if .Values.keycloak.enabled }}
from flask_appbuilder.security.manager import AUTH_OAUTH
import logging
import json
logger = logging.getLogger('airflow-custom')

from airflow.www.security import AirflowSecurityManager

AUTH_ROLES_SYNC_AT_LOGIN = True
AUTH_ROLES_MAPPING = {
  "airflow_admin": ["Admin"],
  "airflow_op": ["Op"],
  "airflow_user": ["User"],
  "airflow_viewer": ["Viewer"],
  "airflow_public": ["Public"],
}

class KeycloakSecurityManager(AirflowSecurityManager):

    def oauth_user_info(self, provider, response=None):
        logging.debug("Oauth2 provider: {0}.".format(provider))

        logging.debug("Oauth2 oauth_remotes provider: {0}.".format(self.appbuilder.sm.oauth_remotes[provider]))

        if provider == 'keycloak':
            # Get the user info using the access token
            res = self.appbuilder.sm.oauth_remotes[provider].get('userinfo')

            logger.info(f"userinfo response:")
            for attr, value in vars(res).items():
                print(attr, '=', value)

            if res.status_code != 200:
                logger.error('Failed to obtain user info: %s', res._content)
                return

            #dict_str = res._content.decode("UTF-8")
            me = json.loads(res._content)

            logger.debug(" user_data: %s", me)
            return {
                'username' : me['preferred_username'],
                'name' : me['name'],
                'email' : me['email'],
                'first_name': me['given_name'],
                'last_name': me['family_name'],
                'role_keys': me['roles'],
                'is_active': True,
            }
        return {}

AUTH_TYPE = AUTH_OAUTH

SECURITY_MANAGER_CLASS = KeycloakSecurityManager

AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = 'Viewer'

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



{{ end }}


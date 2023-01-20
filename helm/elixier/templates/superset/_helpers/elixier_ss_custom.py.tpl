# vim: set syntax=python:
{{ define "superset-custom-module" }}
import logging
import json
logger = logging.getLogger('superset-custom')

from superset.security import SupersetSecurityManager

class KeycloakSecurityManager(SupersetSecurityManager):

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
                'roles': me['roles'],
                'is_active': True,
            }

    def auth_user_oauth(self, userinfo):
        user = super(KeycloakSecurityManager, self).auth_user_oauth(userinfo)
        roles = [self.find_role(x.replace('{{ .Values.keycloak.superset_role_prefix | default "superset" }}-', '').capitalize()) for x in userinfo['roles'] if x.startswith('superset')]
        roles = [x for x in roles if x is not None]
        if not roles:
           roles = ['Public']
        user.roles = roles
        logger.debug(' Update <User: %s> role to %s', user.username, roles)
        self.update_user(user)  # update user roles
        return user
{{ end }}

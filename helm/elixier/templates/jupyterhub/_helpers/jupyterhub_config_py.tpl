# vim: set syntax=python:
{{- define "jupyterhub-config" -}}
import os, nativeauthenticator
import socket
from kubespawner.objects import make_owner_reference
import json

c.JupyterHub.db_url = '{{ include "elixier.jupyterhub.db_uri" . }}'
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'
c.JupyterHub.template_paths = [os.path.join(
    os.path.dirname(nativeauthenticator.__file__), '/templates/')]
c.Authenticator.admin_users = {'admin'}
c.JupyterHub.spawner_class = 'kubespawner.KubeSpawner'
c.JupyterHub.hub_ip = socket.gethostbyname(socket.gethostname())
c.KubeSpawner.cmd = ["/opt/elixier/jupyterhub/bin/entrypoint.sh", "jupyterhub-singleuser"]

c.KubeSpawner.pod_name_template = '{{ include "elixier.name" . }}-nb-{username}'
c.KubeSpawner.extra_pod_config = {
    "setHostnameAsFQDN": True,
    "subdomain": '{{ include "elixier.name" . }}',
}
c.KubeSpawner.extra_labels = {
    'app.kubernetes.io/name': '{{ include "elixier.name" . }}',
    'app.kubernetes.io/instance': '{{ .Release.Name }}',
    'component': 'jupyterhub',
    'subcomponent': 'notebook'
}
c.KubeSpawner.dns_name_template = '{name}.{{ include "elixier.fullname" . }}.{namespace}.svc.cluster.local'
c.KubeSpawner.service_account = '{{ include "elixier.serviceAccountName" . }}'
c.KubeSpawner.automount_service_account_token = True
c.KubeSpawner.image_spec = "{{ .Values.core_image.repository }}:{{ .Values.core_image.tag }}"
c.KubeSpawner.image_pull_policy = "{{ .Values.core_image.pullPolicy }}"
{{- with .Values.imagePullSecrets }}
c.KubeSpawner.image_pull_secrets "{{- toYaml . -}}"
{{- end }}

c.KubeSpawner.storage_access_modes = ['{{ .Values.storageAccessMode | default "ReadWriteMany" }}']
c.KubeSpawner.storage_capacity = '{{ .Values.jupyterhub.nb_storage_capacity | default "1Gi" }}'
c.KubeSpawner.fs_gid = 1000
{{- if .Values.storageClass }}
c.KubeSpawner.storage_class = "{{ .Values.storageClass }}"
{{- end }}
c.KubeSpawner.pvc_name_template = 'pvc-{{ include "elixier.fullname" . }}-{username}'
c.KubeSpawner.storage_pvc_ensure = True
c.KubeSpawner.volumes = [
  {
    'name': 'vol-{{ include "elixier.fullname" . }}-{username}',
    'persistentVolumeClaim': {
      'claimName': 'pvc-{{ include "elixier.fullname" . }}-{username}'
    }
  }, {
    'name': '{{ include "elixier.fullname" . }}-spark-config',
    'secret': {
        'secretName': '{{ include "elixier.fullname" . }}-spark-config',
    }
 }, {
    'name': '{{ include "elixier.fullname" . }}-spark-datadir',
    'emptyDir': {}
 }, {
    'name': '{{ include "elixier.fullname" . }}-jupyter-workdir',
    'emptyDir': {}
 },
{{ if .Values.presto.enabled -}}
 {
    'name': '{{ include "elixier.fullname" . }}-presto-catalogs',
    'persistentVolumeClaim': {
        'claimName': '{{ include "elixier.fullname" . }}-presto-catalogs'
    }
 },
{{ end }}

{{ if .Values.trino.enabled -}}
 {
    'name': '{{ include "elixier.fullname" . }}-trino-catalogs',
    'persistentVolumeClaim': {
        'claimName': '{{ include "elixier.fullname" . }}-trino-catalogs'
    }
 },
{{ end }}
]

c.KubeSpawner.volume_mounts = [
    {
        'mountPath': '/home/',
        'name': 'vol-{{ include "elixier.fullname" . }}-{username}'
    }, {
        'name':  '{{ include "elixier.fullname" . }}-spark-config',
        'mountPath': "/etc/spark3/"
    }, {
        'name': '{{ include "elixier.fullname" . }}-spark-config',
        'mountPath': "/opt/apache/spark3/conf/",
    }, {
        'name': '{{ include "elixier.fullname" . }}-spark-datadir',
        'mountPath': "/opt/apache/spark3/work-dir",
    }, {
        'name': '{{ include "elixier.fullname" . }}-jupyter-workdir',
        'mountPath': "/workdir",
    }, 
{{ if .Values.presto.enabled -}}
    {
        'name': '{{ include "elixier.fullname" . }}-presto-catalogs',
        'mountPath': "/etc/presto/catalog"
    },
{{- end }}
{{ if .Values.trino.enabled -}}
    {
        'name': '{{ include "elixier.fullname" . }}-trino-catalogs',
        'mountPath': "/etc/trino/catalog"
    },
{{- end }}

]

c.KubeSpawner.start_timeout = 300


def modify_pod(spawner, pod):
    name = os.environ.get('K8S_POD_NAME')
    uid = os.environ.get('K8S_POD_UID')
    if not name or not uid:
       return pod
    ref = make_owner_reference(name, uid)
    pod.metadata.owner_references = [ref]
    return pod

c.KubeSpawner.modify_pod_hook = modify_pod

import yaml

{{- if .Values.jupyterhub.profiles }}
profiles_json = """{{- .Values.jupyterhub.profiles -}}"""
c.KubeSpawner.profile_list = yaml.safe_load(profiles_json)
{{- end }}

env_keep = """{{- include "elixier.jupyterhub.env_keep" . -}}"""
c.KubeSpawner.env_keep = yaml.safe_load(env_keep)

{{- if .Values.keycloak.enabled }}
from oauthenticator.generic import GenericOAuthenticator
c.JupyterHub.authenticator_class = GenericOAuthenticator

c.GenericOAuthenticator.client_id = '{{ .Values.keycloak.client_id }}'
c.GenericOAuthenticator.client_secret = '{{ .Values.keycloak.client_secret }}'
c.GenericOAuthenticator.token_url = '{{ include "elixier.keycloak.token_endpoint" . }}'
c.GenericOAuthenticator.userdata_url = '{{ include "elixier.keycloak.userinfo_endpoint" . }}'
c.GenericOAuthenticator.authorize_url = '{{ include "elixier.keycloak.authorization_endpoint" . }}'
c.GenericOAuthenticator.userdata_params = {'state': 'state'}
c.GenericOAuthenticator.username_key = 'preferred_username'
c.GenericOAuthenticator.login_service = 'Keycloak'
c.GenericOAuthenticator.scope = ['openid', 'profile']
c.GenericOAuthenticator.oauth_callback_url = 'https://jupyterhub.{{ .Values.ingress.domain }}/hub/oauth_callback'

{{- end }}
{{- end }}


{{/* 
Webserver Config 
*/}}
{{- define "airflow-webserver-config" }}
"""Default configuration for the Airflow webserver"""
import os

from airflow.www.fab_security.manager import AUTH_DB
basedir = os.path.abspath(os.path.dirname(__file__))
WTF_CSRF_ENABLED = True
AUTH_TYPE = AUTH_DB

{{ end }}


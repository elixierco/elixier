{{/* 
  Airflow configuration
*/}}
{{- define "airflow-config" -}}
[core]
dags_folder = /var/lib/airflow/git/project/dags/
default_timezone = {{ .Values.airflow.default_timezone }}
executor = CeleryExecutor
sql_alchemy_conn = {{ include "elixier.airflow.db_uri" . }}
sql_engine_encoding = utf-8
sql_alchemy_pool_enabled = True
sql_alchemy_pool_size = {{ .Values.airflow.db_pool_size | default "5" }}
sql_alchemy_max_overflow = {{ .Values.airflow.db_pool_max_overflow | default "10" }}
sql_alchemy_pool_recycle = {{ .Values.airflow.db_pool_recycle | default "1800" }}
sql_alchemy_pool_pre_ping = True
sql_alchemy_schema =
parallelism = {{ .Values.airflow.task_parallelism | default "32" }}
max_active_tasks_per_dag = {{ .Values.airflow.max_active_tasks_per_dag | default "16" }}
dags_are_paused_at_creation = {{ .Values.airflow.dags_paused_at_creation | default "True" }}
max_active_runs_per_dag = {{ .Values.airflow.max_active_runs_per_dag | default "16" }}
load_examples = False
load_default_connections = False
plugins_folder = /var/lib/airflow/git/project/plugins/
execute_tasks_new_python_interpreter = True
donot_pickle = False
dag_file_processor_timeout = 50
task_runner = StandardTaskRunner
default_impersonation = 
security = 
unit_test_mode = False
enable_xcom_pickling = False
killed_task_cleanup_time = 150
fernet_key = {{ .Values.secrets.fernet_key }}

[webserver]
{{- if .Values.ingress.tls }}
base_url = https://{{ .Values.ingress.host }}
{{- else }}
base_url = http://{{ .Values.ingress.host }}
{{- end }}
default_ui_timezone = {{ .Values.airflow.default_timezone }}
web_server_host = 0.0.0.0
web_server_port = 8080
secret_key = {{ .Values.secrets.secret_key }}
enable_proxy_fix = True

[logging]
base_log_folder = /var/log/airflow/
{{ if .Values.airflow.remote_logging_enabled }}
remote_logging = True
remote_log_conn_id = {{ .Values.airflow.remote_log_conn_id | default "" }}
remote_base_log_folder = {{ .Values.airflow.remote_log_folder | default "" }}
{{ else }}
remote_logging = False
{{ end }}
encrypt_s3_logs = False
logging_level = INFO
fab_logging_level = WARNING
colored_console_log = True
dag_processor_manager_log_location = /var/log/airflow/dag_processor_manager/dag_processor_manager.log
worker_log_server_port = 8793

[metrics]
statsd_on = False
statsd_host = localhost
statsd_port = 8125
statsd_prefix = airflow

[lineage]
backend = 

[atlas]
sasl_enabled = False
host =
port = 21000
username =
password =

[celery]
celery_app_name = airflow.executors.celery_executor
worker_concurrency = 8
worker_umask = 0o077
broker_url = redis://{{ include "elixier.fullname" . }}-redis:6379/0
result_backend = redis://{{ include "elixier.fullname" . }}-redis:6379/1
flower_host = 0.0.0.0
flower_url_prefix =
flower_port = 5555
flower_basic_auth =
sync_parallelism = 0
celery_config_options = airflow.config_templates.default_celery.DEFAULT_CELERY_CONFIG
ssl_active = False
ssl_key =
ssl_cert =
ssl_cacert =
pool = prefork
operation_timeout = 1.0
task_track_started = True
task_adoption_timeout = 600
task_publish_max_retries = 3
worker_precheck = False

[scheduler]
child_process_log_directory = /var/log/airflow/scheduler

{{ if .Values.smtp.enabled }}
[smtp]
smtp_host = {{ .Values.smtp.host }}
smtp_port = {{ .Values.smtp.port }}
smtp_user = {{ .Values.smtp.user }}
smtp_password = {{ .Values.smtp.password }}
smtp_mail_from = {{ .Values.smtp.from }}
{{- if .Values.smtp.use_ssl }}
smtp_ssl = True
{{- else -}}
smtp_ssl = False
{{- end }}
{{- if .Values.smtp.use_tls }}
smtp_starttls = True
{{- else -}}
smtp_starttls = False
{{- end }}
{{- end }}
smtp_timeout = 30
smtp_retry_limit = {{ .Values.smtp.retry_limit | default "5" }}
{{ end }}


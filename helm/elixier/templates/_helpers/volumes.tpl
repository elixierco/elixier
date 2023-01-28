{{- define "elixier.volumes" }}
- name: {{ include "elixier.fullname" . }}-spark-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-spark-config
- name: {{ include "elixier.fullname" . }}-spark-datadir
  emptyDir: {}
- name: {{ include "elixier.fullname" . }}-airflow-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-airflow-config
- name: {{ include "elixier.fullname" . }}-airflow-datadir
  persistentVolumeClaim:
    claimName: {{ include "elixier.fullname" . }}-airflow-datadir
- name: {{ include "elixier.fullname" . }}-airflow-logdir
  emptyDir: {}
- name: {{ include "elixier.fullname" . }}-hadoop-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-hadoop-config
{{- end }}

{{- define "elixier.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-spark-config
  mountPath: "/etc/spark3/"
# - name: {{ include "elixier.fullname" . }}-spark-config
#   mountPath: "/opt/apache/spark3/conf/"
- name: {{ include "elixier.fullname" . }}-spark-datadir
  mountPath: "/opt/apache/spark3/work-dir"
- name: {{ include "elixier.fullname" . }}-airflow-config
  mountPath: "/etc/airflow/"
- name: {{ include "elixier.fullname" . }}-airflow-datadir
  mountPath: "/var/lib/airflow"
- name: {{ include "elixier.fullname" . }}-airflow-logdir
  mountPath: "/var/log/airflow"
- name: {{ include "elixier.fullname" . }}-hadoop-config
  mountPath: "/opt/apache/hadoop/etc/hadoop/core-site.xml"
  subPath: "core-site.xml"
{{- end }}


{{- define "elixier.env" -}}
- name: SPARK_HOME
  value: /opt/apache/spark3
- name: SPARK_CONF_DIR
  value: /etc/spark3/
- name: JAVA_HOME
  value: /usr/lib/jvm/jre-1.8.0/
- name: PYSPARK_PYTHON
  value: /opt/apache/spark3-python/bin/python
- name: SPARK_WORKER_DIR
  value: /opt/apache/spark3/work-dir/worker
- name: SPARK_LOG_DIR
  value: /opt/apache/spark3/work-dir/logs/
- name: HIVE_SERVER2_THRIFT_PORT
  value: "10000"
- name: HIVE_SERVER2_THRIFT_BIND_HOST
  value: "0.0.0.0"
- name: K8S_POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
{{- end }}

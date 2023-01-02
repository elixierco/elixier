{{ define "elixier.kafka.env" }}
- name: K8S_POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
- name: K8S_POD_UID
  valueFrom:
    fieldRef:
      fieldPath: metadata.uid
- name: KAFKA_CLUSTER_ID
  value: {{ .Values.kafka.cluster_id }}
- name: KAFKA_LOG_DIRS
  value: /var/lib/kafka/data
{{- end }}

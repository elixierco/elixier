{{ define "opensearch.env" }}
- name: K8S_POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
- name: K8S_POD_UID
  valueFrom:
    fieldRef:
      fieldPath: metadata.uid
- name: node.name
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
- name: cluster.name
  value: '{{ include "opensearch.fullname" . }}'
- name: discovery.seed_hosts
  value: {{ include "opensearch.nodes" . }}
- name: cluster.initial_cluster_manager_nodes
  value: {{ include "opensearch.nodes" . }}
- name: DISABLE_SECURITY_PLUGIN
  value: "true"
- name: OPENSEARCH_JAVA_OPTS
  value: '-Xms{{ .Values.heapSize | default "512m" }} -Xmx{{ .Values.heapSize | default  "512m" }}'
{{- end }}

{{ define "neo4j.volumes" }}
- name: {{ include "neo4j.fullname" . }}-config
  configMap:
    name: {{ include "neo4j.fullname" . }}-config
- name: {{ include "neo4j.fullname" . }}-logdir
  emptyDir: {}
- name: {{ include "neo4j.fullname" . }}-rundir
  emptyDir: {}

{{- end }}

{{ define "neo4j.volumeMounts" }}
- name: {{ include "neo4j.fullname" . }}-logdir
  mountPath: "/var/log/neo4j"
- name: {{ include "neo4j.fullname" . }}-datadir
  mountPath: "/var/lib/neo4j"
- name: {{ include "neo4j.fullname" . }}-rundir
  mountPath: "/var/lib/neo4j/run/"
- name: {{ include "neo4j.fullname" . }}-config
  mountPath: "/etc/neo4j/"
{{- end }}


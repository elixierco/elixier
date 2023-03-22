{{ define "elixier-catalog.neo4j.volumes" }}
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-config
  secret:
    secretName: {{ include "elixier-catalog.fullname" . }}-neo4j-config
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-logdir
  emptyDir: {}
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-rundir
  emptyDir: {}

{{- end }}

{{ define "elixier-catalog.neo4j.volume-mounts" }}
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-logdir
  mountPath: "/var/log/neo4j"
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-datadir
  mountPath: "/var/lib/neo4j"
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-rundir
  mountPath: "/var/lib/neo4j/run/"
- name: {{ include "elixier-catalog.fullname" . }}-neo4j-config
  mountPath: "/etc/neo4j/"
{{- end }}


{{- define "opensearch.nodes" -}}
   {{- $replicas := int .Values.replicaCount -}}
   {{- range untilStep 0 $replicas 1 -}}
        {{ include "opensearch.fullname" $ }}-m-{{ . }}
        {{- if ne . (sub $replicas 1) -}},{{- end -}}
   {{- end -}}
{{- end -}}

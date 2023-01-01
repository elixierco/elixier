{{- define "elixier.opensearch.nodes" -}}
   {{- $replicas := int .Values.opensearch.replicas -}}
   {{- range untilStep 0 $replicas 1 -}}
        {{ include "elixier.fullname" $ }}-osearch-m-{{ . }}
        {{- if ne . (sub $replicas 1) -}},{{- end -}}
   {{- end -}}
{{- end -}}

{{- define "elixier-catalog.opensearch.nodes" -}}
   {{- $replicas := int .Values.opensearch.replicas -}}
   {{- range untilStep 0 $replicas 1 -}}
        {{ include "elixier-catalog.fullname" $ }}-osearch-m-{{ . }}
        {{- if ne . (sub $replicas 1) -}},{{- end -}}
   {{- end -}}
{{- end -}}

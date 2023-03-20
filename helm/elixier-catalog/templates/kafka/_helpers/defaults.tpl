{{- define "elixier-catalog.kafka.voters" -}}
   {{- $replicas := int .Values.kafka.replicas -}}
   {{- $namespace := .Release.Namespace -}}
   {{- range untilStep 0 $replicas 1 -}}
        {{- $nodeid := add . 1 -}}
        {{ $nodeid }}@{{ include "elixier-catalog.fullname" $ }}-kafka-s-{{ . }}.{{ include "elixier-catalog.fullname" $ }}-kafka-s.{{ $namespace }}.svc.cluster.local:9093
        {{- if ne . (sub $replicas 1) -}},{{- end -}}
   {{- end -}}
{{- end -}}

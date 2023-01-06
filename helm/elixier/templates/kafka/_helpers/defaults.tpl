{{- define "elixier.kafka.voters" -}}
   {{- $replicas := int .Values.kafka.replicas -}}
   {{- range untilStep 0 $replicas 1 -}}
        {{- $nodeid := add . 1 -}}
        {{ $nodeid }}@{{ include "elixier.fullname" $ }}-kafka-s-{{ . }}.{{ include "elixier.fullname" $ }}-kafka-s:9093
        {{- if ne . (sub $replicas 1) -}},{{- end -}}
   {{- end -}}
{{- end -}}

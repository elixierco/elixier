{{- define "kafka.voters" -}}
   {{- $replicas := int .Values.replicaCount -}}
   {{- $namespace := .Release.Namespace -}}
   {{- range untilStep 0 $replicas 1 -}}
        {{- $nodeid := add . 1 -}}
        {{ $nodeid }}@{{ include "kafka.fullname" $ }}-s-{{ . }}.{{ include "kafka.fullname" $ }}-s.{{ $namespace }}.svc.cluster.local:9093
        {{- if ne . (sub $replicas 1) -}},{{- end -}}
   {{- end -}}
{{- end -}}

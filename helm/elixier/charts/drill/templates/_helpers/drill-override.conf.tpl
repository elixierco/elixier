{{ define "drill-override.conf" -}}

drill.exec: {
  cluster-id: "{{- include "drill.fullname" . -}}",
  zk.connect: "{{- .Values.global.zkQuorum -}}"
}

{{- end }}

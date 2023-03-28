{{/*
Expand the name of the chart.
*/}}
{{- define "elixier-catalog.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "elixier-catalog.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "elixier-catalog.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "elixier-catalog.labels" -}}
helm.sh/chart: {{ include "elixier-catalog.chart" . }}
{{ include "elixier-catalog.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "elixier-catalog.selectorLabels" -}}
app.kubernetes.io/name: {{ include "elixier-catalog.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "elixier-catalog.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "elixier-catalog.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "elixier-catalog.datahub-name" -}}
   {{ include "elixier-catalog.fullname" . }}-dhub
{{- end -}}

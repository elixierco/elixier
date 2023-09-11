{{/*
Expand the name of the chart.
*/}}
{{- define "hivemetastore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hivemetastore.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hivemetastore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hivemetastore.labels" -}}
helm.sh/chart: {{ include "hivemetastore.chart" . }}
{{ include "hivemetastore.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hivemetastore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hivemetastore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hivemetastore.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hivemetastore.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "hivemetastore.dbUrl" -}}
    {{ .Values.global.metastoreDbUrl | default (printf "jdbc:postgresql://%s:%d/%s" .Values.global.metastore.dbHost (.Values.global.metastore.dbPort | int) .Values.global.metastore.dbName ) }}
{{- end -}}

{{- define "hivemetastore.url" -}}
    {{ .Values.global.metastoreUrl | default (printf "thrift://%s:%d" .Values.global.metastore.host (.Values.global.metastore.port | int )) }}
{{- end -}}



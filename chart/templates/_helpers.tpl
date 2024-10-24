{{- define "arcadedb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
*/}}
{{- define "arcadedb.fullname" -}}
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
Define service name
*/}}
{{- define "arcadedb.servicename" -}}
{{- if ne .Values.service.postFix "" }}
{{- default (include "arcadedb.fullname" .) .Values.service.name }}-{{ .Values.service.postFix }}
{{- else }}
{{- default (include "arcadedb.fullname" .) .Values.service.name }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "arcadedb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "arcadedb.labels" -}}
helm.sh/chart: {{ include "arcadedb.chart" . }}
{{ include "arcadedb.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | trunc 63 | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "arcadedb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "arcadedb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
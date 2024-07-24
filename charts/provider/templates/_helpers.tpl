{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
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
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default namespace
*/}}
{{- define "common.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Match labels
*/}}
{{- define "common.matchLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Use image with digest or tag
*/}}
{{- define "deployment.image" -}}
{{- if .Values.provider.image.digest }}
{{- printf "%s@sha256:%s" .Values.provider.image.repository .Values.provider.image.digest }}
{{- else if .Values.provider.image.tag }}
{{- printf "%s:%s" .Values.provider.image.repository .Values.provider.image.tag }}
{{- end }}
{{- end -}}

{{/*
Provider config
*/}}
{{- define "provider-config.name" -}}
{{- if and .Values.config.existingConfigMap.enabled .Values.config.existingConfigMap.name }}
{{- .Values.config.existingConfigMap.name }}
{{- else }}
{{- printf "%s-config" ( include "common.fullname" . ) }}
{{- end }}
{{- end -}}

{{- define "provider-config.path" -}}
{{- if and .Values.config.existingConfigMap.enabled .Values.config.existingConfigMap.path }}
{{- if contains ".yaml" .Values.config.existingConfigMap.path }}
{{- .Values.config.existingConfigMap.path }}
{{- else }}
{{- printf "%s.yaml" .Values.config.existingConfigMap.path }}
{{- end -}}
{{- else }}
{{- "config.yaml" }}
{{- end }}
{{- end -}}

{{- define "provider-config.key" -}}
{{- if and .Values.config.existingConfigMap.enabled .Values.config.existingConfigMap.key }}
{{- .Values.config.existingConfigMap.key }}
{{- else }}
{{- "config.yaml" }}
{{- end }}
{{- end -}}

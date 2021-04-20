{{/*
MongoDB
*/}}
{{- define "mongodb.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "mongodb" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "mongodb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "mongodb.service" -}}
{{- printf "%s-%s-%s" .Release.Name "mongodb" "service" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
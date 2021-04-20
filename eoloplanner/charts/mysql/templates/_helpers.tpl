{{/*
MySQL
*/}}
{{- define "mysql.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "mysql" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "mysql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "mysql.service" -}}
{{- printf "%s-%s-%s" .Release.Name "mysql" "service" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
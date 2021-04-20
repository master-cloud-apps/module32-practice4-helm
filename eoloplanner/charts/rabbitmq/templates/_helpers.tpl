{{/*
RabbitMQ
*/}}
{{- define "rabbitmq.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "rabbitmq" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "rabbitmq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "rabbitmq.service" -}}
{{- printf "%s-%s-%s" .Release.Name "rabbitmq" "service" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
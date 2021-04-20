{{/*
Weatherservice
*/}}
{{- define "weatherservice.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "weatherservice" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "weatherservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "weatherservice.service" -}}
{{- printf "%s-%s-%s"  .Release.Name "weatherservice" "service" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Planner
*/}}
{{- define "planner.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "planner" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "planner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Toposervice
*/}}
{{- define "toposervice.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "toposervice" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "toposervice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "toposervice.service" -}}
{{- printf "%s-%s-%s"  .Release.Name "toposervice" "service" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Server
*/}}
{{- define "server.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "server" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "server.service" -}}
{{- printf "%s-%s-%s"  .Release.Name "server" "service" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Ingress
*/}}
{{- define "ingress.name" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "ingress" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
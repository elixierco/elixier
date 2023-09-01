{{ define "datahub-values" }}
# vim: set syntax=yaml:

datahub-frontend:
  service:
    type: ClusterIP
  ingress:
    enabled: true
    {{- with .Values.ingress.annotations }}
    annotations:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    hosts:
      - host: datahub.{{ .Values.ingress.domain }}
        paths: 
          - '/'
    tls:
      - hosts:
          - datahub.{{ .Values.ingress.domain }}
        secretName: {{ include "elixier-catalog.fullname" . }}-fea
  {{ if .Values.keycloak.enabled }}
  extraEnvs:
    - name: AUTH_OIDC_ENABLED
      value: "true"
    - name: AUTH_OIDC_CLIENT_ID
      value: {{ .Values.keycloak.client_id }}
    - name: AUTH_OIDC_CLIENT_SECRET
      value: {{ .Values.keycloak.client_secret }}
    - name: AUTH_OIDC_DISCOVERY_URI
      value: {{ .Values.keycloak.url }}/realms/{{ .Values.keycloak.realm }}/.well-known/openid-configuration
    - name: AUTH_OIDC_BASE_URL
      value: https://datahub.{{ .Values.ingress.domain }}
  {{- end }}

datahub-gms:
  service:
    type: ClusterIP
  ingress:
    enabled: true
    {{- with .Values.ingress.annotations }}
    annotations:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    hosts:
      - host: api.datahub.{{ .Values.ingress.domain }}
        paths: 
          - '/'
    tls:
      - hosts:
          - api.datahub.{{ .Values.ingress.domain }}
        secretName: {{ include "elixier-catalog.fullname" . }}-gms

  

mysqlSetupJob:
  enabled: false

postgresqlSetupJob:
  enabled: true

elasticsearchSetupJob:
  extraEnvs:
    - name: USE_AWS_ELASTICSEARCH
      value: "true"

global:
  elasticsearch:
    host: {{ include "elixier-catalog.fullname" . }}-opensearch

  kafka:
    bootstrap:
      server: {{ include "elixier-catalog.fullname" . }}-kafka-s:9092
    schemaregistry:
      type: KAFKA
      url: http://{{ include "elixier-catalog.fullname" . }}-schemaregistry:8081
  
  neo4j:
    host: {{ include "elixier-catalog.fullname" . }}-neo4j:7474
    uri: bolt://{{ include "elixier-catalog.fullname" . }}-neo4j
    username: "neo4j"
    password:
      secretRef: {{ include "elixier-catalog.datahub-name" . }}
      secretKey: neo4j-password

  sql:
    datasource:
      host: {{ include "elixier-catalog.fullname" . }}-db:5432
      hostForpostgresqlClient: {{ include "elixier-catalog.fullname" . }}-db
      port: "5432"
      url: 'jdbc:postgresql://{{ include "elixier-catalog.fullname" . }}-db:5432/{{ .Values.datahub.db_name }}'
      driver: "org.postgresql.Driver"
      username: "{{ .Values.datahub.db_user }}"
      password:
        secretRef: {{ include "elixier-catalog.datahub-name" . }}
        secretKey: db-password

datahub:

    version: v0.10.5

    metadata_service_authentication:
      enabled: true
      systemClientSecret:
        secretRef: '{{ include "elixier-catalog.datahub-name" . }}-auth-secrets'
        secretKey: "token_service_signing_key"
      tokenService:
        signingKey:
          secretRef: '{{ include "elixier-catalog.datahub-name" . }}-auth-secrets'
          secretKey: "token_service_signing_key"
        salt:
          secretRef: '{{ include "elixier-catalog.datahub-name" . }}-auth-secrets'
          secretKey: "token_service_salt"

      provisionSecrets:
        enabled: true
        autoGenerate: true
    
    managed_ingestion:
      enabled: true
      defaultCliVersion: "0.10.5.4"

{{ end }}

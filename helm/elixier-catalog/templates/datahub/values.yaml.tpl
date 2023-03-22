{{ define "datahub-values" }}
# vim: set syntax=yaml:

datahub-frontend:
  service:
    type: ClusterIP
  ingress:
    enabled: true
    hosts:
      - host: datahub.{{ .Values.ingress.domain }}
        paths: 
          - '/'
  

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
      url: http://{{ include "elixier-catalog.fullname" . }}-schemaregistry:8081
  
  neo4j:
    host: {{ include "elixier-catalog.fullname" . }}-neo4j:7474
    uri: bolt://{{ include "elixier-catalog.fullname" . }}-neo4j
    username: "neo4j"
    password:
      secretRef: {{ include "elixier-catalog.fullname" . }}-datahub
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
        secretRef: {{ include "elixier-catalog.fullname" . }}-datahub
        secretKey: db-password

{{ end }}

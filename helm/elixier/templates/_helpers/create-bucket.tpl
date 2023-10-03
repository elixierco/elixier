{{- define "elixier.createBucket" }}
- name: createbucket-{{ .BucketId }}
  image: "{{ .Values.global.mcImage.repository }}:{{ .Values.global.mcImage.tag }}"
  imagePullPolicy: {{ .Values.global.mcImage.pullPolicy }}
  command: ["mc", "mb", "-p", "minio/{{ .Bucket }}"]
  env:
    - name: HOME
      value: /tmp/
    - name: MC_HOST_minio
      value: 'http://{{ .Values.global.s3a.accessKey }}:{{ .Values.global.s3a.secretKey }}@{{ .Release.Name }}-s3:9000'
  resources:
    {{- toYaml .Values.global.utilResources | nindent 4 }}
{{- end }}

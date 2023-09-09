# vim: set syntax=xml:

{{ define "core-site" }}
<configuration>
   <property>
      <name>fs.defaultFS</name>
      <value>s3a://{{ include "elixier.spark.bucket" . }}</value>
   </property>

  <property>
    <name>fs.s3a.endpoint</name>
    <value>{{ include "elixier.s3a.endpoint" . }}</value>
 </property>

  <property>
    <name>fs.s3a.access.key</name>
    <value>{{ .Values.s3a.access_key }}</value>
 </property>

  <property>
    <name>fs.s3a.secret.key</name>
    <value>{{ .Values.s3a.secret_key }}</value>
 </property>

  <property>
    <name>fs.s3a.bucket.{{ include "elixier.spark.bucket" . }}.access.key</name>
    <value>{{ .Values.s3a.access_key }}</value>
 </property>

  <property>
    <name>fs.s3a.bucket.{{ include "elixier.spark.bucket" . }}.secret.key</name>
    <value>{{ .Values.s3a.secret_key }}</value>
  </property>

  <property>
    <name>fs.s3a.path.style.access</name>
    <value>true</value>
  </property>

  <property>
    <name>fs.s3a.impl</name>
    <value>org.apache.hadoop.fs.s3a.S3AFileSystem</value>
 </property>

   <property>
      <name>hadoop.tmp.dir</name>
      <value>/var/tmp/</value>
   </property>
    
    <property>
      <name>fs.s3a.buffer.dir</name>
      <value>/var/tmp/</value>
    </property>

</configuration>
{{- end }}

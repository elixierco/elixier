Pending features / capabilities
================================

- LDAP/AD integration.

- Presto authentication. 

- Presto worker auto scaling.

- replace MinIO with S3GW. Longhorn already handle replication, which makes running MinIO suboptimal. (update, this can't work. S3GW implementation is incomplete. Put this towards latter stage)

- Airflow web & worker auto scaling (probably working, but need testing).

- Superset web & worker auto scaling (probably working, but need testing).

- OpenVSCode Server component to help with ETL development.

- TLS/SSL for internal service communications, possibly with internal CA and certificate management.

- LetsEncrypt support for ingress TLS/SSL.

- DataHub (https://datahubproject.io/) and its dependencies.

- DataHub integration in Spark, Airflow, Superset, HiveMetastore, MinIO.

- High availability deployment mode for internal PgSQL database. 
 
- High availability deployment mode for internal Redis.

- Grafana based internal monitoring.

- OpenSearch based centralized log management.

- Celery Flower component for monitoring Celery queues in Redis. 

- Ranger integration for ACL.

- NiFi helm chart, separate from elixier core to support edge ingestion use-case.

- [Ship Airflow logs to OpenSearchi](https://medium.com/@semih.sezer/how-to-send-airflow-logs-to-elasticsearch-using-filebeat-and-logstash-250c074e7575)

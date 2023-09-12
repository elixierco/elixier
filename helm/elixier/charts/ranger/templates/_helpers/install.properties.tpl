# vim: set filetype=dosini:
{{ define "install.properties" }}
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file provides a list of the deployment variables for the Policy Manager Web Application
#

#------------------------- DB CONFIG - BEGIN ----------------------------------
# Uncomment the below if the DBA steps need to be run separately
#setup_mode=SeparateDBA

PYTHON_COMMAND_INVOKER=python3

#DB_FLAVOR=MYSQL|ORACLE|POSTGRES|MSSQL|SQLA
DB_FLAVOR={{ include "ranger.dbFlavor" . }}

#
# Location of DB client library (please check the location of the jar file)
#
#SQL_CONNECTOR_JAR=/usr/share/java/ojdbc6.jar
#SQL_CONNECTOR_JAR=/usr/share/java/mysql-connector-java.jar
#SQL_CONNECTOR_JAR=/usr/share/java/postgresql.jar
#SQL_CONNECTOR_JAR=/usr/share/java/sqljdbc4.jar
#SQL_CONNECTOR_JAR=/opt/sqlanywhere17/java/sajdbc4.jar
SQL_CONNECTOR_JAR={{ include "ranger.dbConnectorJar" . }}


#
# DB password for the DB admin user-id
# **************************************************************************
# ** If the password is left empty or not-defined here,
# ** it will try with blank password during installation process
# **************************************************************************
#
#db_root_user=root|SYS|postgres|sa|dba
#db_host=host:port              # for DB_FLAVOR=MYSQL|POSTGRES|SQLA|MSSQL       #for example: db_host=localhost:3306
#db_host=host:port:SID          # for DB_FLAVOR=ORACLE                          #for SID example: db_host=localhost:1521:ORCL
#db_host=host:port/ServiceName  # for DB_FLAVOR=ORACLE                          #for Service example: db_host=localhost:1521/XE
db_root_user={{ .Values.dbRootUser }}
db_root_password={{ .Values.dbRootPass }}
db_host={{ .Values.dbHost | default (printf "%s-db" .Release.Name)}}
#SSL config
db_ssl_enabled=false
db_ssl_required=false
db_ssl_verifyServerCertificate=false
#db_ssl_auth_type=1-way|2-way, where 1-way represents standard one way ssl authentication and 2-way represents mutual ssl authentication
db_ssl_auth_type=2-way
javax_net_ssl_keyStore=/etc/keystore/keystore
javax_net_ssl_keyStorePassword={{ .Values.global.keystore.password }}
javax_net_ssl_trustStore=/etc/keystore/truststore
javax_net_ssl_trustStorePassword={{ .Values.global.truststore.password }}
javax_net_ssl_trustStore_type={{ .Values.global.keystore.type }}
javax_net_ssl_keyStore_type={{ .Values.global.keystore.type }}

# For postgresql db
db_ssl_certificate_file=

#
# DB UserId used for the Ranger schema
#
db_name={{ .Values.dbName }}
db_user={{ .Values.dbUser }}
db_password={{ .Values.dbPass }}

#For over-riding the jdbc url.
is_override_db_connection_string=false
db_override_connection_string=


# change password. Password for below mentioned users can be changed only once using this property.
#PLEASE NOTE :: Password should be minimum 8 characters with min one alphabet and one numeric.
rangerAdmin_password={{ .Values.adminPass }}
rangerTagsync_password={{ .Values.adminPass }}
rangerUsersync_password={{ .Values.adminPass }}
keyadmin_password={{ .Values.adminPass }}


#Source for Audit Store. Currently solr, elasticsearch and cloudwatch logs are supported.
# * audit_store is solr
audit_store=elasticsearch

# * audit_solr_url Elasticsearch Host(s). E.g. 127.0.0.1
audit_elasticsearch_urls={{ .Values.global.ranger.opensearch.urls | default (printf "%s-osearch" .Release.Name)}}
audit_elasticsearch_port={{ .Values.global.ranger.opensearch.port | default "9200" }}
audit_elasticsearch_protocol={{ .Values.global.ranger.opensearch.protocol | default "http" }}
audit_elasticsearch_user={{ .Values.global.ranger.opensearch.user }}
audit_elasticsearch_password={{ .Values.global.ranger.opensearch.password }}
audit_elasticsearch_index={{ .Values.global.ranger.opensearch.index | default "ranger_audit" }}
audit_elasticsearch_bootstrap_enabled=true


# * audit_solr_url URL to Solr. E.g. http://<solr_host>:6083/solr/ranger_audits
audit_solr_urls=
audit_solr_user=
audit_solr_password=
audit_solr_zookeepers=

audit_solr_collection_name=ranger_audits
#solr Properties for cloud mode
audit_solr_config_name=ranger_audits
audit_solr_configset_location=
audit_solr_no_shards=1
audit_solr_no_replica=1
audit_solr_max_shards_per_node=1
audit_solr_acl_user_list_sasl=solr,infra-solr
audit_solr_bootstrap_enabled=true

# * audit to amazon cloudwatch properties
audit_cloudwatch_region=
audit_cloudwatch_log_group=
audit_cloudwatch_log_stream_prefix=

#------------------------- DB CONFIG - END ----------------------------------

#
# ------- PolicyManager CONFIG ----------------
#

policymgr_external_url="{{ .Values.external_url | default (printf "http://ranger.%s" .Values.global.ingressDomain) }}"
policymgr_http_enabled=true
policymgr_https_keystore_file=/etc/keystore/keystore
policymgr_https_keystore_keyalias=rangeradmin
policymgr_https_keystore_password={{ .Values.global.keystore.password }}

#Add Supported Components list below separated by semi-colon, default value is empty string to support all components
#Example :  policymgr_supportedcomponents=hive,hbase,hdfs
policymgr_supportedcomponents=nifi,tag,kafka,elasticsearch,nifi-registry,trino

#
# ------- PolicyManager CONFIG - END ---------------
#


#
# ------- UNIX User CONFIG ----------------
#
unix_user=ranger
unix_user_pwd=ranger
unix_group=ranger

#
# ------- UNIX User CONFIG  - END ----------------
#
#

#
# UNIX authentication service for Policy Manager
#
# PolicyManager can authenticate using UNIX username/password
# The UNIX server specified here as authServiceHostName needs to be installed with ranger-unix-ugsync package.
# Once the service is installed on authServiceHostName, the UNIX username/password from the host <authServiceHostName> can be used to login into policy manager
#
# ** The installation of ranger-unix-ugsync package can be installed after the policymanager installation is finished.
#
#LDAP|ACTIVE_DIRECTORY|UNIX|NONE
authentication_method=NONE
remoteLoginEnabled=true
authServiceHostName=localhost
authServicePort=5151
ranger_unixauth_keystore=/etc/keystore/keystore
ranger_unixauth_keystore_password={{ .Values.global.keystore.password }}
ranger_unixauth_truststore=/etc/keystore/truststore
ranger_unixauth_truststore_password={{ .Values.global.truststore.password }}

####LDAP settings - Required only if have selected LDAP authentication ####
#
# Sample Settings
#
#xa_ldap_url=ldap://127.0.0.1:389
#xa_ldap_userDNpattern=uid={0},ou=users,dc=xasecure,dc=net
#xa_ldap_groupSearchBase=ou=groups,dc=xasecure,dc=net
#xa_ldap_groupSearchFilter=(member=uid={0},ou=users,dc=xasecure,dc=net)
#xa_ldap_groupRoleAttribute=cn
#xa_ldap_base_dn=dc=xasecure,dc=net
#xa_ldap_bind_dn=cn=admin,ou=users,dc=xasecure,dc=net
#xa_ldap_bind_password=
#xa_ldap_referral=follow|ignore
#xa_ldap_userSearchFilter=(uid={0})

xa_ldap_url=
xa_ldap_userDNpattern=
xa_ldap_groupSearchBase=
xa_ldap_groupSearchFilter=
xa_ldap_groupRoleAttribute=
xa_ldap_base_dn=
xa_ldap_bind_dn=
xa_ldap_bind_password=
xa_ldap_referral=
xa_ldap_userSearchFilter=
####ACTIVE_DIRECTORY settings - Required only if have selected AD authentication ####
#
# Sample Settings
#
#xa_ldap_ad_domain=xasecure.net
#xa_ldap_ad_url=ldap://127.0.0.1:389
#xa_ldap_ad_base_dn=dc=xasecure,dc=net
#xa_ldap_ad_bind_dn=cn=administrator,ou=users,dc=xasecure,dc=net
#xa_ldap_ad_bind_password=
#xa_ldap_ad_referral=follow|ignore
#xa_ldap_ad_userSearchFilter=(sAMAccountName={0})

xa_ldap_ad_domain=
xa_ldap_ad_url=
xa_ldap_ad_base_dn=
xa_ldap_ad_bind_dn=
xa_ldap_ad_bind_password=
xa_ldap_ad_referral=
xa_ldap_ad_userSearchFilter=

#------------ Kerberos Config -----------------
spnego_principal=
spnego_keytab=
token_valid=30
cookie_domain=
cookie_path=/
admin_principal=
admin_keytab=
lookup_principal=
lookup_keytab=
hadoop_conf=/etc/hadoop/conf
#
#-------- SSO CONFIG - Start ------------------
#
sso_enabled=false
sso_providerurl=
sso_publickey=

#
#-------- SSO CONFIG - END ------------------

# Custom log directory path
RANGER_ADMIN_LOG_DIR=$PWD
RANGER_ADMIN_LOGBACK_CONF_FILE=

# PID file path
RANGER_PID_DIR_PATH=/var/run/ranger

# #################  DO NOT MODIFY ANY VARIABLES BELOW #########################
#
# --- These deployment variables are not to be modified unless you understand the full impact of the changes
#
################################################################################
XAPOLICYMGR_DIR=$PWD
app_home=$PWD/ews/webapp
TMPFILE=$PWD/.fi_tmp
LOGFILE=$PWD/logfile
LOGFILES="$LOGFILE"

JAVA_BIN='java'
JAVA_VERSION_REQUIRED='1.8'
JAVA_ORACLE='Java(TM) SE Runtime Environment'

ranger_admin_max_heap_size=1g
#retry DB and Java patches after the given time in seconds.
PATCH_RETRY_INTERVAL=120
STALE_PATCH_ENTRY_HOLD_TIME=10

#mysql_create_user_file=${PWD}/db/mysql/create_dev_user.sql
mysql_core_file=db/mysql/optimized/current/ranger_core_db_mysql.sql
mysql_audit_file=db/mysql/xa_audit_db.sql
#mysql_asset_file=${PWD}/db/mysql/reset_asset.sql

#oracle_create_user_file=${PWD}/db/oracle/create_dev_user_oracle.sql
oracle_core_file=db/oracle/optimized/current/ranger_core_db_oracle.sql
oracle_audit_file=db/oracle/xa_audit_db_oracle.sql
#oracle_asset_file=${PWD}/db/oracle/reset_asset_oracle.sql
#
postgres_core_file=db/postgres/optimized/current/ranger_core_db_postgres.sql
postgres_audit_file=db/postgres/xa_audit_db_postgres.sql
#
sqlserver_core_file=db/sqlserver/optimized/current/ranger_core_db_sqlserver.sql
sqlserver_audit_file=db/sqlserver/xa_audit_db_sqlserver.sql
#
sqlanywhere_core_file=db/sqlanywhere/optimized/current/ranger_core_db_sqlanywhere.sql
sqlanywhere_audit_file=db/sqlanywhere/xa_audit_db_sqlanywhere.sql
cred_keystore_filename=$app_home/WEB-INF/classes/conf/.jceks/rangeradmin.jceks
{{ end }}

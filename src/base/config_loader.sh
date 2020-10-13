#!/usr/bin/env bash
function load_config() {
    if [[ "$2" != "NULL" ]]; then
        printf "$1=$2\n" >> "${PRESTO_CONF_DIR}/$3"
    fi
}

load_config "coordinator" ${COORDINATOR:=true} "config.properties"
load_config "node-scheduler.include-coordinator" ${NODE_SCHEDULER_INCLUDE_COORDINATOR:=false} "config.properties"
load_config "http-server.http.port" ${HTTP_SERVER_HTTP_PORT:=8080} "config.properties"
load_config "query.max-memory" ${QUERY_MAX_MEMORY:=50GB} "config.properties"
load_config "query.max-memory-per-node" ${QUERY_MAX_MEMORY_PER_NODE:=1GB} "config.properties"
load_config "query.max-total-memory-per-node" ${QUERY_MAX_TOTAL_MEMORY_PER_NODE:=2GB} "config.properties"
load_config "discovery-server.enabled" ${DISCOVERY_SERVER_ENABLED:=true} "config.properties"
load_config "discovery.uri" ${DISCOVERY_URI:=NULL} "config.properties"
# ===========================================================================
load_config "node.environment" ${NODE_ENVIRONMENT:=production} "node.properties"
load_config "node.id" "${HOSTNAME}" "node.properties"
load_config "node.data-dir" "${PRESTO_USER_HOME}/data" "node.properties"
# ===========================================================================
load_config "connector.name" "accumulo" "catalog/accumulo.properties"
load_config "accumulo.instance" ${ACCUMULO_INSTANCE:=NULL} "catalog/accumulo.properties"
load_config "accumulo.zookeepers" ${ACCUMULO_ZOOKEEPERS:=NULL} "catalog/accumulo.properties"
load_config "accumulo.username" ${ACCUMULO_USERNAME:=NULL} "catalog/accumulo.properties"
load_config "accumulo.password" ${ACCUMULO_PASSWORD:=NULL} "catalog/accumulo.properties"
load_config "accumulo.zookeeper.metadata.root" ${ACCUMULO_ZOOKEEPER_METADATA_ROOT:=/presto-accumulo} "catalog/accumulo.properties"
load_config "accumulo.cardinality.cache.size" ${ACCUMULO_CARDINALITY_CACHE_SIZE:=100000} "catalog/accumulo.properties"
load_config "accumulo.cardinality.cache.expire.duration" ${ACCUMULO_CARDINALITY_CACHE_EXPIRE_DURATION:=5m} "catalog/accumulo.properties"
# ===========================================================================
load_config "connector.name" "bigquery" "catalog/bigquery.properties"
load_config "bigquery.project-id" ${BIGQUERY_PROJECT_ID:=NULL} "catalog/bigquery.properties"
load_config "bigquery.parent-project-id" ${BIGQUERY_PARENT_PROJECT_ID:=NULL} "catalog/bigquery.properties"
load_config "bigquery.parallelism" ${BIGQUERY_PARALLELISM:=NULL} "catalog/bigquery.properties"
load_config "bigquery.views-enabled" ${BIGQUERY_VIEWS_ENABLED:=false} "catalog/bigquery.properties"
load_config "bigquery.view-materialization-project" ${BIGQUERY_VIEW_MATERIALIZATION_PROJECT:=NULL} "catalog/bigquery.properties"
load_config "bigquery.view-materialization-dataset" ${BIGQUERY_VIEW_MATERIALIZATION_DATASET:=NULL} "catalog/bigquery.properties"
load_config "bigquery.max-read-rows-retries" ${BIGQUERY_MAX_READ_ROWS_RETRIES:=3} "catalog/bigquery.properties"
load_config "bigquery.credentials-key" ${BIGQUERY_CREDENTIALS_KEY:=NULL} "catalog/bigquery.properties"
load_config "bigquery.credentials-file" ${BIGQUERY_CREDENTIALS_FILE:=NULL} "catalog/bigquery.properties"
# ===========================================================================
load_config "connector.name" "cassandra" "catalog/cassandra.properties"
load_config "cassandra.contact-points" ${CASSANDRA_CONTACT_POINTS:=NULL} "catalog/cassandra.properties"
load_config "cassandra.native-protocol-port" ${CASSANDRA_NATIVE_PROTOCOL_PORT:=NULL} "catalog/cassandra.properties"
load_config "cassandra.consistency-level" ${CASSANDRA_CONSISTENCY_LEVEL:=NULL} "catalog/cassandra.properties"
load_config "cassandra.allow-drop-table" ${CASSANDRA_ALLOW_DROP_TABLE:=NULL} "catalog/cassandra.properties"
load_config "cassandra.username" ${CASSANDRA_USERNAME:=NULL} "catalog/cassandra.properties"
load_config "cassandra.password" ${CASSANDRA_PASSWORD:=NULL} "catalog/cassandra.properties"
load_config "cassandra.protocol-version" ${CASSANDRA_PROTOCOL_VERSION:=NULL} "catalog/cassandra.properties"
load_config "cassandra.fetch-size" ${CASSANDRA_FETCH_SIZE:=NULL} "catalog/cassandra.properties"
load_config "cassandra.partition-size-for-batch-select" ${CASSANDRA_PARTITION_SIZE_FOR_BATCH_SELECT:=NULL} "catalog/cassandra.properties"
load_config "cassandra.split-size" ${CASSANDRA_SPLIT_SIZE:=NULL} "catalog/cassandra.properties"
load_config "cassandra.splits-per-node" ${CASSANDRA_SPLITS_PER_NODE:=NULL} "catalog/cassandra.properties"
load_config "cassandra.client.read-timeout" ${CASSANDRA_CLIENT_READ_TIMEOUT:=NULL} "catalog/cassandra.properties"
load_config "cassandra.client.connect-timeout" ${CASSANDRA_CLIENT_CONNECT_TIMEOUT:=NULL} "catalog/cassandra.properties"
load_config "cassandra.client.so-linger" ${CASSANDRA_CLIENT_SO_LINGER:=NULL} "catalog/cassandra.properties"
load_config "cassandra.retry-policy" ${CASSANDRA_RETRY_POLICY:=NULL} "catalog/cassandra.properties"
load_config "cassandra.load-policy.use-dc-aware" ${CASSANDRA_LOAD_POLICY_USE_DC_AWARE:=false} "catalog/cassandra.properties"
load_config "cassandra.load-policy.dc-aware.local-dc" ${CASSANDRA_LOAD_POLICY_DC_AWARE_LOCAL_DC:=NULL} "catalog/cassandra.properties"
load_config "cassandra.load-policy.dc-aware.used-hosts-per-remote-dc" ${CASSANDRA_LOAD_POLICY_DC_AWARE_USED_HOSTS_PER_REMOTE_DC:=NULL} "catalog/cassandra.properties"
load_config "cassandra.load-policy.dc-aware.allow-remote-dc-for-local" ${CASSANDRA_LOAD_POLICY_DC_AWARE_ALLOW_REMOTE_DC_FOR_LOCAL:=NULL} "catalog/cassandra.properties"
load_config "cassandra.load-policy.use-token-aware" ${CASSANDRA_LOAD_POLICY_USE_TOKEN_AWARE:=false} "catalog/cassandra.properties"
load_config "cassandra.load-policy.shuffle-replicas" ${CASSANDRA_LOAD_POLICY_SHUFFLE_REPLICAS:=false} "catalog/cassandra.properties"
load_config "cassandra.load-policy.allowed-addresses" ${CASSANDRA_LOAD_POLICY_ALLOWED_ADDRESSES:=NULL} "catalog/cassandra.properties"
load_config "cassandra.no-host-available-retry-timeout" ${CASSANDRA_NO_HOST_AVAILABLE_RETRY_TIMEOUT:=1m} "catalog/cassandra.properties"
load_config "cassandra.speculative-execution.limit" ${CASSANDRA_SPECULATIVE_EXECUTION_LIMIT:=1} "catalog/cassandra.properties"
load_config "cassandra.speculative-execution.delay" ${CASSANDRA_SPECULATIVE_EXECUTION_DELAY:=500ms} "catalog/cassandra.properties"
load_config "cassandra.tls.enabled" ${CASSANDRA_TLS_ENABLED:=false} "catalog/cassandra.properties"
load_config "cassandra.tls.keystore-path" ${CASSANDRA_TLS_KEYSTORE_PATH:=NULL} "catalog/cassandra.properties"
load_config "cassandra.tls.truststore-path" ${CASSANDRA_TLS_TRUSTSTORE_PATH:=NULL} "catalog/cassandra.properties"
load_config "cassandra.tls.keystore-password" ${CASSANDRA_TLS_KEYSTORE_PASSWORD:=NULL} "catalog/cassandra.properties"
load_config "cassandra.tls.truststore-password" ${CASSANDRA_TLS_TRUSTSTORE_PASSWORD:=NULL} "catalog/cassandra.properties"
# ===========================================================================
load_config "connector.name" "druid" "catalog/druid.properties"
load_config "connection-url" "${DRUID_CONNECTION_URL:=NULL}" "catalog/druid.properties"
load_config "connection-user" "${DRUID_CONNECTION_USER:=NULL}" "catalog/druid.properties"
load_config "connection-password" "${DRUID_CONNECTION_PASSWORD:=NULL}" "catalog/druid.properties"
# ===========================================================================
load_config "connector.name" "elasticsearch" "catalog/elasticsearch.properties"
load_config "elasticsearch.host" ${ELASTICSEARCH_HOST:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.port" ${ELASTICSEARCH_PORT:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.default-schema-name" ${ELASTICSEARCH_DEFAULT_SCHEMA_NAME:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.scroll-size" ${ELASTICSEARCH_SCROLL_SIZE:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.scroll-timeout" ${ELASTICSEARCH_SCROLL_TIMEOUT:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.request-timeout" ${ELASTICSEARCH_REQUEST_TIMEOUT:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.connect-timeout" ${ELASTICSEARCH_CONNECT_TIMEOUT:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.max-retry-time" ${ELASTICSEARCH_MAX_RETRY_TIME:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.node-refresh-interval" ${ELASTICSEARCH_NODE_REFRESH_INTERVAL:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.tls.enabled" ${ELASTICSEARCH_TLS_ENABLED:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.tls.verify-hostnames" ${ELASTICSEARCH_TLS_VERIFY_HOSTNAMES:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.tls.keystore-path" ${ELASTICSEARCH_TLS_KEYSTORE_PATH:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.tls.truststore-path" ${ELASTICSEARCH_TLS_TRUSTSTORE_PATH:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.tls.keystore-password" ${ELASTICSEARCH_TLS_KEYSTORE_PASSWORD:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.tls.truststore-password" ${ELASTICSEARCH_TLS_TRUSTSTORE_PASSWORD:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.aws.region" ${ELASTICSEARCH_AWS_REGION:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.aws.access-key" ${ELASTICSEARCH_AWS_ACCESS_KEY:=NULL} "catalog/elasticsearch.properties"
load_config "elasticsearch.aws.secret-key" ${ELASTICSEARCH_AWS_SECRET_KEY:=NULL} "catalog/elasticsearch.properties"
# ===========================================================================
load_config "connector.name" ${CONNECTOR_NAME:=gsheets} "catalog/gsheets.properties"
load_config "credentials-path" "${GSHEETS_CREDENTIALS_PATH:=NULL}" "catalog/gsheets.properties"
load_config "metadata-sheet-id" "${GSHEETS_METADATA_SHEET_ID:=NULL}" "catalog/gsheets.properties"
load_config "sheets-data-max-cache-size" "${GSHEETS_SHEETS_DATA_MAX_CACHE_SIZE:=NULL}" "catalog/gsheets.properties"
load_config "sheets-data-expire-after-write" "${GSHEETS_SHEETS_DATA_EXPIRE_AFTER_WRITE:=NULL}" "catalog/gsheets.properties"
# ===========================================================================
load_config "connector.name" "hive-hadoop2" "catalog/hive.properties"
load_config "hive.config.resources" ${HIVE_CONFIG_RESOURCES:=NULL} "catalog/hive.properties"
load_config "hive.recursive-directories" ${HIVE_RECURSIVE_DIRECTORIES:=false} "catalog/hive.properties"
load_config "hive.ignore-absent-partitions" ${HIVE_IGNORE_ABSENT_PARTITIONS:=false} "catalog/hive.properties"
load_config "hive.storage-format" ${HIVE_STORAGE_FORMAT:=ORC} "catalog/hive.properties"
load_config "hive.compression-codec" ${HIVE_COMPRESSION_CODEC:=GZIP} "catalog/hive.properties"
load_config "hive.force-local-scheduling" ${HIVE_FORCE_LOCAL_SCHEDULING:=false} "catalog/hive.properties"
load_config "hive.respect-table-format" ${HIVE_RESPECT_TABLE_FORMAT:=true} "catalog/hive.properties"
load_config "hive.immutable-partitions" ${HIVE_IMMUTABLE_PARTITIONS:=false} "catalog/hive.properties"
load_config "hive.insert-existing-partitions-behavior" ${HIVE_INSERT_EXISTING_PARTITIONS_BEHAVIOR:=APPEND} "catalog/hive.properties"
load_config "hive.create-empty-bucket-files" ${HIVE_CREATE_EMPTY_BUCKET_FILES:=false} "catalog/hive.properties"
load_config "hive.max-partitions-per-writers" ${HIVE_MAX_PARTITIONS_PER_WRITERS:=100} "catalog/hive.properties"
load_config "hive.nax-partitions-per-scan" ${HIVE_NAX_PARTITIONS_PER_SCAN:=100000} "catalog/hive.properties"
load_config "hive.hdfs.authentication.type" ${HIVE_HDFS_AUTHENTICATION_TYPE:=NONE} "catalog/hive.properties"
load_config "hive.hdfs.impersonation.enabled" ${HIVE_HDFS_IMPERSONATION_ENABLED:=false} "catalog/hive.properties"
load_config "hive.hdfs.presto.principal" ${HIVE_HDFS_PRESTO_PRINCIPAL:=NULL} "catalog/hive.properties"
load_config "hive.hdfs.presto.keytab" ${HIVE_HDFS_PRESTO_KEYTAB:=NULL} "catalog/hive.properties"
load_config "hive.security" ${HIVE_SECURITY:=NULL} "catalog/hive.properties"
load_config "hive.non-managed-table-writes-enabled" ${HIVE_NON_MANAGED_TABLE_WRITES_ENABLED:=false} "catalog/hive.properties"
load_config "hive.non-managed-table-creates-enabled" ${HIVE_NON_MANAGED_TABLE_CREATES_ENABLED:=true} "catalog/hive.properties"
load_config "hive.collect-column-statistics-on-write" ${HIVE_COLLECT_COLUMN_STATISTICS_ON_WRITE:=true} "catalog/hive.properties"
load_config "hive.s3select-pushdown.enabled" ${HIVE_S3SELECT_PUSHDOWN_ENABLED:=false} "catalog/hive.properties"
load_config "hive.s3select-pushdown.max-connections" ${HIVE_S3SELECT_PUSHDOWN_MAX_CONNECTIONS:=500} "catalog/hive.properties"
load_config "hive.file-status-cache-tables" ${HIVE_FILE_STATUS_CACHE_TABLES:=NULL} "catalog/hive.properties"
load_config "hive.file-status-cache-size" ${HIVE_FILE_STATUS_CACHE_SIZE:=1000000} "catalog/hive.properties"
load_config "hive.file-status-cache-expire-time" ${HIVE_FILE_STATUS_CACHE_EXPIRE_TIME:=1m} "catalog/hive.properties"
load_config "hive.parquet.time-zone" ${HIVE_PARQUET_TIME_ZONE:=NULL} "catalog/hive.properties"
load_config "hive.rcfile.time-zone" ${HIVE_RCFILE_TIME_ZONE:=NULL} "catalog/hive.properties"
load_config "hive.orc.time-zone" ${HIVE_ORC_TIME_ZONE:=NULaL} "catalog/hive.properties"
load_config "hive.timestamp-precision" ${HIVE_TIMESTAMP_PRECISION:=MILLISECONDS} "catalog/hive.properties"
load_config "hive.temporary-staging-directory-enabled" ${HIVE_TEMPORARY_STAGING_DIRECTORY_ENABLED:=true} "catalog/hive.properties"
load_config "hive.temporary-staging-directory-path" ${HIVE_TEMPORARY_STAGING_DIRECTORY_PATH:=/tmp/${USER}} "catalog/hive.properties"
load_config "hive.metastore" ${HIVE_METASTORE:=thrift} "catalog/hive.properties"
load_config "hive.metastore.uri" ${HIVE_METASTORE_URI:=NULL} "catalog/hive.properties"
load_config "hive.metastore.username" ${HIVE_METASTORE_USERNAME:=NULL} "catalog/hive.properties"
load_config "hive.metastore.authentication.type" ${HIVE_METASTORE_AUTHENTICATION_TYPE:=NONE} "catalog/hive.properties"
load_config "hive.metastore.thrift.impersonation.enabled" ${HIVE_METASTORE_THRIFT_IMPERSONATION_ENABLED:=NULL} "catalog/hive.properties"
load_config "hive.metastore.thrift.delegation-token.cache-ttl" ${HIVE_METASTORE_THRIFT_DELEGATION_TOKEN_CACHE_TTL:=1h} "catalog/hive.properties"
load_config "hive.metastore.thrift.delegation-token.cache-maximum-size" ${HIVE_METASTORE_THRIFT_DELEGATION_TOKEN_CACHE_MAXIMUM_SIZE:=1000} "catalog/hive.properties"
load_config "hive.metastore.thrift.client.ssl.enabled" ${HIVE_METASTORE_THRIFT_CLIENT_SSL_ENABLED:=false} "catalog/hive.properties"
load_config "hive.metastore.thrift.client.ssl.key" ${HIVE_METASTORE_THRIFT_CLIENT_SSL_KEY:=NULL} "catalog/hive.properties"
load_config "hive.metastore.thrift.client.ssl.key-passwordL" ${HIVE_METASTORE_THRIFT_CLIENT_SSL_KEY_PASSWORDL:=NULL} "catalog/hive.properties"
load_config "hive.metastore.thrift.client.ssl.trust-certificate" ${HIVE_METASTORE_THRIFT_CLIENT_SSL_TRUST_CERTIFICATE:=NULL} "catalog/hive.properties"
load_config "hive.metastore.thrift.client.ssl.trust-certificate-password" ${HIVE_METASTORE_THRIFT_CLIENT_SSL_TRUST_CERTIFICATE_PASSWORD:=NULL} "catalog/hive.properties"
load_config "hive.metastore.service.principal" ${HIVE_METASTORE_SERVICE_PRINCIPAL:=NULL} "catalog/hive.properties"
load_config "hive.metastore.client.principal" ${HIVE_METASTORE_CLIENT_PRINCIPAL:=NULL} "catalog/hive.properties"
load_config "hive.metastore.client.keytab" ${HIVE_METASTORE_CLIENT_KEYTAB:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.region" ${HIVE_METASTORE_GLUE_REGION:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.endpoint-url" ${HIVE_METASTORE_GLUE_ENDPOINT_URL:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.pin-client-to-current-region" ${HIVE_METASTORE_GLUE_PIN_CLIENT_TO_CURRENT_REGION:=false} "catalog/hive.properties"
load_config "hive.metastore.glue.max-connections" ${HIVE_METASTORE_GLUE_MAX_CONNECTIONS:=5} "catalog/hive.properties"
load_config "hive.metastore.glue.max-error-retries" ${HIVE_METASTORE_GLUE_MAX_ERROR_RETRIES:=10} "catalog/hive.properties"
load_config "hive.metastore.glue.default-warehouse-dir" ${HIVE_METASTORE_GLUE_DEFAULT_WAREHOUSE_DIR:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.aws-credentials-provider" ${HIVE_METASTORE_GLUE_AWS_CREDENTIALS_PROVIDER:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.aws-access-key" ${HIVE_METASTORE_GLUE_AWS_ACCESS_KEY:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.aws-secret-key" ${HIVE_METASTORE_GLUE_AWS_SECRET_KEY:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.catalogid" ${HIVE_METASTORE_GLUE_CATALOGID:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.iam-role" ${HIVE_METASTORE_GLUE_IAM_ROLE:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.external-id" ${HIVE_METASTORE_GLUE_EXTERNAL_ID:=NULL} "catalog/hive.properties"
load_config "hive.metastore.glue.partitions-segments" ${HIVE_METASTORE_GLUE_PARTITIONS_SEGMENTS:=5} "catalog/hive.properties"
load_config "hive.metastore.glue.get-partition-threads" ${HIVE_METASTORE_GLUE_GET_PARTITION_THREADS:=20} "catalog/hive.properties"
load_config "hive.metastore.alluxio.master.address" ${HIVE_METASTORE_ALLUXIO_MASTER_ADDRESS:=NULL} "catalog/hive.properties"
load_config "hive.metastore-cache-ttl" ${HIVE_METASTORE_CACHE_TTL:=0s} "catalog/hive.properties"
load_config "hive.metastore-cache-maximum-size" ${HIVE_METASTORE_CACHE_MAXIMUM_SIZE:=10000} "catalog/hive.properties"
load_config "hive.metastore-refresh-interval" ${HIVE_METASTORE_REFRESH_INTERVAL:=NULL} "catalog/hive.properties"
load_config "hive.metastore-refresh-max-threads" ${HIVE_METASTORE_REFRESH_MAX_THREADS:=100} "catalog/hive.properties"
load_config "hive.metastore-timeout" ${HIVE_METASTORE_TIMEOUT:=10s} "catalog/hive.properties"
load_config "hive.gcs.json-key-file-path" ${HIVE_GCS_JSON_KEY_FILE_PATH:=NULL} "catalog/hive.properties"
load_config "hive.gcs.use-access-token" ${HIVE_GCS_USE_ACCESS_TOKEN:=NULL} "catalog/hive.properties"
load_config "hive.s3.aws-access-key" ${HIVE_S3_AWS_ACCESS_KEY:=NULL} "catalog/hive.properties"
load_config "hive.s3.aws-secret-key" ${HIVE_S3_AWS_SECRET_KEY:=NULL} "catalog/hive.properties"
load_config "hive.s3.iam-role" ${HIVE_S3_IAM_ROLE:=NULL} "catalog/hive.properties"
load_config "hive.s3.external-id" ${HIVE_S3_EXTERNAL_ID:=NULL} "catalog/hive.properties"
load_config "hive.s3.endpoint" ${HIVE_S3_ENDPOINT:=NULL} "catalog/hive.properties"
load_config "hive.s3.storage-class" ${HIVE_S3_STORAGE_CLASS:=STANDARD} "catalog/hive.properties"
load_config "hive.s3.signer-type" ${HIVE_S3_SIGNER_TYPE:=NULL} "catalog/hive.properties"
load_config "hive.s3.signer-class" ${HIVE_S3_SIGNER_CLASS:=NULL} "catalog/hive.properties"
load_config "hive.s3.path-style-access" ${HIVE_S3_PATH_STYLE_ACCESS:=NULL} "catalog/hive.properties"
load_config "hive.s3.staging-directory" ${HIVE_S3_STAGING_DIRECTORY:=NULL} "catalog/hive.properties"
load_config "hive.s3.pin-client-to-current-region" ${HIVE_S3_PIN_CLIENT_TO_CURRENT_REGION:=false} "catalog/hive.properties"
load_config "hive.s3.ssl.enabled" ${HIVE_S3_SSL_ENABLED:=true} "catalog/hive.properties"
load_config "hive.s3.sse.enabled" ${HIVE_S3_SSE_ENABLED:=false} "catalog/hive.properties"
load_config "hive.s3.sse.type" ${HIVE_S3_SSE_TYPE:=S3} "catalog/hive.properties"
load_config "hive.s3.sse.kms-key-id" ${HIVE_S3_SSE_KMS_KEY_ID:=NULL} "catalog/hive.properties"
load_config "hive.s3.kms-key-id" ${HIVE_S3_KMS_KEY_ID:=NULL} "catalog/hive.properties"
load_config "hive.s3.encryption-materials-provider" ${HIVE_S3_ENCRYPTION_MATERIALS_PROVIDER:=NULL} "catalog/hive.properties"
load_config "hive.s3.upload-acl-type" ${HIVE_S3_UPLOAD_ACL_TYPE:=Private} "catalog/hive.properties"
load_config "hive.s3.skip-glacier-objects" ${HIVE_S3_SKIP_GLACIER_OBJECTS:=false} "catalog/hive.properties"
load_config "hive.s3.security-mapping.config-file" ${HIVE_S3_SECURITY_MAPPING_CONFIG_FILE:=NULL} "catalog/hive.properties"
load_config "hive.s3.security-mapping.iam-role-credential-name" ${HIVE_S3_SECURITY_MAPPING_IAM_ROLE_CREDENTIAL_NAME:=NULL} "catalog/hive.properties"
load_config "hive.s3.security-mapping.refresh-period" ${HIVE_S3_SECURITY_MAPPING_REFRESH_PERIOD:=NULL} "catalog/hive.properties"
load_config "hive.s3.security-mapping.colon-replacement" ${HIVE_S3_SECURITY_MAPPING_COLON_REPLACEMENT:=NULL} "catalog/hive.properties"
load_config "hive.s3.max-error-retries" ${HIVE_S3_MAX_ERROR_RETRIES:=3} "catalog/hive.properties"
load_config "hive.s3.max-client-retries" ${HIVE_S3_MAX_CLIENT_RETRIES:=5} "catalog/hive.properties"
load_config "hive.s3.max-backoff-time" ${HIVE_S3_MAX_BACKOFF_TIME:=10 minutes} "catalog/hive.properties"
load_config "hive.s3.max-retry-time" ${HIVE_S3_MAX_RETRY_TIME:=10 minutes} "catalog/hive.properties"
load_config "hive.s3.connect-timeout" ${HIVE_S3_CONNECT_TIMEOUT:=5 seconds} "catalog/hive.properties"
load_config "hive.s3.socket-timeout" ${HIVE_S3_SOCKET_TIMEOUT:=5 seconds} "catalog/hive.properties"
load_config "hive.s3.max-connections" ${HIVE_S3_MAX_CONNECTIONS:=500} "catalog/hive.properties"
load_config "hive.s3.multipart.min-file-size" ${HIVE_S3_MULTIPART_MIN_FILE_SIZE:=16 MB} "catalog/hive.properties"
load_config "hive.s3.multipart.min-part-size" ${HIVE_S3_MULTIPART_MIN_PART_SIZE:=5 MB} "catalog/hive.properties"
load_config "hive.s3.azure.wasb-storage-account" ${HIVE_S3_AZURE_WASB_STORAGE_ACCOUNT:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.wasb-access-key" ${HIVE_S3_AZURE_WASB_ACCESS_KEY:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.abfs-storage-account" ${HIVE_S3_AZURE_ABFS_STORAGE_ACCOUNT:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.abfs-access-key" ${HIVE_S3_AZURE_ABFS_ACCESS_KEY:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.abfs.oauth.endpoint" ${HIVE_S3_AZURE_ABFS_OAUTH_ENDPOINT:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.abfs.oauth.client-id" ${HIVE_S3_AZURE_ABFS_OAUTH_CLIENT_ID:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.abfs.oauth.secret" ${HIVE_S3_AZURE_ABFS_OAUTH_SECRET:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.adl-client-id" ${HIVE_S3_AZURE_ADL_CLIENT_ID:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.adl-credential" ${HIVE_S3_AZURE_ADL_CREDENTIAL:=NULL} "catalog/hive.properties"
load_config "hive.s3.azure.adl-refresh-url" ${HIVE_S3_AZURE_ADL_REFRESH_URL:=NULL} "catalog/hive.properties"
load_config "hive.s3.cache.enabled" ${HIVE_S3_CACHE_ENABLED:=false} "catalog/hive.properties"
load_config "hive.s3.cache.location" ${HIVE_S3_CACHE_LOCATION:=NULL} "catalog/hive.properties"
load_config "hive.s3.cache.data-transfer-port" ${HIVE_S3_CACHE_DATA_TRANSFER_PORT:=8898} "catalog/hive.properties"
load_config "hive.s3.cache.bookkeeper-port" ${HIVE_S3_CACHE_BOOKKEEPER_PORT:=8899} "catalog/hive.properties"
load_config "hive.s3.cache.read-mode" ${HIVE_S3_CACHE_READ_MODE:=async} "catalog/hive.properties"
load_config "hive.s3.cache.ttl" ${HIVE_S3_CACHE_TTL:=7d} "catalog/hive.properties"
load_config "hive.s3.cache.disk-usage-percentage" ${HIVE_S3_CACHE_DISK_USAGE_PERCENTAGE:=80} "catalog/hive.properties"
load_config "security.config-file" "${HIVE_SECURITY_CONFIG_FILE:=NULL}" "catalog/hive.properties"
# ===========================================================================
load_config "connector.name" "jmx" "catalog/jmx.properties"
load_config "jmx.dump-tables" ${JMX_DUMP_TABLES:=NULL} "catalog/jmx.properties"
load_config "jmx.dump-period" ${JMX_DUMP_PERIOD:=10s} "catalog/jmx.properties"
load_config "jmx.max-entries" ${JMX_MAX_ENTRIES:=86400} "catalog/jmx.properties"
# ===========================================================================
load_config "connector.name" "kafka" "catalog/kafka.properties"
load_config "kafka.table-names" ${KAFKA_TABLE_NAMES:=NULL} "catalog/kafka.properties"
load_config "kafka.default-schema" ${KAFKA_DEFAULT_SCHEMA:=NULL} "catalog/kafka.properties"
load_config "kafka.nodes" ${KAFKA_NODES:=NULL} "catalog/kafka.properties"
load_config "kafka.buffer-size" ${KAFKA_BUFFER_SIZE:=NULL} "catalog/kafka.properties"
load_config "kafka.table-description-dir" ${KAFKA_TABLE_DESCRIPTION_DIR:=NULL} "catalog/kafka.properties"
load_config "kafka.hide-internal-columns" ${KAFKA_HIDE_INTERNAL_COLUMNS:=NULL} "catalog/kafka.properties"
load_config "kafka.messages-per-split" ${KAFKA_MESSAGES_PER_SPLIT:=NULL} "catalog/kafka.properties"
# ===========================================================================
load_config "connector.name" "kinesis" "catalog/kinesis.properties"
load_config "kinesis.access-key" ${KINESIS_ACCESS_KEY:=NULL} "catalog/kinesis.properties"
load_config "kinesis.secret-key" ${KINESIS_SECRET_KEY:=NULL} "catalog/kinesis.properties"
load_config "kinesis.aws-region" ${KINESIS_AWS_REGION:=NULL} "catalog/kinesis.properties"
load_config "kinesis.default-schema" ${KINESIS_DEFAULT_SCHEMA:=NULL} "catalog/kinesis.properties"
load_config "kinesis.table-description-location" ${KINESIS_TABLE_DESCRIPTION_LOCATION:=NULL} "catalog/kinesis.properties"
load_config "kinesis.hide-internal-columns" ${KINESIS_HIDE_INTERNAL_COLUMNS:=NULL} "catalog/kinesis.properties"
load_config "kinesis.batch-size" ${KINESIS_BATCH_SIZE:=NULL} "catalog/kinesis.properties"
load_config "kinesis.fetch-attempts" ${KINESIS_FETCH_ATTEMPTS:=NULL} "catalog/kinesis.properties"
load_config "kinesis.max-batches" ${KINESIS_MAX_BATCHES:=NULL} "catalog/kinesis.properties"
load_config "kinesis.sleep-time" ${KINESIS_SLEEP_TIME:=NULL} "catalog/kinesis.properties"
load_config "kinesis.iterator-from-timestamp" ${KINESIS_ITERATOR_FROM_TIMESTAMP:=NULL} "catalog/kinesis.properties"
load_config "kinesis.iterator-offset-seconds" ${KINESIS_ITERATOR_OFFSET_SECONDS:=NULL} "catalog/kinesis.properties"
# ===========================================================================
load_config "connector.name" "kudu" "catalog/kudu.properties"
load_config "kudu.client.master-addresses" ${KUDU_CLIENT_MASTER_ADDRESSES:=NULL} "catalog/kudu.properties"
load_config "kudu.client.default-admin-operation-timeout" ${KUDU_CLIENT_DEFAULT_ADMIN_OPERATION_TIMEOUT:=30s} "catalog/kudu.properties"
load_config "kudu.client.default-operation-timeout" ${KUDU_CLIENT_DEFAULT_OPERATION_TIMEOUT:=30s} "catalog/kudu.properties"
load_config "kudu.client.default-socket-read-timeout" ${KUDU_CLIENT_DEFAULT_SOCKET_READ_TIMEOUT:=10s} "catalog/kudu.properties"
load_config "kudu.client.disable-statistics" ${KUDU_CLIENT_DISABLE_STATISTICS:=false} "catalog/kudu.properties"
load_config "kudu.schema-emulation.enabled" ${KUDU_SCHEMA_EMULATION_ENABLED:=false} "catalog/kudu.properties"
load_config "kudu.schema-emulation.prefix" ${KUDU_SCHEMA_EMULATION_PREFIX:=NULL} "catalog/kudu.properties"
# ===========================================================================
load_config "connector.name" "memsql" "catalog/memsql.properties"
load_config "connection-url" "${MEMSQL_CONNECTION_URL:=NULL}" "catalog/memsql.properties"
load_config "connection-user" "${MEMSQL_CONNECTION_USER:=NULL}" "catalog/memsql.properties"
load_config "connection-password" "${MEMSQL_CONNECTION_PASSWORD:=NULL}" "catalog/memsql.properties"
# ===========================================================================
load_config "connector.name" "mongodb" "catalog/mongodb.properties"
load_config "mongodb.seeds" ${MONGODB_SEEDS:=NULL} "catalog/mongodb.properties"
load_config "mongodb.schema-collection" ${MONGODB_SCHEMA_COLLECTION:=NULL} "catalog/mongodb.properties"
load_config "mongodb.case-insensitive-name-matching" ${MONGODB_CASE_INSENSITIVE_NAME_MATCHING:=NULL} "catalog/mongodb.properties"
load_config "mongodb.credentials" ${MONGODB_CREDENTIALS:=NULL} "catalog/mongodb.properties"
load_config "mongodb.min-connections-per-host" ${MONGODB_MIN_CONNECTIONS_PER_HOST:=NULL} "catalog/mongodb.properties"
load_config "mongodb.connections-per-host" ${MONGODB_CONNECTIONS_PER_HOST:=NULL} "catalog/mongodb.properties"
load_config "mongodb.max-wait-time" ${MONGODB_MAX_WAIT_TIME:=NULL} "catalog/mongodb.properties"
load_config "mongodb.max-connection-idle-time" ${MONGODB_MAX_CONNECTION_IDLE_TIME:=NULL} "catalog/mongodb.properties"
load_config "mongodb.connection-timeout" ${MONGODB_CONNECTION_TIMEOUT:=NULL} "catalog/mongodb.properties"
load_config "mongodb.socket-timeout" ${MONGODB_SOCKET_TIMEOUT:=NULL} "catalog/mongodb.properties"
load_config "mongodb.socket-keep-alive" ${MONGODB_SOCKET_KEEP_ALIVE:=NULL} "catalog/mongodb.properties"
load_config "mongodb.ssl.enabled" ${MONGODB_SSL_ENABLED:=NULL} "catalog/mongodb.properties"
load_config "mongodb.read-preference" ${MONGODB_READ_PREFERENCE:=NULL} "catalog/mongodb.properties"
load_config "mongodb.write-concern" ${MONGODB_WRITE_CONCERN:=NULL} "catalog/mongodb.properties"
load_config "mongodb.required-replica-set" ${MONGODB_REQUIRED_REPLICA_SET:=NULL} "catalog/mongodb.properties"
load_config "mongodb.cursor-batch-size" ${MONGODB_CURSOR_BATCH_SIZE:=NULL} "catalog/mongodb.properties"
# ===========================================================================
load_config "connector.name" "mysql" "catalog/mysql.properties"
load_config "connection-url" "${MYSQL_CONNECTION_URL:=NULL}" "catalog/mysql.properties"
load_config "connection-user" "${MYSQL_CONNECTION_USER:=NULL}" "catalog/mysql.properties"
load_config "connection-password" "${MYSQL_CONNECTION_PASSWORD:=NULL}" "catalog/mysql.properties"
# ===========================================================================
load_config "connector.name" "oracle" "catalog/oracle.properties"
load_config "connection-url" "${ORACLE_CONNECTION_URL:=NULL}" "catalog/oracle.properties"
load_config "connection-user" "${ORACLE_CONNECTION_USER:=NULL}" "catalog/oracle.properties"
load_config "connection-password" "${ORACLE_CONNECTION_PASSWORD:=NULL}" "catalog/oracle.properties"
load_config "oracle.connection-pool.enabled" ${ORACLE_CONNECTION_POOL_ENABLED:=NULL} "catalog/oracle.properties"
load_config "oracle.connection-pool.max-size" ${ORACLE_CONNECTION_POOL_MAX_SIZE:=NULL} "catalog/oracle.properties"
load_config "oracle.connection-pool.min-size" ${ORACLE_CONNECTION_POOL_MIN_SIZE:=NULL} "catalog/oracle.properties"
load_config "oracle.connection-pool.inactive-timeout" ${ORACLE_CONNECTION_POOL_INACTIVE_TIMEOUT:=NULL} "catalog/oracle.properties"
# ===========================================================================
load_config "connector.name" "phoenix" "catalog/phoenix.properties"
load_config "phoenix.connection-url" ${PHOENIX_CONNECTION_URL:=NULL} "catalog/phoenix.properties"
load_config "phoenix.config.resources" ${PHOENIX_CONFIG_RESOURCES:=NULL} "catalog/phoenix.properties"
# ===========================================================================
load_config "connector.name" "pinot" "catalog/pinot.properties"
load_config "pinot.controller-urls" ${PINOT_CONTROLLER_URLS:=NULL} "catalog/pinot.properties"
load_config "pinot.segments-per-split" ${PINOT_SEGMENTS_PER_SPLIT:=NULL} "catalog/pinot.properties"
# ===========================================================================
load_config "connector.name" "postgresql" "catalog/postgresql.properties"
load_config "connection-url" "${POSTGRESQL_CONNECTION_URL:=NULL}" "catalog/postgresql.properties"
load_config "connection-user" "${POSTGRESQL_CONNECTION_USER:=NULL}" "catalog/postgresql.properties"
load_config "connection-password" "${POSTGRESQL_CONNECTION_PASSWORD:=NULL}" "catalog/postgresql.properties"
# ===========================================================================
load_config "connector.name" "prometheus" "catalog/prometheus.properties"
load_config "prometheus.uri" ${PROMETHEUS_URI:=NULL} "catalog/prometheus.properties"
load_config "prometheus.query.chunk.size.duration" ${PROMETHEUS_QUERY_CHUNK_SIZE_DURATION:=NULL} "catalog/prometheus.properties"
load_config "prometheus.max.query.range.duration" ${PROMETHEUS_MAX_QUERY_RANGE_DURATION:=NULL} "catalog/prometheus.properties"
load_config "prometheus.cache.ttl" ${PROMETHEUS_CACHE_TTL:=NULL} "catalog/prometheus.properties"
load_config "prometheus.bearer.token.file" ${PROMETHEUS_BEARER_TOKEN_FILE:=NULL} "catalog/prometheus.properties"
# ===========================================================================
load_config "connector.name" "redis" "catalog/redis.properties"
load_config "redis.table-names" ${REDIS_TABLE_NAMES:=NULL} "catalog/redis.properties"
load_config "redis.default-schema" ${REDIS_DEFAULT_SCHEMA:=NULL} "catalog/redis.properties"
load_config "redis.nodes" ${REDIS_NODES:=NULL} "catalog/redis.properties"
load_config "redis.scan-count" ${REDIS_SCAN_COUNT:=NULL} "catalog/redis.properties"
load_config "redis.key-prefix-schema-table" ${REDIS_KEY_PREFIX_SCHEMA_TABLE:=NULL} "catalog/redis.properties"
load_config "redis.key-delimiter" ${REDIS_KEY_DELIMITER:=NULL} "catalog/redis.properties"
load_config "redis.table-description-dir" ${REDIS_TABLE_DESCRIPTION_DIR:=NULL} "catalog/redis.properties"
load_config "redis.hide-internal-columns" ${REDIS_HIDE_INTERNAL_COLUMNS:=NULL} "catalog/redis.properties"
load_config "redis.database-index" ${REDIS_DATABASE_INDEX:=NULL} "catalog/redis.properties"
load_config "redis.password" ${REDIS_PASSWORD:=NULL} "catalog/redis.properties"
# ===========================================================================
load_config "connector.name" "redshift" "catalog/redshift.properties"
load_config "connection-url" "${REDSHIFT_CONNECTION_URL:=NULL}" "catalog/redshift.properties"
load_config "connection-user" "${REDSHIFT_CONNECTION_USER:=NULL}" "catalog/redshift.properties"
load_config "connection-password" "${REDSHIFT_CONNECTION_PASSWORD:=NULL}" "catalog/redshift.properties"
# ===========================================================================
load_config "connector.name" "sqlserver" "catalog/sqlserver.properties"
load_config "connection-url" "${SQLSERVER_CONNECTION_URL:=NULL}" "catalog/sqlserver.properties"
load_config "connection-user" "${SQLSERVER_CONNECTION_USER:=NULL}" "catalog/sqlserver.properties"
load_config "connection-password" "${SQLSERVER_CONNECTION_PASSWORD:=NULL}" "catalog/sqlserver.properties"
# ===========================================================================
load_config "connector.name" "thrift" "catalog/thrift.properties"
load_config "presto.thrift.client.addresses" ${PRESTO_THRIFT_CLIENT_ADDRESSES:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.max-retries" ${PRESTO_THRIFT_CLIENT_MAX_RETRIES:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.max-backoff-delay" ${PRESTO_THRIFT_CLIENT_MAX_BACKOFF_DELAY:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.min-backoff-delay" ${PRESTO_THRIFT_CLIENT_MIN_BACKOFF_DELAY:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.max-retry-time" ${PRESTO_THRIFT_CLIENT_MAX_RETRY_TIME:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.backoff-scale-factor" ${PRESTO_THRIFT_CLIENT_BACKOFF_SCALE_FACTOR:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.connect-timeout" ${PRESTO_THRIFT_CLIENT_CONNECT_TIMEOUT:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.request-timeout" ${PRESTO_THRIFT_CLIENT_REQUEST_TIMEOUT:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.socks-proxy" ${PRESTO_THRIFT_CLIENT_SOCKS_PROXY:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.max-frame-size" ${PRESTO_THRIFT_CLIENT_MAX_FRAME_SIZE:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.transport" ${PRESTO_THRIFT_CLIENT_TRANSPORT:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.client.protocol" ${PRESTO_THRIFT_CLIENT_PROTOCOL:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.max-response-size" ${PRESTO_THRIFT_MAX_RESPONSE_SIZE:=NULL} "catalog/thrift.properties"
load_config "presto.thrift.metadata-refresh-threads" ${PRESTO_THRIFT_METADATA_REFRESH_THREADS:=NULL} "catalog/thrift.properties"
# ===========================================================================

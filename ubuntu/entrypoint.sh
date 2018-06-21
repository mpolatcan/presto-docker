#!/usr/bin/bash

# $1: Config name
# $2: Config value
# $3: Config file path
function loadConfig() {
    if [ "$2" != "NULL" ]
        then echo "$1=$2" >> "$3"
    fi
}

function loadJVMConfig() {
    if [ "$1" != "false" ]
        then echo "$2" >> "${PRESTO_CONFIGS}/jvm.config"
    fi
}

# ------------------------- Load Node Configs -----------------------------
loadConfig "coordinator" ${PRESTO_COORDINATOR} "${PRESTO_CONFIGS}/config.properties"
loadConfig "node-scheduler.include-coordinator" ${PRESTO_NODE_SCHEDULER_INCLUDE_COORDINATOR} "${PRESTO_CONFIGS}/config.properties"
loadConfig "http-server.http.port" ${PRESTO_HTTP_SERVER_HTTP_PORT} "${PRESTO_CONFIGS}/config.properties"
loadConfig "query.max-memory" ${PRESTO_QUERY_MAX_MEMORY} "${PRESTO_CONFIGS}/config.properties"
loadConfig "query.max-memory-per-node" ${PRESTO_QUERY_MAX_MEMORY_PER_NODE} "${PRESTO_CONFIGS}/config.properties"
loadConfig "discovery-server.enabled" ${PRESTO_DISCOVERY_SERVER_ENABLED} "${PRESTO_CONFIGS}/config.properties"
loadConfig "discovery.uri" ${PRESTO_DISCOVERY_URI} "${PRESTO_CONFIGS}/config.properties"
# ----------------------------------------------------------------------------

# ------------------------- Load JVM Configs -------------------------------
loadJVMConfig "true" "-server"
loadJVMConfig "true" "-Xms${PRESTO_JVM_MIN_HEAP_SIZE}"
loadJVMConfig "true" "-Xmx${PRESTO_JVM_MAX_HEAP_SIZE}"
loadJVMConfig "true" "-XX:G1HeapRegionSize=${PRESTO_JVM_G1_HEAP_REGION_SIZE}"
loadJVMConfig ${PRESTO_JVM_USE_G1GC} "-XX:+UseG1GC"
loadJVMConfig ${PRESTO_JVM_USE_GC_OVERHEAD_LIMIT} "-XX:+UseGCOverheadLimit"
loadJVMConfig ${PRESTO_JVM_EXPLICIT_GC_INVOKES_CONCURRENT} "-XX:+ExplicitGCInvokesConcurrent"
loadJVMConfig ${PRESTO_JVM_HEAP_DUMP_ON_OUT_OF_MEMORY_ERR} "-XX:+HeapDumpOnOutOfMemoryError"
loadJVMConfig ${PRESTO_EXIT_ON_OUT_OF_MEMORY_ERR} "-XX:+ExitOnOutOfMemoryError"
# ----------------------------------------------------------------------------

#  ------------------------ Load Node Properties ----------------------------
loadConfig "node.environment" ${PRESTO_NODE_ENVIRONMENT} "${PRESTO_CONFIGS}/node.properties"
if [[ "${PRESTO_COORDINATOR}" == "true" ]]
    then
        loadConfig "node.id" "presto-master-$(cat /proc/sys/kernel/random/uuid)" "${PRESTO_CONFIGS}/node.properties"
else
    loadConfig "node.id" "presto-worker-$(cat /proc/sys/kernel/random/uuid)" "${PRESTO_CONFIGS}/node.properties"
fi
loadConfig "node.data.dir" ${PRESTO_DATA_DIR} "${PRESTO_CONFIGS}/node.properties"
loadConfig "com.facebook.presto" ${PRESTO_LOG_LEVEL} "${PRESTO_CONFIGS}/log.properties"
# -----------------------------------------------------------------------------

# ------------------------- Load Kafka Configs ---------------------------------
if [ "${PRESTO_KAFKA_NODES}" != "NULL" ]
    then
        echo "connector.name=kafka" > ${PRESTO_CONNECTORS}/kafka.properties
        loadConfig "kafka.table-names" ${PRESTO_KAFKA_TABLE_NAMES} "${PRESTO_CONNECTORS}/kafka.properties"
        loadConfig "kafka.nodes" ${PRESTO_KAFKA_NODES} "${PRESTO_CONNECTORS}/kafka.properties"
        loadConfig "kafka.connect-timeout" ${PRESTO_KAFKA_CONNECT_TIMEOUT} "${PRESTO_CONNECTORS}/kafka.properties"
        loadConfig "kafka.buffer-size" ${PRESTO_KAFKA_BUFFER_SIZE} "${PRESTO_CONNECTORS}/kafka.properties"
        loadConfig "kafka.hide-internal-columns" ${PRESTO_KAFKA_HIDE_INTERNAL_COLUMNS} "${PRESTO_CONNECTORS}/kafka.properties"
        loadConfig "kafka.default-schema" ${PRESTO_KAFKA_DEFAULT_SCHEMA} "${PRESTO_CONNECTORS}/kafka.properties"
fi
# -----------------------------------------------------------------------------

# -------------------------- Load Cassandra Configs ---------------------------
if [ "${PRESTO_CASSANDRA_CONTACT_POINTS}" != "NULL" ]
    then
    echo "connector.name=cassandra" > ${PRESTO_CONNECTORS}/cassandra.properties
    loadConfig "cassandra.contact-points" ${PRESTO_CASSANDRA_CONTACT_POINTS} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.native-protocol-port" ${PRESTO_CASSANDRA_NATIVE_PROTOCOL_PORT} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.consistency-level" ${PRESTO_CASSANDRA_CONSISTENCY_LEVEL} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.allow-drop-table" ${PRESTO_CASSANDRA_ALLOW_DROP_TABLE} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.username" ${PRESTO_CASSANDRA_USERNAME} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.password" ${PRESTO_CASSANDRA_PASSWORD} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.fetch-size" ${PRESTO_CASSANDRA_FETCH_SIZE} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.partition-size-for-batch-select" ${PRESTO_CASSANDRA_PARTITION_SIZE_FOR_BATCH_SELECT} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.split-size" ${PRESTO_CASSANDRA_SPLIT_SIZE} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.client.read-timeout" ${PRESTO_CASSANDRA_CLIENT_READ_TIMEOUT} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.client.connect-timeout" ${PRESTO_CASSANDRA_CLIENT_CONNECT_TIMEOUT} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.client.so-linger" ${PRESTO_CASSANDRA_CLIENT_SO_LINGER} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.retry-policy" ${PRESTO_CASSANDRA_RETRY_POLICY} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.use-dc-aware" ${PRESTO_CASSANDRA_LOAD_POLIY_USE_DC_AWARE} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.dc-aware.local-dc" ${PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_LOCAL_DC} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.dc-aware.used-hosts-per-remote-dc" ${PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_USED_HOSTS_PER_REMOTE_DC} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.dc-aware.allow-remote-dc-for-local" ${PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_ALLOW_REMOTE_DC_FOR_LOCAL} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.use-token-aware" ${PRESTO_CASSANDRA_LOAD_POLICY_USE_TOKEN_AWARE} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.shuffle-replicas" ${PRESTO_CASSANDRA_LOAD_POLICY_SHUFFLE_REPLICASE} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.use-white-list" ${PRESTO_CASSANDRA_LOAD_POLICY_USE_WHITE_LIST} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.load-policy.white-list.addresses" ${PRESTO_CASSANDRA_LOAD_POLICY_WHITE_LIST_ADDRESSES} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.no-host-available-retry-timeout" ${PRESTO_CASSANDRA_NO_HOST_AVAILABLE_RETRY_TIMEOUT} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.speculative-execution.limit" ${PRESTO_CASSANDRA_SPECULATIVE_EXECUTION_LIMIT} "${PRESTO_CONNECTORS}/cassandra.properties"
    loadConfig "cassandra.speculative-execution.delay" ${PRESTO_CASSANDRA_SPECULATIVE_EXECUTION_DELAY} "${PRESTO_CONNECTORS}/cassandra.properties"
fi
# -----------------------------------------------------------------------------

# ------------------------ Load Redis Connector Configs ----------------------
if [ "${PRESTO_REDIS_NODES}" != "NULL" ]
    then
        echo "connector.name=redis" >> ${PRESTO_CONNECTORS}/redis.properties
        loadConfig "redis.nodes" ${PRESTO_REDIS_NODES} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.table-names" ${PRESTO_REDIS_TABLE_NAMES} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.scan-count" ${PRESTO_REDIS_SCAN_COUNT} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.key-prefix-schema-table" ${PRESTO_REDIS_KEY_PREFIX_SCHEMA_TABLE} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.key-delimiter" ${PRESTO_REDIS_KEY_DELIMITER} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.hide-internal-columns" ${PRESTO_REDIS_HIDE_INTERNAL_COLUMNS} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.database-index" ${PRESTO_REDIS_DATABASE_INDEX} "${PRESTO_CONNECTORS}/redis.properties"
        loadConfig "redis.password" ${PRESTO_REDIS_PASSWORD} "${PRESTO_CONNECTORS}/redis.properties"
fi
# ----------------------------------------------------------------------------

launcher start
tail -f /dev/null

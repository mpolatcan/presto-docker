FROM alpine

MAINTAINER Mutlu Polatcan <mutlupolatcan@gmail.com>

ENV PRESTO_HOME "/usr/local/presto"
ENV PRESTO_CONFIGS "/usr/local/presto/etc"
ENV PRESTO_CONNECTORS "/usr/local/presto/etc/catalog"
ENV PATH ${PATH}:${PRESTO_HOME}/bin

#-----------------------------------------------------------------------------------------------------------------------
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ PRESTO NODE CONFIGS /////////////////////////////////////////////////a
#-----------------------------------------------------------------------------------------------------------------------

# --------- Important Configs ----------
ENV PRESTO_COORDINATOR "NULL"
ENV PRESTO_NODE_SCHEDULER_INCLUDE_COORDINATOR "NULL"

# --------- Default configs ------------
ENV PRESTO_DATA_DIR "/var/presto/data"
ENV PRESTO_HTTP_SERVER_HTTP_PORT "8080"
ENV PRESTO_DISCOVERY_URI "http://0.0.0.0:8080"
ENV PRESTO_NODE_ENVIRONMENT "presto-default"
ENV PRESTO_DISCOVERY_SERVER_ENABLED "true"
ENV PRESTO_QUERY_MAX_MEMORY "4GB"
ENV PRESTO_QUERY_MAX_MEMORY_PER_NODE "1GB"

# ------------ Log level configs --------
ENV PRESTO_LOG_LEVEL "INFO"

# -------------- Jvm Configs ------------
ENV PRESTO_JVM_MAX_HEAP_SIZE "5G"
ENV PRESTO_JVM_MIN_HEAP_SIZE "1G"
ENV PRESTO_JVM_USE_G1GC "true"
ENV PRESTO_JVM_G1_HEAP_REGION_SIZE "32M"
ENV PRESTO_JVM_USE_GC_OVERHEAD_LIMIT "true"
ENV PRESTO_JVM_EXPLICIT_GC_INVOKES_CONCURRENT "true"
ENV PRESTO_JVM_HEAP_DUMP_ON_OUT_OF_MEMORY_ERR "true"
ENV PRESTO_EXIT_ON_OUT_OF_MEMORY_ERR "true"

#-----------------------------------------------------------------------------------------------------------------------
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ PRESTO CONNECTORS CONFIGS ///////////////////////////////////////////
#-----------------------------------------------------------------------------------------------------------------------

########################################################################################################################
#************************************************ KAFKA CONNECTOR ******************************************************
########################################################################################################################

# ------------------------- Important Configurations ------------------
ENV PRESTO_KAFKA_TABLE_NAMES "NULL"
ENV PRESTO_KAFKA_NODES "NULL"

# -------------------------- Optional Configurations ------------------
# These configs has default values for Cassandra
ENV PRESTO_KAFKA_CONNECT_TIMEOUT "10s"
ENV PRESTO_KAFKA_DEFAULT_SCHEMA "default"
ENV PRESTO_KAFKA_BUFFER_SIZE "64kB"
ENV PRESTO_KAFKA_HIDE_INTERNAL_COLUMNS "false"
#**********************************************************************

########################################################################################################################
#************************************************ CASSANDRA CONNECTOR **************************************************
########################################################################################################################

# ------------------ Important Configurations --------------------
ENV PRESTO_CASSANDRA_CONTACT_POINTS "NULL"

# ------------------ Optional Configurations ---------------------
ENV PRESTO_CASSANDRA_USERNAME "NULL"
ENV PRESTO_CASSANDRA_PASSWORD "NULL"
ENV PRESTO_CASSANDRA_FETCH_SIZE "NULL"
ENV PRESTO_CASSANDRA_PARTITION_SIZE_FOR_BATCH_SELECT "NULL"
ENV PRESTO_CASSANDRA_SPLIT_SIZE "NULL"
ENV PRESTO_CASSANDRA_CLIENT_READ_TIMEOUT "NULL"
ENV PRESTO_CASSANDRA_CLIENT_CONNECT_TIMEOUT "NULL"
ENV PRESTO_CASSANDRA_CLIENT_SO_LINGER "NULL"
ENV PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_LOCAL_DC "NULL"
ENV PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_USED_HOSTS_PER_REMOTE_DC "NULL"
ENV PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_ALLOW_REMOTE_DC_FOR_LOCAL "NULL"
ENV PRESTO_CASSANDRA_LOAD_POLICY_WHITE_LIST_ADDRESSES "NULL"

# These configs has default values for Cassandra Connectors
ENV PRESTO_CASSANDRA_NATIVE_PROTOCOL_PORT "9042"
ENV PRESTO_CASSANDRA_SPECULATIVE_EXECUTION_LIMIT "1"
ENV PRESTO_CASSANDRA_SPECULATIVE_EXECUTION_DELAY "500ms"
ENV PRESTO_CASSANDRA_NO_HOST_AVAILABLE_RETRY_TIMEOUT "1m"
ENV PRESTO_CASSANDRA_LOAD_POLICY_USE_WHITE_LIST "false"
ENV PRESTO_CASSANDRA_LOAD_POLICY_SHUFFLE_REPLICAS "false"
ENV PRESTO_CASSANDRA_LOAD_POLICY_USE_TOKEN_AWARE "false"
ENV PRESTO_CASSANDRA_LOAD_POLICY_USE_DC_AWARE "false"
ENV PRESTO_CASSANDRA_RETRY_POLICY "DEFAULT"
ENV PRESTO_CASSANDRA_CONSISTENCY_LEVEL "ONE"
ENV PRESTO_CASSANDRA_ALLOW_DROP_TABLE "false"

########################################################################################################################
#************************************************ REDIS CONNECTOR ******************************************************
########################################################################################################################
# ------------------ Important Configurations --------------------
ENV PRESTO_REDIS_NODES "NULL"
ENV PRESTO_REDIS_TABLE_NAMES "NULL"

# ------------------ Optional Configurations ---------------------
ENV PRESTO_REDIS_DEFAULT_SCHEMA "NULL"
ENV PRESTO_REDIS_SCAN_COUNT "NULL"
ENV PRESTO_REDIS_KEY_PREFIX_SCHEMA_TABLE "NULL"
ENV PRESTO_REDIS_KEY_DELIMITER "NULL"
ENV PRESTO_REDIS_DATABASE_INDEX "NULL"
ENV PRESTO_REDIS_PASSWORD "NULL"

# These configs has default values for Cassandra Connector
ENV PRESTO_REDIS_HIDE_INTERNAL_COLUMNS "false"
# ----------------------------------------------------------------------------------------------------------------------

ADD entrypoint.sh /

# Install Presto dependencies, extract and install Presto components, create configuration directories and
# move presto-cli to Presto installation folder
RUN apk --update add --no-cache openjdk8-jre python wget nano less && \
    wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.200/presto-server-0.200.tar.gz && \
    wget https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.200/presto-cli-0.200-executable.jar && \
    tar -xvzf presto-server-0.200.tar.gz && \
    rm presto-server-0.200.tar.gz && \
    mkdir -p ${PRESTO_HOME} ${PRESTO_DATA} ${PRESTO_CONFIGS} ${PRESTO_CONNECTORS} && \
    mv /presto-server-0.200/* ${PRESTO_HOME} && \
    rm -r /presto-server-0.200 && \
    chmod 777 presto-cli-0.200-executable.jar && \
    mv presto-cli-0.200-executable.jar presto && \
    mv presto ${PRESTO_HOME}/bin && \
    chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
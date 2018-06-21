# Presto for Docker

**Presto** is a distributed SQL query engine designed to query large data sets distributed over one or more heterogeneous data sources.

# Distributions

- **Presto v0.200 with Alpine Linux (with Java 8)**
- **Presto v0.200 Ubuntu 16.04 (with Java 8)**

# Deployment with Docker (via docker-compose)

## Pseudo-Distributed in Single Node
```yaml
version: "3.2"
services:
  ############################################################################################################################
  #                                    		    ZOOKEEPER                                                                 
  ############################################################################################################################
  zookeeper1:
    image: zookeeper
    container_name: zookeeper1
    restart: always
    hostname: zookeeper1
    environment:
      - ZOO_MY_ID=1
      - ZOO_SERVERS=server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888 
    ports:
      - 2181:2181
    volumes:
      - ./dockerbase:/dockerbase
      - ./dockerbase/data/zookeeper/zk1/data:/data
      - ./dockerbase/data/zookeeper/zk1/datalog:/datalog

  zookeeper2:
    image: zookeeper
    container_name: zookeeper2
    restart: always
    hostname: zookeeper2
    environment:
      - ZOO_MY_ID=2
      - ZOO_SERVERS=server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888 
    ports:
      - 2182:2181
    volumes:
      - ./dockerbase:/dockerbase
      - ./dockerbase/data/zookeeper/zk2/data:/data
      - ./dockerbase/data/zookeeper/zk2/datalog:/datalog

  zookeeper3:
    image: zookeeper
    container_name: zookeeper3
    restart: always
    hostname: zookeeper3
    environment:
      - ZOO_MY_ID=3
      - ZOO_SERVERS=server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888 
    ports:
      - 2183:2181
    volumes:
      - ./dockerbase:/dockerbase
      - ./dockerbase/data/zookeeper/zk3/data:/data
      - ./dockerbase/data/zookeeper/zk3/datalog:/datalog
  
  ############################################################################################################################
  #                                    		    KAFKA                                                                 
  ############################################################################################################################
  kafka1:
    image: wurstmeister/kafka
    container_name: kafka1
    restart: always
    hostname: kafka1
    ports:
     - 9092:9092
    environment:
      - KAFKA_BROKER_ID=1
      - KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
      - KAFKA_DELETE_TOPIC_ENABLE=true
      - KAFKA_ADVERTISED_HOST_NAME=kafka1
      - KAFKA_ADVERTISED_PORT=9092
      - MIN_INSYNC_REPLICASE=1
      - DEFAULT_REPLICATION_FACTOR=1
      - KAFKA_HEAP_OPTS=-Xms256m -Xmx256m
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181
    links:
      - zookeeper1
      - zookeeper2
      - zookeeper3
    depends_on:
      - zookeeper1
      - zookeeper2
      - zookeeper3

  kafka2:
    image: wurstmeister/kafka
    container_name: kafka2
    restart: always
    hostname: kafka2
    ports:
      - 9093:9092
    environment:
      - KAFKA_BROKER_ID=2
      - KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
      - KAFKA_DELETE_TOPIC_ENABLE=true
      - KAFKA_ADVERTISED_HOST_NAME=kafka2
      - KAFKA_ADVERTISED_PORT=9092
      - MIN_INSYNC_REPLICASE=1
      - DEFAULT_REPLICATION_FACTOR=1
      - KAFKA_HEAP_OPTS=-Xms256m -Xmx256m
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181
    links:
      - zookeeper1
      - zookeeper2
      - zookeeper3
    depends_on:
      - zookeeper1
      - zookeeper2
      - zookeeper3

  kafka3:
    image: wurstmeister/kafka
    container_name: kafka3
    restart: always
    hostname: kafka3
    ports:
      - 9094:9092
    environment:
      - KAFKA_BROKER_ID=3
      - KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
      - KAFKA_DELETE_TOPIC_ENABLE=true
      - KAFKA_ADVERTISED_HOST_NAME=kafka3
      - KAFKA_ADVERTISED_PORT=9092
      - MIN_INSYNC_REPLICASE=1
      - DEFAULT_REPLICATION_FACTOR=1
      - KAFKA_HEAP_OPTS=-Xms256m -Xmx256m
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181
    links:
      - zookeeper1
      - zookeeper2
      - zookeeper3
    depends_on:
      - zookeeper1
      - zookeeper2
      - zookeeper3
    
  presto_master:
    image: mpolatcan/presto:ubuntu
    container_name: presto-master
    hostname: presto-master
    restart: always
    ports:
      - 8080:8080
    environment:
      - PRESTO_KAFKA_NODES=kafka1:9092,kafka2:9092,kafka3:9092
      - PRESTO_KAFKA_TABLE_NAMES=tpch.customer,tpch.orders,tpch.lineitem,tpch.part,tpch.partsupp,tpch.supplier,tpch.nation,tpch.region
      - PRESTO_KAFKA_HIDE_INTERNAL_COLUMNS=false
      - PRESTO_COORDINATOR=true
      - PRESTO_NODE_SCHEDULER_INCLUDE_COORDINATOR=false
      - PRESTO_QUERY_MAX_MEMORY=5GB
      - PRESTO_QUERY_MAX_MEMORY_PER_NODE=1GB
      - PRESTO_DISCOVERY_SERVER_ENABLED=true
      - PRESTO_DISCOVERY_URI=http://0.0.0.0:8080
      - PRESTO_HTTP_SERVER_HTTP_PORT=8080
      - PRESTO_NODE_ENVIRONMENT=production
    depends_on:
      - kafka1
      - kafka2
      - kafka3
    links:
      - kafka1
      - kafka2
      - kafka3

  presto_worker:
    image: mpolatcan/presto:ubuntu
    restart: always
    environment:
      - PRESTO_KAFKA_NODES=kafka1:9092,kafka2:9092,kafka3:9092
      - PRESTO_KAFKA_TABLE_NAMES=tpch.customer,tpch.orders,tpch.lineitem,tpch.part,tpch.partsupp,tpch.supplier,tpch.nation,tpch.region
      - PRESTO_KAFKA_HIDE_INTERNAL_COLUMNS=false
      - PRESTO_COORDINATOR=false
      - PRESTO_HTTP_SERVER_HTTP_PORT=8080
      - PRESTO_QUERY_MAX_MEMORY=5GB
      - PRESTO_QUERY_MAX_MEMORY_PER_NODE=1GB
      - PRESTO_DISCOVERY_URI=http://presto-master:8080
      - PRESTO_NODE_ENVIRONMENT=production
    depends_on:
      - kafka1
      - kafka2
      - kafka3
      - presto_master
    links:
      - kafka1
      - kafka2
      - kafka3
      - presto_master
```

Run command at the below to deploy Presto with this compose file:

    sudo docker-compose up -d

If you want to scale up **Presto** worker add **--scale** option to command:

    For example, if you want to scale up Presto workers to 5 nodes, run this command:
     
        sudo docker-compose up -d --scale presto_worker=5

## Multi-Host with Overlay Network Architecture
Coming soon...
        
# Configuration with Environment Variables

- Node Configs:
    - **PRESTO_COORDINATOR:** Allow this Presto instance to function as a coordinator (accept queries from clients and 
        manage query execution).
    - **PRESTO_NODE_SCHEDULER_INCLUDE_COORDINATOR:** Allow scheduling work on the coordinator. For larger clusters, 
        processing work on the coordinator can impact query performance because the machine�s resources are not available 
        for the critical task of scheduling, managing and monitoring query execution.
    - **PRESTO_DATA_DIR:**
    - **PRESTO_HTTP_SERVER_HTTP_PORT:** Specifies the port for the HTTP server. Presto uses HTTP for all communication, 
        internal and external.
    - **PRESTO_DISCOVERY_URI:** The URI to the Discovery server. Because we have enabled the embedded version of Discovery 
        in the Presto coordinator, this should be the URI of the Presto coordinator. Replace example.net:8080 to match 
        the host and port of the Presto coordinator. This URI must not end in a slash.
    - **PRESTO_NODE_ENVIRONMENT:** The name of the environment. All Presto nodes in a cluster must have the same environment name.
    - **PRESTO_DATA_DIR:**  The location (filesystem path) of the data directory. Presto will store logs and other data here.
    - **PRESTO_DISCOVERY_SERVER_ENABLED:** Presto uses the Discovery service to find all the nodes in the cluster. Every 
        Presto instance will register itself with the Discovery service on startup. In order to simplify deployment and 
        avoid running an additional service, the Presto coordinator can run an embedded version of the Discovery service. 
        It shares the HTTP server with Presto and thus uses the same port.
    - **PRESTO_QUERY_MAX_MEMORY:** The maximum amount of distributed memory that a query may use.
    - **PRESTO_QUERY_MAX_MEMORY_PER_NODE:** The maximum amount of memory that a query may use on any one machine.

- Log Level Config:
    - **PRESTO_LOG_LEVEL:** This would set the minimum level to **INFO** for both ***com.facebook.presto.server*** and 
        ***com.facebook.presto.hive***. The default minimum level is **INFO** (thus the above example does not actually change anything). 
        There are four levels: **DEBUG, INFO, WARN** and **ERROR.**

- JVM Configs:
    - **PRESTO_JVM_MAX_HEAP_SIZE**
    - **PRESTO_JVM_MIN_HEAP_SIZE**
    - **PRESTO_JVM_USE_G1GC**
    - **PRESTO_JVM_G1_HEAP_REGION_SIZE**
    - **PRESTO_JVM_USE_GC_OVERHEAD_LIMIT**
    - **PRESTO_JVM_EXPLICIT_GC_INVOKES_CONCURRENT**
    - **PRESTO_JVM_HEAP_DUMP_ON_OUT_OF_MEMORY_ERR**
    - **PRESTO_EXIT_ON_OUT_OF_MEMORY_ERR**

- Kafka Connector Configs: 
    - **PRESTO_KAFKA_NODES:** A comma separated list of hostname:port pairs for the Kafka data nodes.
        This property is required; there is no default and at least one node must be defined.
    - **PRESTO_KAFKA_TABLE_NAMES:** Comma-separated list of all tables provided by this catalog. A table name can be 
        unqualified (simple name) and will be put into the default schema (see below) or qualified with a schema name 
        (<schema-name>.<table-name>).
    - **PRESTO_KAFKA_CONNECT_TIMEOUT:** Timeout for connecting to a data node. A busy Kafka cluster may take quite some 
        time before accepting a connection; when seeing failed queries due to timeouts, increasing this value is a good 
        strategy. This property is optional; the default is 10 seconds (**10s**).
    - **PRESTO_KAFKA_DEFAULT_SCHEMA:** Defines the schema which will contain all tables that were defined without a 
        qualifying schema name. This property is optional; the default is default.
    - **PRESTO_KAFKA_BUFFER_SIZE:** Size of the internal data buffer for reading data from Kafka. The data buffer must 
        be able to hold at least one message and ideally can hold many messages. There is one data buffer allocated per 
        worker and data node. This property is optional; the default is **64kb**.
    - **PRESTO_KAFKA_HIDE_INTERNAL_COLUMNS:** In addition to the data columns defined in a table description file, the 
        connector maintains a number of additional columns for each table. If these columns are hidden, they can still 
        be used in queries but do not show up in **DESCRIBE <table-name> or SELECT** *. This property is optional; the default 
        is **true**.
                                             
- Redis Connector Configs:
    - **PRESTO_REDIS_NODES:** The hostname:port pair for the Redis server. This property is required; there is no default.
        Redis clusters are not supported.
    - **PRESTO_REDIS_TABLE_NAMES:** Comma-separated list of all tables provided by this catalog. A table name can be unqualified 
        (simple name) and will be put into the default schema (see below) or qualified with a schema name 
        (<schema-name>.<table-name>).
    - **PRESTO_REDIS_DEFAULT_SCHEMA:**
    - **PRESTO_REDIS_SCAN_COUNT:** The internal COUNT parameter for Redis SCAN command when connector is using SCAN to find 
        keys for the data. This parameter can be used to tune performance of the Redis connector. This property is optional; 
        the default is **100**.
    - **PRESTO_REDIS_KEY_PREFIX_SCHEMA_TABLE:** If true, only keys prefixed with the schema-name:table-name are be scanned 
        for a table, and all other keys will be filtered out. If false, all keys are scanned.This property is optional; 
        the default is **false**.
    - **PRESTO_REDIS_KEY_DELIMITER:** The character used for separating schema-name and table-name when redis.key-prefix-schema-table 
        is **true**. This property is optional; the default is **:**.
    - **PRESTO_REDIS_DATABASE_INDEX:** The Redis database to query. This property is optional; the default is **0**.
    - **PRESTO_REDIS_PASSWORD:** The password for password-protected Redis server. This property is optional; the default is null.
    - **PRESTO_REDIS_HIDE_INTERNAL_COLUMNS:** In addition to the data columns defined in a table description file, the connector 
        maintains a number of additional columns for each table. If these columns are hidden, they can still be used in 
        queries but do not show up in **DESCRIBE <table-name> or SELECT** *. This property is optional; the default is **false**.

- Cassandra Connector Configs:
    - **PRESTO_CASSANDRA_CONTACT_POINTS:** Comma-separated list of hosts in a Cassandra cluster. The Cassandra driver will 
        use these contact points to discover cluster topology. At least one Cassandra host is required.
    - **PRESTO_CASSANDRA_USERNAME:** Username used for authentication to the Cassandra cluster. This is a global setting 
        used for all connections, regardless of the user who is connected to Presto.
    - **PRESTO_CASSANDRA_PASSWORD:** Password used for authentication to the Cassandra cluster. This is a global setting 
        used for all connections, regardless of the user who is connected to Presto.
    - **PRESTO_CASSANDRA_FETCH_SIZE:** Number of rows fetched at a time in a Cassandra query.
    - **PRESTO_CASSANDRA_PARTITION_SIZE_FOR_BATCH_SELECT:** Number of partitions batched together into a single select 
        for a single partition key column table.
    - **PRESTO_CASSANDRA_SPLIT_SIZE:** Number of keys per split when querying Cassandra.
    - **PRESTO_CASSANDRA_CLIENT_READ_TIMEOUT:** Maximum time the Cassandra driver will wait for an answer to a query from 
        one Cassandra node. Note that the underlying Cassandra driver may retry a query against more than one node in the 
        event of a read timeout. Increasing this may help with queries that use an index.
    - **PRESTO_CASSANDRA_CLIENT_CONNECT_TIMEOUT:** Maximum time the Cassandra driver will wait to establish a connection 
        to a Cassandra node. Increasing this may help with heavily loaded Cassandra clusters.
    - **PRESTO_CASSANDRA_CLIENT_SO_LINGER:** Number of seconds to linger on close if unsent data is queued. If set to zero, 
        the socket will be closed immediately. When this option is non-zero, a socket will linger that many seconds for an 
        acknowledgement that all data was written to a peer. This option can be used to avoid consuming sockets on a 
        Cassandra server by immediately closing connections when they are no longer needed.
    - **PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_LOCAL_DC:** The name of the local datacenter for **DCAwareRoundRobinPolicy**.
    - **PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_USED_HOSTS_PER_REMOTE_DC:** Uses the provided number of host per remote 
        datacenter as failover for the local hosts for **DCAwareRoundRobinPolicy**.
    - **PRESTO_CASSANDRA_LOAD_POLICY_DC_AWARE_ALLOW_REMOTE_DC_FOR_LOCAL:** Set to **true** to allow to use hosts of remote 
        datacenter for local consistency level.
    - **PRESTO_CASSANDRA_LOAD_POLICY_WHITE_LIST_ADDRESSES:** Comma-separated list of hosts for **WhiteListPolicy**.
    - **PRESTO_CASSANDRA_NATIVE_PROTOCOL_PORT:** The Cassandra server port running the native client protocol (defaults to **9042**).
    - **PRESTO_CASSANDRA_SPECULATIVE_EXECUTION_LIMIT:** The number of speculative executions (defaults to **1**).
    - **PRESTO_CASSANDRA_SPECULATIVE_EXECUTION_DELAY:** The delay between each speculative execution (defaults to **500ms**).
    - **PRESTO_CASSANDRA_NO_HOST_AVAILABLE_RETRY_TIMEOUT:** Retry timeout for NoHostAvailableException (defaults to **1m**).
    - **PRESTO_CASSANDRA_LOAD_POLICY_USE_WHITE_LIST:** Set to true to use WhiteListPolicy (defaults to **false**).
    - **PRESTO_CASSANDRA_LOAD_POLICY_SHUFFLE_REPLICAS:** Set to true to use TokenAwarePolicy with shuffling of replicas (defaults to **false**).
    - **PRESTO_CASSANDRA_LOAD_POLICY_USE_TOKEN_AWARE:** Set to true to use TokenAwarePolicy (defaults to **false**).  
    - **PRESTO_CASSANDRA_LOAD_POLICY_USE_DC_AWARE:** Set to true to use DCAwareRoundRobinPolicy (defaults to **false**).
    - **PRESTO_CASSANDRA_RETRY_POLICY:** Policy used to retry failed requests to Cassandra. This property defaults to 
        **DEFAULT**. Using **BACKOFF** may help when queries fail with �not enough replicas�. The other possible values are 
        **DOWNGRADING_CONSISTENCY** and **FALLTHROUGH**.
    - **PRESTO_CASSANDRA_CONSISTENCY_LEVEL:** Consistency levels in Cassandra refer to the level of consistency to be 
        used for both read and write operations. More information about consistency levels can be found in the Cassandra 
        consistency documentation. This property defaults to a consistency level of **ONE**. Possible values include **ALL, 
        EACH_QUORUM, QUORUM, LOCAL_QUORUM, ONE, TWO, THREE, LOCAL_ONE, ANY, SERIAL, LOCAL_SERIAL**.
    - **PRESTO_CASSANDRA_ALLOW_DROP_TABLE:** Set to **true** to allow dropping Cassandra tables from Presto via **DROP TABLE**
        (defaults to **false**).

# Presto CLI Usage

To query data from any source, you need to run this command:
    
    presto --catalog <data_source> --schema <schema_name> 
    
For example, if you want to query data from Kafka topic which is named **"example"**, you need to run this command:
  
    presto --catalog kafka --schema example
    

ARG JAVA_VERSION="11"

FROM mpolatcan/presto:base-java${JAVA_VERSION}

MAINTAINER Mutlu Polatcan <mutlupolatcan@gmail.com>

ARG PRESTO_VERSION="344"
ARG PRESTO_DOWNLOAD_LINK="https://repo1.maven.org/maven2/io/prestosql/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz"
ARG PRESTO_CLI_DOWNLOAD_LINK="https://repo1.maven.org/maven2/io/prestosql/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar"

RUN wget ${PRESTO_DOWNLOAD_LINK} ${PRESTO_CLI_DOWNLOAD_LINK} && \
    tar -xvzf presto-server-${PRESTO_VERSION}.tar.gz -C ${PRESTO_USER_HOME} && \
    mv ${PRESTO_USER_HOME}/presto-server-${PRESTO_VERSION}/* ${PRESTO_HOME} && \
    mv presto-cli-${PRESTO_VERSION}-executable.jar presto && \
    chmod +x presto && \
    mv presto ${PRESTO_HOME}/bin && \
    chown -R presto:presto ${PRESTO_USER_HOME} && \
    rm -r ${PRESTO_USER_HOME}/presto-server-${PRESTO_VERSION} presto-server-${PRESTO_VERSION}.tar.gz

USER presto
WORKDIR ${PRESTO_USER_HOME}
ENTRYPOINT ["./entrypoint.sh"]
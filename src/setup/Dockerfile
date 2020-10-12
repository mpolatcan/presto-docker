ARG JAVA_VERSION="11"

FROM mpolatcan/presto:base-java${JAVA_VERSION}

MAINTAINER Mutlu Polatcan <mutlupolatcan@gmail.com>

ARG PRESTO_VERSION="344"
ARG PRESTO_DOWNLOAD_LINK="https://repo1.maven.org/maven2/io/prestosql/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz"

RUN wget ${PRESTO_DOWNLOAD_LINK} && \
    tar -xvzf presto-server-${PRESTO_VERSION}.tar.gz -C ${PRESTO_USER_HOME} && \
    mv ${PRESTO_USER_HOME}/presto-server-${PRESTO_VERSION}/* ${PRESTO_HOME} && \
    chown -R presto:presto ${PRESTO_USER_HOME} && \
    rm -r ${PRESTO_USER_HOME}/presto-server-${PRESTO_VERSION} presto-server-${PRESTO_VERSION}.tar.gz

USER presto
WORKDIR ${PRESTO_USER_HOME}
ENTRYPOINT ["tail", "-f", "/dev/null"]
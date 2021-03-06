FROM azul/zulu-openjdk:11

MAINTAINER Mutlu Polatcan <mutlupolatcan@gmail.com>

ENV PRESTO_USER_HOME="/home/presto"
ENV PRESTO_HOME="${PRESTO_USER_HOME}/presto"
ENV PRESTO_DATA_DIR="${PRESTO_USER_HOME}/data"
ENV PRESTO_CONF_DIR="${PRESTO_HOME}/etc"
ENV PRESTO_CONNECTOR_CONF_DIR="${PRESTO_CONF_DIR}/catalog"
ENV PATH=$PATH:${PRESTO_HOME}/bin

ADD entrypoint.sh ${PRESTO_USER_HOME}/entrypoint.sh
ADD config_loader.sh ${PRESTO_USER_HOME}/presto_config_loader.sh
ADD presto_coordinator_leader_elector.sh ${PRESTO_USER_HOME}/presto_coordinator_leader_elector.sh

RUN apt-get update && \
    apt-get -y install --no-install-recommends python \
                                               wget \
                                               nano \
                                               less \
                                               curl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    addgroup presto && adduser --disabled-password --gecos "" --ingroup presto presto && \
    mkdir -p ${PRESTO_HOME} ${PRESTO_CONF_DIR} ${PRESTO_CONNECTOR_CONF_DIR} ${PRESTO_DATA_DIR} && \
    chown -R presto:presto ${PRESTO_USER_HOME} && \
    chmod +x ${PRESTO_USER_HOME}/entrypoint.sh \
             ${PRESTO_USER_HOME}/presto_config_loader.sh \
             ${PRESTO_USER_HOME}/presto_coordinator_leader_elector.sh

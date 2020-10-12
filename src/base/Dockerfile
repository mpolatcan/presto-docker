FROM azul/zulu-openjdk:11

MAINTAINER Mutlu Polatcan <mutlupolatcan@gmail.com>

ENV PRESTO_USER_HOME="/home/presto"
ENV PRESTO_HOME="${PRESTO_USER_HOME}/presto"
ENV PRESTO_DATA_DIR="${PRESTO_USER_HOME}/data"
ENV PRESTO_CONF_DIR="${PRESTO_HOME}/etc"
ENV PATH=$PATH:${PRESTO_HOME}/bin

ADD config_loader.sh ${PRESTO_USER_HOME}/config_loader.sh

RUN apt-get update && \
    apt-get -y install --no-install-recommends python \
                                               wget && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup presto && adduser --disabled-password --gecos "" --ingroup presto presto && \
    mkdir -p ${PRESTO_HOME} ${PRESTO_CONF_DIR} ${PRESTO_DATA_DIR} && \
    chown -R presto:presto ${PRESTO_USER_HOME} && \
    chmod +x ${PRESTO_USER_HOME}/config_loader.sh
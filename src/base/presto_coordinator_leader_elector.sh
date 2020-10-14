#!/bin/bash

function is_leader() {
    AVAILABLE_POD_COUNT=$(kubectl get pods | grep presto-coordinator | wc -l | awk '{print $1}')
    OTHER_PODS=$(for i in $(seq 0 $(($AVAILABLE_POD_COUNT-1))); do echo presto-coordinator-$i; done | grep -v $HOSTNAME)

    for OTHER_POD in ${OTHER_PODS[@]}; do
        curl -I $OTHER_POD.presto-coordinator:${HTTP_SERVER_HTTP_PORT:=8080}

        if [[ $? -eq 0 ]]; then
            return 1
        fi
    done

    return 0
}

is_leader
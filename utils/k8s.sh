#/bin/bash

# $1 keywords
# using kubectl get pods -A 
# exmaple:
# check_pod_status calico
check_pod_status()
{
    local status=$(kubectl get po -A | grep $1 | awk '{print $4}')
    echo $status
}




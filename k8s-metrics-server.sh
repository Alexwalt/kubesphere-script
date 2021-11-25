#!/bin/bash

status=$(kubectl get po -A | grep metrics | awk '{print $4}')
if [ $status == "Running" ]
then
    echo "跳过安装，metrics server 已经安装并运行"
    exit 0
fi

kubectl apply -f $PWD/metrics-server.yaml

# 等待安装完成
status=NONE
printf "waiting "
while [ $status != "Running" ]
do
    sleep 8s
    status=$(kubectl get po -A | grep metrics | awk '{print $4}')
    printf "."
done
printf "/n"
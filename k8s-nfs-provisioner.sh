#!/bin/bash

status=$(kubectl get po -A | grep nfs | awk '{print $4}')
if [ $status == "Running" ]
then
    echo "跳过安装，nfs provisioner 已经安装并运行"
    exit 0
fi

kubectl apply -f $PWD/default-sc-nfs.yaml

# 等待默认存储安装完成
status=FAILED

while [ $status != "Running" ]
do
    sleep 2s
    status=$(kubectl get po -A | grep nfs | awk '{print $4}')
    echo $status
done
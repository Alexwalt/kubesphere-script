#/bin/bash

# ./install-nfs.sh

# 前置环境安装

./k8s-nfs-provisioner.sh
./k8s-metrics-server.sh


export KKZONE=cn

kubectl apply -f kubesphere-installer.yaml
kubectl apply -f cluster-configuration.yaml


# 等待默认存储安装完成
status=FAILED
printf "waiting "
while [ $status != "Running" ]
do
    sleep 2s
    status=$(kubectl get po -A | grep ks-installer | awk '{print $4}')
        printf "."
done
printf "/n"

kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f

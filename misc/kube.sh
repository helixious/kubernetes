#!/bin/bash

if [ $1 = install ]; then
    echo "1) pulling nginx ingress repo"
    git clone https://github.com/nginxinc/kubernetes-ingress/
    cd kubernetes-ingress/deployments
    git checkout v1.7.1
    kubectl apply -f common/ns-and-sa.yaml

    echo "2) configure RBAC"
    kubectl apply -f common/ns-and-sa.yaml
    kubectl apply -f rbac/rbac.yaml

    echo "3) create common resources"
    kubectl apply -f common/default-server-secret.yaml

    echo "3.1) create config map"
    kubectl apply -f common/nginx-config.yaml

    echo "3.2) create custom resource def for VS VSR & TS"
    kubectl apply -f common/vs-definition.yaml
    kubectl apply -f common/vsr-definition.yaml
    kubectl apply -f common/ts-definition.yaml

    echo "3.3) Create Global Configuration resource defintion"
    kubectl apply -f common/gc-definition.yaml

    echo "3.4) Create Global Configuration resource"
    kubectl apply -f common/global-configuration.yaml

    echo "4) Deploy Ingress Controller (DeamonSet)"
    kubectl apply -f daemon-set/nginx-ingress.yaml
elif [ $1 = reset ]; then
    kubectl delete namespace nginx-ingress
    kubectl delete clusterrole nginx-ingress
    kubectl delete clusterrolebinding nginx-ingress
else
    echo "missing params install or reset"
fi

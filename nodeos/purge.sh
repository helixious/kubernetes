#!/bin/bash
microk8s kubectl -n nodeos delete statefulset nodeos
microk8s kubectl -n nodeos delete svc nodeos-svc
microk8s kubectl -n nodeos delete svc nginx-svc
microk8s kubectl delete namespace nodeos
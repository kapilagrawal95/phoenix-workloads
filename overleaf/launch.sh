#!/bin/bash
IP=$(hostname -I | awk '{print $1}')
SHARELATEX_REAL_TIME_URL_VALUE=$IP":30911" 
kubectl create namespace overleaf
kubectl config set-context --current --namespace=your-namespace
kubectl apply -Rf kubernetes/
envsubst < "kubernetes/web-deployment.yaml" | kubectl apply -f -


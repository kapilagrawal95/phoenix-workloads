#!/bin/bash

kubectl create namespace overleaf
kubectl config set-context --current --namespace=overleaf
cd kubernetes
kubectl apply -f mongo-pv.yaml
kubectl apply -f mongo-deployment.yaml
kubectl apply -f mongo-service.yaml
kubectl apply -f redis-deployment.yaml
kubectl apply -f redis-service.yaml
kubectl apply -f filestore-pv.yaml
kubectl apply -f filestore-deployment.yaml
kubectl apply -f filestore-service.yaml
kubectl apply -f docstore-pv.yaml
kubectl apply -f docstore-deployment.yaml
kubectl apply -f docstore-service.yaml
kubectl apply -f tags-pv.yaml
kubectl apply -f tags-deployment.yaml
kubectl apply -f tags-service.yaml
kubectl apply -f realtime-deployment.yaml
kubectl apply -f realtime-service.yaml
sleep 10
kubectl apply -f contacts-pv.yaml
kubectl apply -f contacts-deployment.yaml
kubectl apply -f contacts-service.yaml
kubectl apply -f clsi-pv.yaml
kubectl apply -f clsi-deployment.yaml
kubectl apply -f clsi-service.yaml
kubectl apply -f document-updater-deployment.yaml
kubectl apply -f document-updater-service.yaml
kubectl apply -f notifications-pv.yaml
kubectl apply -f notifications-deployment.yaml
kubectl apply -f notifications-service.yaml
kubectl apply -f spelling-pv.yaml
kubectl apply -f spelling-deployment.yaml
kubectl apply -f spelling-service.yaml
kubectl apply -f track-changes-pv.yaml
kubectl apply -f track-changes-deployment.yaml
kubectl apply -f track-changes-service.yaml
sleep 10
IP=$(hostname -I | awk '{print $1}')
SHARELATEX_REAL_TIME_URL_VALUE=$IP":30911" 
envsubst < "web-deployment.yaml" | kubectl apply -f -
sleep 10


echo "Access overleaf at:"$IP":30910 ! wait but first create users from create_users script by logging into the master node!"
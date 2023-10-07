#!/bin/bash

# install istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.19.1
setenv PATH $PWD/bin:$PATH
istioctl install
kubectl apply -f sample/addons/grafana.yaml
kubectl apply -f sample/addons/prometheus.yaml
kubectl apply -f sample/addons/kiali.yaml
kubectl apply -f sample/addons/jaeger.yaml

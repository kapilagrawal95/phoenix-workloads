kubectl create namespace hotelreservation
# kubectl label namespace hotelreservation istio-injection=enabled

kubectl config set-context --current --namespace=hotelreservation
cd kubernetes
kubectl apply -Rf hotel-res-core/
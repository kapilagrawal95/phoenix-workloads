kubectl create namespace hotelReservation
kubectl label namespace hotelReservation istio-injection=enabled

kubectl config set-context --current --namespace=hotelReservation
cd kubernetes
kubectl apply -Rf hotel-res-core/
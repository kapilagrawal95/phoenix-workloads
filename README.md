
# Phoenix Workloads

## On start
Run the script setup.sh
this will install istio with grafana, prometheus, kiali and expose them
## Overleaf
follow instructions.txt in kubernetes. Soon to replace with launch.sh

In launch.sh REAL_TIME_URL is not being set correctly. Fix it!
To create users, cd into overleaf and run the command: python3 create_users.py. This will create users of the following
username: user1@netsail.uci.edu
password: iamuser1

replace 1 with i from {1, 100}

# hotelReservation
cd deathstarbench/hotelReservation
bash launch.sh 
this script creates a namespace hotelReservation, adds istio label, and deploys all the pods and services.

# Spark
Coming soon

### Follow another repo phoenix-loadgenerator for how to generate load,
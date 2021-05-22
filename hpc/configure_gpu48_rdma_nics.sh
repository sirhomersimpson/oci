#!/bin/bash

#####################################################
# This bash sets up the IP for the Cluster Network
# RDMA NICS for GPU48 shapes for 2 Nodes
# https://blogs.oracle.com/cloud-infrastructure/nvidia-a100-bare-metal-performance-in-oracle-cloud-infrastructure
# It generates network interfaces for the 8x2 Mellanox NICs that are connected to the GPU
# You need to copy the files as sudo to /etc/network/interfaces/intefaces.d and ifup then
#####################################################
######## configures ips for Cluster network
# Step 1 define NETMASK - use ipcalc to see range
netmask=255.255.255.252
unset map_of_ips
declare -A map_of_ips
map_of_ips["enp72s0f0"]="172.16.0.2" 
map_of_ips["enp72s0f1"]="172.16.0.22"
map_of_ips["enp76s0f0"]="172.16.0.42" 
map_of_ips["enp76s0f1"]="172.16.0.62"
# NA map_of_ips["enp45s0f1"]="192.168.1.30"
map_of_ips["enp12s0f0"]="172.16.0.82" 
map_of_ips["enp12s0f1"]="172.16.0.102"
map_of_ips["enp22s0f0"]="172.16.0.122" 
map_of_ips["enp22s0f1"]="172.16.0.142"
map_of_ips["enp195s0f0"]="172.16.0.162" 
map_of_ips["enp195s0f1"]="172.16.0.182"
map_of_ips["enp209s0f0"]="172.16.0.202" 
map_of_ips["enp209s0f1"]="172.16.0.222"
map_of_ips["enp138s0f0"]="172.16.0.242" 
map_of_ips["enp138s0f1"]="172.16.1.3"
map_of_ips["enp148s0f0"]="172.16.1.22" 
map_of_ips["enp148s0f1"]="172.16.1.42"
CX5=(enp72s0f0 enp72s0f1 enp76s0f0 enp76s0f1 enp12s0f0 enp12s0f1 enp22s0f0 enp22s0f1 enp195s0f0 enp195s0f1 enp209s0f0 enp209s0f1 enp138s0f0 enp138s0f1 enp148s0f0 enp148s0f1)

echo Interfaces list -> ${CX5[@]}
for interfaces in ${CX5[@]}; do
        #ifup $i
        echo Creating interface file for:$interfaces, IP:${map_of_ips[$interfaces]}
        cat <<EOF > ifcfg-${interfaces}
iface ${interfaces} inet static
address ${map_of_ips[$interfaces]}
netmask ${netmask}
EOF
done


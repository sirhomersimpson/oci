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
# My usual configurations for 2 Nodes in CN
#                              Node 1                 Node 2
#mlnx5_0	enp72s0f0	192.168.1.1/29	        192.168.1.2/29
#mlnx5_1	enp72s0f1	192.168.1.9/29	        192.168.1.10/29
#mlnx5_2	enp76s0f0	192.168.1.17/29	        192.168.1.18/29
#mlnx5_3	enp76s0f1	192.168.1.25/29	        192.168.1.26/29
#mlnx5_5	enp45s0f1	192.168.1.30/29	        192.168.1.31/29
#mlnx5_6	enp12s0f0	192.168.1.33/29	        192.168.1.34/29
#mlnx5_7	enp12s0f1	192.168.1.41/29	        192.168.1.42/29
#mlnx5_8	enp22s0f0	192.168.1.49/29	        192.168.1.50/29
#mlnx5_9	enp22s0f1	192.168.1.57/29	        192.168.1.58/29
#mlnx5_10	enp195s0f0	192.168.1.65/29	        192.168.1.66/29
#mlnx5_11	enp195s0f1	192.168.1.73/29	        192.168.1.74/29
#mlnx5_12	enp209s0f0	192.168.1.81/29	        192.168.1.82/29
#mlnx5_13	enp209s0f1	192.168.1.89/29	        192.168.1.90/29
#mlnx5_14	enp138s0f0	192.168.1.97/29	        192.168.1.98/29
#mlnx5_15	enp138s0f1	192.168.1.105/29	    192.168.1.106/29
#mlnx5_16	enp148s0f0	192.168.1.113/29	    192.168.1.114/29
#mlnx5_17	enp148s0f1	192.168.1.121/29	    192.168.1.122/29
#

netmask=255.255.255.248
unset map_of_ips
declare -A map_of_ips

<< 'COMMENTED-HOSTS'
Host A
map_of_ips["enp72s0f0"]="192.168.1.1" 
map_of_ips["enp72s0f1"]="192.168.1.9"
map_of_ips["enp76s0f0"]="192.168.1.17" 
map_of_ips["enp76s0f1"]="192.168.1.25"
# NA map_of_ips["enp45s0f1"]="192.168.1.30"
map_of_ips["enp12s0f0"]="192.168.1.33" 
map_of_ips["enp12s0f1"]="192.168.1.41"
map_of_ips["enp22s0f0"]="192.168.1.49" 
map_of_ips["enp22s0f1"]="192.168.1.57"
map_of_ips["enp195s0f0"]="192.168.1.65" 
map_of_ips["enp195s0f1"]="192.168.1.73"
map_of_ips["enp209s0f0"]="192.168.1.81" 
map_of_ips["enp209s0f1"]="192.168.1.89"
map_of_ips["enp138s0f0"]="192.168.1.97" 
map_of_ips["enp138s0f1"]="192.168.1.105"
map_of_ips["enp148s0f0"]="192.168.1.113" 
map_of_ips["enp148s0f1"]="192.168.1.121"

#Host B 
map_of_ips["enp72s0f0"]="192.168.1.2" 
map_of_ips["enp72s0f1"]="192.168.1.10"
map_of_ips["enp76s0f0"]="192.168.1.18" 
map_of_ips["enp76s0f1"]="192.168.1.26"
# NA map_of_ips["enp45s0f1"]="192.168.1.30"
map_of_ips["enp12s0f0"]="192.168.1.34" 
map_of_ips["enp12s0f1"]="192.168.1.42"
map_of_ips["enp22s0f0"]="192.168.1.50" 
map_of_ips["enp22s0f1"]="192.168.1.58"
map_of_ips["enp195s0f0"]="192.168.1.66" 
map_of_ips["enp195s0f1"]="192.168.1.74"
map_of_ips["enp209s0f0"]="192.168.1.82" 
map_of_ips["enp209s0f1"]="192.168.1.90"
map_of_ips["enp138s0f0"]="192.168.1.98" 
map_of_ips["enp138s0f1"]="192.168.1.106"
map_of_ips["enp148s0f0"]="192.168.1.114" 
map_of_ips["enp148s0f1"]="192.168.1.122"
COMMENTED-HOSTS

#Host C 
map_of_ips["enp72s0f0"]="192.168.1.3" 
map_of_ips["enp72s0f1"]="192.168.1.11"
map_of_ips["enp76s0f0"]="192.168.1.19" 
map_of_ips["enp76s0f1"]="192.168.1.27"
# NA map_of_ips["enp45s0f1"]="192.168.1.30"
map_of_ips["enp12s0f0"]="192.168.1.35" 
map_of_ips["enp12s0f1"]="192.168.1.43"
map_of_ips["enp22s0f0"]="192.168.1.51" 
map_of_ips["enp22s0f1"]="192.168.1.59"
map_of_ips["enp195s0f0"]="192.168.1.67" 
map_of_ips["enp195s0f1"]="192.168.1.75"
map_of_ips["enp209s0f0"]="192.168.1.83" 
map_of_ips["enp209s0f1"]="192.168.1.91"
map_of_ips["enp138s0f0"]="192.168.1.99" 
map_of_ips["enp138s0f1"]="192.168.1.107"
map_of_ips["enp148s0f0"]="192.168.1.115" 
map_of_ips["enp148s0f1"]="192.168.1.123"
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


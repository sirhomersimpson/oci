#!/bin/bash

#####################################################
# This bash sets up the IP for the Cluster Network
# RDMA NICS for  GPU48 shapes
# https://blogs.oracle.com/cloud-infrastructure/nvidia-a100-bare-metal-performance-in-oracle-cloud-infrastructure
#####################################################
######## configures ips for Cluster network
# Step 1 define NETMASK - use ipcalc to see range
# My usual configurations for 2 Nodes in CN
#                              Node 1                 Node 2
#mlnx5_0	enp72s0f0	192.168.1.1/29	        192.168.1.2/29
#mlnx5_1	enp72s0f1	192.168.1.9/29	        192.168.1.10/29
#mlnx5_2	enp76s0f0	192.168.1.17/29	192.168.1.18/29
#mlnx5_3	enp76s0f1	192.168.1.25/29	192.168.1.26/29
#mlnx5_5	enp45s0f1	192.168.1.30/29	192.168.1.31/29
#mlnx5_6	enp12s0f0	192.168.1.33/29	192.168.1.34/29
#mlnx5_7	enp12s0f1	192.168.1.41/29	192.168.1.42/29
#mlnx5_8	enp22s0f0	192.168.1.49/29	192.168.1.50/29
#mlnx5_9	enp22s0f1	192.168.1.57/29	192.168.1.58/29
#mlnx5_10	enp195s0f0	192.168.1.65/29	192.168.1.66/29
#mlnx5_11	enp195s0f1	192.168.1.73/29	192.168.1.74/29
#mlnx5_12	enp209s0f0	192.168.1.81/29	192.168.1.82/29
#mlnx5_13	enp209s0f1	192.168.1.89/29	192.168.1.90/29
#mlnx5_14	enp138s0f0	192.168.1.97/29	192.168.1.98/29
#mlnx5_15	enp138s0f1	192.168.1.105/29	192.168.1.106/29
#mlnx5_16	enp148s0f0	192.168.1.113/29	192.168.1.114/29
#mlnx5_17	enp148s0f1	192.168.1.121/29	192.168.1.122/29
#

netmask=255.255.255.248
unset map_of_ips
declare -A map_of_ips=( ["enp72s0f0"]="192.168.1.1" ["enp72s0f1"]="192.168.1.9"\ ["enp76s0f0"]="192.168.1.17" ["enp76s0f1"]="192.168.1.25"\
["enp45s0f1"]="192.168.1.30"\
["enp12s0f0"]="192.168.1.33" ["enp12s0f1"]="192.168.1.41"\
["enp22s0f0"]="192.168.1.49" ["enp22s0f1"]="192.168.1.57"\
["enp195s0f0"]="192.168.1.65" ["enp195s0f1"]="192.168.1.73"\
["enp209s0f0"]="192.168.1.81" ["enp209s0f1"]="192.168.1.89"\
["enp138s0f0"]="192.168.1.97" ["enp138s0f1"]="192.168.1.105"\
["enp148s0f0"]="192.168.1.113" ["enp148s0f1"]="192.168.1.121"\

) 
CX5=(enp72s0f0 enp72s0f1 enp76s0f0 enp76s0f1 enp12s0f0 enp12s0f1 enp22s0f0 enp22s0f1 enp195s0f0 enp195s0f1 enp209s0f0 enp209s0f1 enp138s0f0 enp138s0f1 enp148s0f0 enp148s0f1)

for interfaces in ${CX5[@]}; do
        echo "here"
        echo intefaces $interfaces
        #ifup $i
        echo ${map_of_ips[$interfaces]}
        cat <<EOF > ifcfg-${interfaces}
iface ${interfaces} inet static
address ${map_of_ips[$interfaces]}
netmask ${netmask}
EOF
done


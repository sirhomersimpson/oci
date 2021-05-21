#!/bin/bash

# At times rp_filter is not set to 1
# This will fail for NCCL tests and GPU workloads
# Best practice set up is 

sudo sysctl -w net.ipv4.conf.all.rp_filter=1
sudo sysctl -w net.ipv4.conf.default.rp_filter=1
CX5=(enp72s0f0 enp72s0f1 enp76s0f0 enp76s0f1 enp12s0f0 enp12s0f1 enp22s0f0 enp22s0f1 enp195s0f0 enp195s0f1 enp209s0f0 enp209s0f1 enp138s0f0 enp138s0f1 enp148s0f0 enp148s0f1)
for i in ${CX5[@]}; do
        echo $i
        sudo sysctl -w net.ipv4.conf.${i}.rp_filter=1
done

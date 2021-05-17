#!/bin/bash
#### Brings up all NIC interfaces
#### you need to ensure you have the interfaces in /etc/network/interfaces.d/
#### Use https://github.com/sirhomersimpson/oci/blob/master/hpc/configure_gpu48_rdma_nics.sh for the purpose
CX5=(enp72s0f0 enp72s0f1 enp76s0f0 enp76s0f1 enp12s0f0 enp12s0f1 enp22s0f0 enp22s0f1 enp195s0f0 enp195s0f1 enp209s0f0 enp209s0f1 enp138s0f0 enp138s0f1 enp148s0f0 enp148s0f1)

for interfaces in ${CX5[@]}; do
        echo interfaces $interfaces 
        ifup $interfaces
        #ifdow $interfaces
done


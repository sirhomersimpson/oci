#!/usr/bin/env bash

ITER=10
SLEEP_TIME_SECS=600
CN_OCID="ocid1.clusternetwork.oc1.uk-london-1.amaaaaaa4z4h5dia4ivgilv4powh7za7jrhasep3wmcomirznczr4f3fxzoq"

echo "================================================="
echo "Iterations: $ITER Sleep time(s): $SLEEP_TIME_SECS"
echo "================================================="

for i in $(seq $ITER)
do
   echo "Iteration: $i"
   echo "Set size to 0"
   resize_cn -cn $CN_OCID -s 0

   echo "Sleeping.."
   sleep $SLEEP_TIME_SECS

   echo "Set size to 1"
   resize_cn -cn $CN_OCID -s 1

   echo "Sleeping.."
   sleep $SLEEP_TIME_SECS

   echo "Set size to 2"
   resize_cn -cn $CN_OCID -s 2

   echo "Sleeping.."
   sleep $SLEEP_TIME_SECS
done
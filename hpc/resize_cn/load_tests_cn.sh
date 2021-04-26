#!/usr/bin/env bash

ITER=3
SLEEP_TIME_SECS=10 #3600
CN_OCID="ocid1.clusternetwork.oc1.uk-london-1.amaaaaaa4z4h5dia4ivgilv4powh7za7jrhasep3wmcomirznczr4f3fxzoq"

echo "================================================="
echo "Iterations: $ITER Sleep time(s): $SLEEP_TIME_SECS"
echo "================================================="

exit
for i in $(seq $ITER)
do
   echo "Iteration: $i"
   resize_cn -cn $CN_OCID -s 1
   sleep $SLEEP_TIME_SECS
   resize_cn -cn $CN_OCID -s 2
done
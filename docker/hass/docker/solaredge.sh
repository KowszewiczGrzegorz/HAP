#!/bin/bash

HOSTNAME="${COLLECTD_HOSTNAME:-`hostname -f`}"
INTERVAL=900

while sleep "$INTERVAL"
do
 output=$(curl -s -m 5 'https://monitoringapi.solaredge.com/site/id_removed/overview?api_key=api_removed' | tee -a /etc/collectd/logs/solaredge.log | jq -r -a '.overview.currentPower.power')
 echo "PUTVAL $HOSTNAME/energy/solar interval=$INTERVAL N:$output"
done

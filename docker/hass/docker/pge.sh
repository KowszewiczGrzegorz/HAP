#!/bin/bash

#collectd
#<Plugin exec>
#        Exec username_removed "pge.sh"
#</Plugin>
#
#<Plugin exec>
#        Exec username_removed "solaredge.sh"
#</Plugin>



if [ "$1" == "homeautomation" ];
then
  output=$(curl -s -m 5 'http://10.0.0.29/cgi-bin/cgi_manager' -H 'Authorization: Basic MDAyYWRhOjQxYWVmMDY5M2Q5ZmQ1ZmU=' --data $'<LocalCommand><Name>get_usage_data</Name><MacId>0xd8d5b90000005b0f</MacId></LocalCommand><LocalCommand>')
  solar=$(echo $output | jq -r -a '."demand"')
  echo "scale=1; $solar*1000 / 1 "| bc -l
 exit
fi

HOSTNAME="${COLLECTD_HOSTNAME:-`hostname -f`}"
INTERVAL="${COLLECTD_INTERVAL:-10}"

while sleep "$INTERVAL"
do
 output=$(curl -s -m 5 'http://10.0.0.29/cgi-bin/cgi_manager' -H 'Authorization: Basic MDAyYWRhOjQxYWVmMDY5M2Q5ZmQ1ZmU=' --data $'<LocalCommand><Name>get_usage_data</Name><MacId>0xd8d5b90000005b0f</MacId></LocalCommand><LocalCommand>' | tee -a /etc/collectd/logs/pge.log)
 solar=$(echo $output | jq -r -a '."demand"')
 over_produced=$(echo $output | jq -r -a '."summation_received"')
 from_grid=$(echo $output | jq -r -a '."summation_delivered"')
 echo "PUTVAL $HOSTNAME/energy/pge interval=$INTERVAL N:"$(echo "$solar * 1000" | bc -l)""
 echo "PUTVAL $HOSTNAME/energy/pge_over_produced interval=$INTERVAL N:"$(echo "$over_produced * 1000" | bc -l)""
 echo "PUTVAL $HOSTNAME/energy/pge_from_grid interval=$INTERVAL N:"$(echo "$from_grid * 1000" | bc -l)""
done

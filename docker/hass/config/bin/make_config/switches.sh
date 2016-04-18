#!/bin/bash

source ./_set_lights.sh

cat ../../../../mqtt-bridge/events.log | grep -i switch | grep -iv subscribi |\
 grep off | grep -i smartthings | grep -iv mqtt | cut -d' ' -f 8- | sed -e 's/\ =\ off//g' | grep -vE $lights |\
 sort | uniq | grep -Ev $blacklist | grep -e "^/" | while read i
do
 name=`echo $i | sed -e 's/\/switch//g' | awk -F "/" '{print $NF}'`
 czy=`cat ../../../../mqtt-bridge/events.log | grep -iv subscribi | grep "$name/" | grep level | wc -c`

 # czy ma level?
 echo '- platform: mqtt
  name: "'$name'"
  state_topic: "'$i'"
  command_topic: "'$i'"
  retain: true
  payload_on: "on"
  payload_off: "off"'

 if [ $czy -gt 1 ];
 then 
  zamien=`echo $i | sed -e 's/switch/level/g'`
  echo -e "  brightness_state_topic: \"${zamien}\""
  echo -e "  brightness_command_topic: \"${zamien}\""
 fi
#awk '{print $8" "$9}' | grep ^\/ | sort  | uniq 
# sed -e 's/=//g' | while read i
done

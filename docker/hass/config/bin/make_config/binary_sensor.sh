#!/bin/bash

cat ../../../../mqtt-bridge/events.log | grep -i contact | grep -iv subscribi |\
 grep closed | grep -i smartthings | grep -iv mqtt | cut -d' ' -f 8- | sed -e 's/\ =\ closed//g' |\
 sort | uniq | grep -e "^/" | while read i
do
 name=`echo $i | sed -e 's/\/contact//g' | awk -F "/" '{print $NF}'`

 echo '- platform: mqtt
  name: "contact - '$name'"
  state_topic: "'$i'"
  command_topic: "'$i'"
  retain: true
  payload_on: "open"
  payload_off: "closed"'
done


cat ../../../../mqtt-bridge/events.log | grep -i motion | grep -iv subscribi |\
 grep inactive | grep -i smartthings | grep -iv mqtt | cut -d' ' -f 8- | sed -e 's/\ =\ inactive//g' |\
 sort | uniq | grep -e "^/" | while read i
do
 name=`echo $i | sed -e 's/\/motion//g' | awk -F "/" '{print $NF}'`
 echo '- platform: mqtt
  name: "motion - '$name'"
  state_topic: "'$i'"
  command_topic: "'$i'"
  retain: true
  payload_on: "active"
  payload_off: "inactive"'
done

for urzadzenie in lock presence button acceleration
do
 cat ../../../../mqtt-bridge/events.log | grep -i $urzadzenie | grep -iv subscribi |\
  grep $urzadzenie | grep -i smartthings | grep -iv mqtt | cut -d' ' -f 8- | awk -F"=" '{print $1}' |\
  grep -e "^/" | grep -v switch | sort | uniq | while read i
 do
  name=`echo $i | sed -e 's/\/$urzadzenie//g' | awk -F "/" '{print $3}'`
  echo '- platform: mqtt
  name: '${urzadzenie}' - '$name'
  state_topic: "'$i'"'
 done
done
exit


exit

  - platform: mqtt
    state_topic: "/smartthings/Gate/contact"
    name: "Gate"
    payload_on: "open"
    payload_off: "closed"
  - platform: mqtt
    name: "Porch"
    state_topic: "/smartthings/Porch/motion"
    command_topic: "/smartthings/Porch/motion"
    payload_on: "active"
    payload_off: "inactive"

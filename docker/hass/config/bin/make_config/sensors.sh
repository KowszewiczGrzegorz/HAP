#!/bin/bash

echo "- platform: forecast
  api_key: 877dcfafcd01cd586970554b62ef594d
  scan_interval: 600
  minute: 30
  monitored_conditions:
    - summary
    - icon
    - nearest_storm_distance
    - nearest_storm_bearing
    - precip_type
    - precip_intensity
    - precip_probability
    - temperature
    - apparent_temperature
    - dew_point
    - wind_speed
    - wind_bearing
    - cloud_cover
    - humidity
    - pressure
    - visibility
    - ozone
- platform: speedtest
  minute: 30
  hour:
    - 0
    - 6
    - 12
    - 18
  monitored_conditions:
    - ping
    - download
    - upload
- platform: command_line
  command: /tmp/pge.sh homeautomation
  name: PGE Energy
  unit_of_measurement: 'W'
- platform: time_date
  display_options:
      - 'time'
      - 'date'
- platform: worldclock
  time_zone: Europe/Warsaw
  name: 'Warszawa'
"

for urzadzenie in power energy battery level
do
 cat ../../../../mqtt-bridge/events.log | grep -i $urzadzenie | grep -iv subscribi |\
  grep $urzadzenie | grep -i smartthings | grep -iv mqtt | cut -d' ' -f 8- | awk -F"=" '{print $1}' |\
  grep -e "^/" | sort | uniq | while read i
 do
  name=`echo $i | sed -e 's/\/$urzadzenie//g' | awk -F "/" '{print $3}'`
  echo '- platform: mqtt
  name: '${urzadzenie}' - '$name'
  state_topic: "'$i'"'
  if [ $urzadzenie == "power" ]; then
   echo '  unit_of_measurement: "W"'
  fi

  if [ $urzadzenie == "energy" ]; then
   echo '  unit_of_measurement: "kW"'
  fi

  if [ $urzadzenie == "battery" ]; then
   echo '  unit_of_measurement: "%"'
  fi

  if [ $urzadzenie == "level" ]; then
   echo '  unit_of_measurement: "%"'
  fi

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

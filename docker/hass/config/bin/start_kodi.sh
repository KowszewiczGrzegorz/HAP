#!/bin/bash
adb kill-server 2> /dev/null
sleep 7
adb connect 10.0.0.20 2> /dev/null
adb shell am start -n org.xbmc.kodi/.Splash
sleep 1
adb kill-server 2> /dev/null
# stop it 
#adb shell am force-stop org.xbmc.kodi


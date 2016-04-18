#!/bin/bash

date=$(date +"%Y-%m-%d_%H-%M-%S")
DIR="/root/.homeassistant/bin/"
filename=$(echo ${date}_3.jpg)
OUTPUTFILENAME=$DIR"output/"$filename

wget -q http://user:password_removed@10.0.0.28/ISAPI/Streaming/channels/600/picture -O $OUTPUTFILENAME
echo "Gate state changed" | $DIR/pushbullet push all file $OUTPUTFILENAME

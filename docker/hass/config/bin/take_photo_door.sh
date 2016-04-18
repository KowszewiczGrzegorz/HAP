#!/bin/bash

date=$(date +"%Y-%m-%d_%H-%M-%S")
DIR="/root/.homeassistant/bin/"
filename=$(echo ${date}_3.jpg)
OUTPUTFILENAME=$DIR"output/door/"$filename

wget -q http://user:pass_removed@10.0.0.28/ISAPI/Streaming/channels/100/picture -O $OUTPUTFILENAME
echo "Someone is at the porch" | $DIR/pushbullet push all file $OUTPUTFILENAME

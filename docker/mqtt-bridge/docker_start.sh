docker kill mqtt-bridge
docker rm mqtt-bridge
docker run \
    -d \
    --net=host \
    --name="mqtt-bridge" \
    -v /opt/automatyzacja/mqtt-bridge:/config \
    -p 8080:8080 \
    moj_mqtt_bridge

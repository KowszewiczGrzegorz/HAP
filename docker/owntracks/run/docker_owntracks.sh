docker run -v /opt/automatyzacja/owntracks:/owntracks -p 11883:1883 -p 18883:8883 -p 8083:8083 \
    -d \
    --name owntracks \
    --hostname d.greko.eu \
    -e MQTTHOSTNAME="hostname_removed" \
    -e IPLIST="ip_removed" \
    -e HOSTLIST="hostlist_removed" \
    owntracks/recorderd

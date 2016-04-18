docker run -v `pwd`/data:/data \
           --name graphite \
           -e SECRET_KEY='secret_key' \
           -p 14000:80 \
           -p 14001:3000 \
           -p 2003:2003 \
           -p 2004:2004 \
           -p 7002:7002 \
           -p 8125:8125/udp \
           -p 8126:8126 \
           -d greko6/graphite:latest

exit

Generate your random key:
https://docs.djangoproject.com/en/dev/ref/settings/#secret-key


80: the graphite web interface
3000: the grafana web interface
2003: the carbon-cache line receiver (the standard graphite protocol)
2004: the carbon-cache pickle receiver
7002: the carbon-cache query port (used by the web interface)
8125: the statsd UDP port
8126: the statsd management port

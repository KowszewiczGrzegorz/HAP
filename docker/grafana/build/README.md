## Graphite + Carbon + Statsd + Grafana

An all-in-one image running graphite and carbon-cache. Yay!

This image contains a sensible default configuration of graphite,
carbon-cache and grafana. Starting this container will expose following ports:

- `80`: the graphite web interface
- `3000`: the grafana web interface
- `2003`: the carbon-cache line receiver (the standard graphite protocol)
- `2004`: the carbon-cache pickle receiver
- `7002`: the carbon-cache query port (used by the web interface)
- `8125`: the statsd UDP port
- `8126`: the statsd management port

You can log into the administrative interface of graphite-web (a Django
application) with the username `admin` and password `admin`. These passwords can
be changed through the web interface.

**NB**: Please be aware that by default docker will make the exposed ports
accessible from anywhere if the host firewall is unconfigured.

### Data volumes

All data is stored in the /data folder in the container (graphite metrics and grafana db)

### Technical details

By default, this instance of carbon-cache uses the following retention periods
resulting in whisper files (wsp) of approximately 0.5MB. Not bad for intense datasets.

10s:1d, 1m:7d, 5m:31d, 30m:1y, 24h:5y

### Getting started

Generate your SECRET_KEY from [here](http://www.miniwebtool.com/django-secret-key-generator/). It is optional but highly recommended.

### Based off

https://github.com/nickstenning/dockerfiles.git

Extended by Sam Saffron
Modified by Grzegorz Kowszewicz

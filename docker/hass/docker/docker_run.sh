docker kill hass
docker rm hass
docker run -p 10.0.0.11:8123:8123 \
  --name="hass" \
  --net="host" \
  -v `pwd`/../config:/root/.homeassistant \
  -d=true -t -i hass_python $1

#  --dns 10.0.0.1 \

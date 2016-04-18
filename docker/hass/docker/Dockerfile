FROM python
RUN cat /etc/passwd
RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y jq bc python-netifaces nmap
RUN python3 -m pip install homeassistant
RUN apt-get install -y --force-yes net-tools ffmpeg
RUN apt-get install -y php5-cli
RUN apt-get install -y wget android-tools-adb
RUN apt-get -y autoremove
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ADD pge.sh /tmp/
CMD ["hass"]

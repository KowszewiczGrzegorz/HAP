git config --global user.email "root@blah"
git config --global user.name "root@blah"
git add ./scripts/*
git add ./automation/*
git diff
git commit -a -m 'ok'
docker restart hass
tail -f home-assistant.log

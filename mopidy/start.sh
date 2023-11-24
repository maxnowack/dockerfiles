#!/bin/bash

# Copy config if it does not already exist
if [ ! -f /root/.config/mopidy/mopidy.conf ]; then
  mkdir -p /root/.config/mopidy
  cp /root/.config/mopidy_default.conf /root/.config/mopidy/mopidy.conf
fi

# Replace env var values in config
if [ -n "$SPOTIFY_USER" ]; then
  sed -i -e 's/{{SPOTIFY_USER}}/'"$SPOTIFY_USER"'/g' /root/.config/mopidy/mopidy.conf
  sed -i -e 's/{{SPOTIFY_PASS}}/'"$SPOTIFY_PASS"'/g' /root/.config/mopidy/mopidy.conf
  sed -i -e 's/{{SPOTIFY_CLIENTID}}/'"$SPOTIFY_CLIENTID"'/g' /root/.config/mopidy/mopidy.conf
  sed -i -e 's/{{SPOTIFY_CLIENTSECRET}}/'"$SPOTIFY_CLIENTSECRET"'/g' /root/.config/mopidy/mopidy.conf
fi

if [ -n "$SOUNDCLOUD_TOKEN" ]; then
  sed -i -e 's/{{SOUNDCLOUD_TOKEN}}/'"$SOUNDCLOUD_TOKEN"'/g' /root/.config/mopidy/mopidy.conf
fi

sed -i -e 's/{{ICECAST_MOUNT}}/'"$ICECAST_MOUNT"'/g' /root/.config/mopidy/mopidy.conf
sed -i -e 's/{{ICECAST_HOST}}/'"$ICECAST_HOST"'/g' /root/.config/mopidy/mopidy.conf
sed -i -e 's/{{ICECAST_PORT}}/'"$ICECAST_PORT"'/g' /root/.config/mopidy/mopidy.conf
sed -i -e 's/{{ICECAST_PASS}}/'"$ICECAST_PASS"'/g' /root/.config/mopidy/mopidy.conf

mopidy

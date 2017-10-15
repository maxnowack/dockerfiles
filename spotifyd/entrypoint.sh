#!/bin/bash

if [[ -z $USERNAME && -z $PASSWORD && -z $DEVICE_NAME ]]
then
   echo You must provide env vars USERNAME, PASSWORD and DEVICE_NAME
   exit 0
fi

# Launch spotifyd in background
spotifyd -u $USERNAME -p $PASSWORD --device_name $DEVICE_NAME --no-daemon

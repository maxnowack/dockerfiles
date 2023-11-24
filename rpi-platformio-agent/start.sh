#!/bin/sh

if [ -z "$PLATFORMIO_AUTH_TOKEN" ]; then
  echo "PLATFORMIO_AUTH_TOKEN is not set"
  exit 1
fi

echo "###########################################\n# Upgraded platformio. Starting agent ... #\n###########################################\n"
pio remote agent start -n "$NAME"

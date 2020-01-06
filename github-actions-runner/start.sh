#!/bin/sh

set -e

cleanup() {
  echo "Container stopped, performing cleanup..."
  /runner/config.sh remove --token $RUNNER_TOKEN
}

trap 'cleanup' INT TERM

echo "Configuring runner …"
printf "$RUNNER_NAME\n$RUNNER_WORK_FOLDER\n" | /runner/config.sh --url $RUNNER_URL --token $RUNNER_TOKEN > /dev/null
/runner/run.sh

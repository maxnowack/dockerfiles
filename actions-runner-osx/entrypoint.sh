#!/bin/bash

# Create the runner and start the configuration experience
./config.sh --url "https://github.com/$GITHUB_ORG" --token $GITHUB_TOKEN
./run.sh

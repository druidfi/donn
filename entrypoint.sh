#!/bin/bash

set -e

if [ $1 == "gulp" ]; then

  printf "\n\n✨ Running Gulp:\n\n"
  exec "$@"

else

  echo "# Exec CMD: $@"
  exec "$@"

fi

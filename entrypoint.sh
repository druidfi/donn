#!/bin/bash

set -e

if [ $1 == "gulp" ]; then

  exec "$@"

else

  echo "Error: you cannot call '$@' on this image. You can call 'gulp' instead."
  exit 1

fi

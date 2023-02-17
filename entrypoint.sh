#!/bin/bash

set -e

echo "Update caniuse-lite..."
npx -yq update-browserslist-db@latest

if [ $1 == "gulp" ]; then

  cd ${GULP_PATH}
  exec "$@"

else

  echo "Error: you cannot call '$@' on this image. You can call 'gulp' instead."
  exit 1

fi

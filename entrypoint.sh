#!/bin/bash

set -e

echo -e "[DONN] Update caniuse-lite...\n"
npx -yq update-browserslist-db@latest

if [ -f "$DATA_PATH/package.json" ]; then

    if [ -f "$DATA_PATH/yarn.lock" ]; then

        echo -e "\n[DONN] yarn.lock exists, running yarn install...\n"
        yarn --cwd "${DATA_PATH}" install --frozen-lockfile

    else

        echo -e "\n[DONN] Running npm install...\n"
        npm --prefix "${DATA_PATH}" --no-audit --no-fund --engine-strict true install
    fi

fi

if [ "$1" == "gulp" ]; then

  echo -e "\n[DONN] Running Gulp...\n"
  cd "${GULP_PATH}"
  exec "$@"

elif [ "$1" == "webpack" ]; then

  echo -e "\n[DONN] Running Webpack...\n"
  cd "${WEBPACK_PATH}"
  shift;
  exec webpack-cli "$@"

else

  echo "Error: you cannot call '$@' on this image. You can call 'gulp' or 'webpack' instead."
  exit 1

fi

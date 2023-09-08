ARG NODE_VERSION

FROM node:${NODE_VERSION}-alpine

ENV DATA_PATH=/data \
    DIST_FOLDER=dist \
    GULP_PATH=/opt/gulp \
    BROWSERSLIST="last 2 version, not dead" \
    SRC_FOLDER=src \
    WEBPACK_PATH=/opt/webpack

COPY entrypoint.sh /usr/local/bin/entrypoint

COPY gulp/ ${GULP_PATH}
COPY webpack/ ${WEBPACK_PATH}

WORKDIR ${GULP_PATH}

RUN apk --no-cache add bash tini && \
    mkdir -p ${DATA_PATH} ${GULP_PATH} ${WEBPACK_PATH} && \
    npm config set update-notifier false && \
    npm install --location=global gulp-cli webpack-cli && gulp --version && webpack-cli --version && \
    (cd ${GULP_PATH} && npm ci) && \
    (cd ${WEBPACK_PATH} && npm ci)

ENTRYPOINT ["/sbin/tini", "--", "entrypoint"]

CMD ["tail", "-f", "/dev/null"]

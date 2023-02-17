ARG NODE_VERSION

FROM node:${NODE_VERSION}-alpine

LABEL org.opencontainers.image.authors="Druid".fi maintainer="Druid.fi"
LABEL org.opencontainers.image.source="https://github.com/druidfi/donn" repository="https://github.com/druidfi/donn"

ENV DATA_PATH=/data \
    DIST_FOLDER=dist \
    GULP_PATH=/opt/gulp \
    BROWSERSLIST="last 2 version, not dead" \
    SRC_FOLDER=src

COPY entrypoint.sh /usr/local/bin/entrypoint

COPY gulp/ ${GULP_PATH}

WORKDIR ${GULP_PATH}

RUN apk --no-cache add bash tini && \
    npm config set update-notifier false && \
    (cd ${GULP_PATH} && npm ci && npm install --location=global gulp-cli && gulp --version) && \
    npx -yq update-browserslist-db@latest

ENTRYPOINT ["/sbin/tini", "--", "entrypoint"]

CMD ["tail", "-f", "/dev/null"]

ARG NODE_VERSION

FROM node:${NODE_VERSION}-alpine

LABEL org.opencontainers.image.authors="Druid".fi maintainer="Druid.fi"
LABEL org.opencontainers.image.source="https://github.com/druidfi/donn" repository="https://github.com/druidfi/donn"

ENV GULP_PATH=/opt/gulp

COPY entrypoint.sh /usr/local/bin/entrypoint

COPY gulp/ ${GULP_PATH}

WORKDIR ${GULP_PATH}

RUN apk --no-cache add bash tini

RUN npm config set update-notifier false && \
    (cd ${GULP_PATH} && npm install && npm install --location=global gulp-cli && gulp --version)

#RUN which gulp && exit 1

ENTRYPOINT ["/sbin/tini", "--", "entrypoint"]

CMD ["tail", "-f", "/dev/null"]
FROM alpine:latest

MAINTAINER Rui Marinho <rui@uphold.com> (@ruimarinho)

ENV PGBADGER_DATA=/data
ENV PGBADGER_VERSION=9.2
ENV PGBADGER_PREFIX=/opt/pgbadger-${PGBADGER_VERSION}
ENV PATH=${PGBADGER_PREFIX}:$PATH

RUN apk --no-cache add coreutils \
    openssl \
    perl \
  && mkdir -p /data /opt \
  && wget -O - https://github.com/dalibo/pgbadger/archive/v${PGBADGER_VERSION}.tar.gz | tar -zxvf - -C /opt \
	&& chmod a+x $PGBADGER_PREFIX/pgbadger

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME $PGBADGER_DATA

ENTRYPOINT ["/entrypoint.sh"]

CMD ["pgbadger"]

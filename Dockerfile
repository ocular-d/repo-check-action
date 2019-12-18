FROM alpine:3.10

LABEL version="0.1"
LABEL maintainer="ocular-d <sven@ocular-d.tech>" \
      org.label-schema.vendor="ocular-d" \
      com.github.actions.name="Repo Check Action" \
      com.github.actions.description="This action syncs checks for certain files" \
      com.github.actions.icon="truck" \
      com.github.actions.color="blue"


# hadolint ignore=DL3018,DL3013
RUN adduser -s /bin/false -D -H ocl \
    && apk --no-cache add \
    tini \
    su-exec \
    bash \
    ncurses

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /srv

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
#ENTRYPOINT ["bash"]

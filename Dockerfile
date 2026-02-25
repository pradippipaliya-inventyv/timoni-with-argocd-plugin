FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

ARG TIMONI_VERSION=0.25.2

RUN apk update && apk add --no-cache \
    bash \
    curl

RUN curl -Lo /tmp/timoni.tar.gz "https://github.com/stefanprodan/timoni/releases/download/v${TIMONI_VERSION}/timoni_${TIMONI_VERSION}_linux_amd64.tar.gz" && \
    tar -xzf /tmp/timoni.tar.gz -C /usr/local/bin && \
    rm /tmp/timoni.tar.gz

RUN delgroup ping && \
    addgroup -g 998 ping && \
    adduser -D -u 999 argocd
USER argocd

RUN mkdir -p /home/argocd/cmp-server/config

COPY plugin.yml /home/argocd/cmp-server/config/plugin.yaml

ENTRYPOINT [ "/var/run/argocd/argocd-cmp-server" ]
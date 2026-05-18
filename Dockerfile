FROM alpine:latest

RUN apk add openssh-client
COPY --chmod=755 ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


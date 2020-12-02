FROM alpine

RUN apk add --no-cache tini openssh-client ca-certificates bash

COPY sh/* /usr/local/bin/

ENTRYPOINT [ "tini", "-v", "--", "entrypoint.sh" ]
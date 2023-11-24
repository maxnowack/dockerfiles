FROM alpine

RUN apk --no-cache add lsyncd sshpass openssh-client

ENTRYPOINT ["lsyncd", "-nodaemon", "-delay", "0"]

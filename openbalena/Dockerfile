FROM ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl build-essential git docker.io libssl-dev nodejs npm
RUN useradd -ms /bin/bash balena
RUN usermod -aG sudo balena
RUN usermod -aG docker balena
RUN curl -L https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN git clone https://github.com/balena-io/open-balena.git ~/open-balena

RUN ~/open-balena/scripts/quickstart

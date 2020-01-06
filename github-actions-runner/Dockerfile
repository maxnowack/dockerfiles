FROM ubuntu

WORKDIR /runner

RUN apt-get update \
  && apt-get install -y \
    ca-certificates \
    bsdtar \
    curl \
    git \
  && curl -O https://githubassets.azureedge.net/runners/2.161.0/actions-runner-linux-x64-2.161.0.tar.gz \
  && tar xzf actions-runner-linux-x64-2.161.0.tar.gz \
  && rm -rf actions-runner-linux-x64-2.161.0.tar.gz \
  && ./bin/installdependencies.sh \
  && ln -sf $(which bsdtar) $(which tar) \
  && useradd -ms /bin/bash runner \
  && chown -R runner /runner
USER runner

COPY start.sh start.sh

ENTRYPOINT [ "/runner/start.sh" ]

FROM sickcodes/docker-osx

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN /home/linuxbrew/.linuxbrew/bin/brew install dotnet

ARG ARCHITECTURE=x64
ARG RUNNERVERSION=2.305.0

WORKDIR /actions-runner
RUN curl -o "actions-runner-osx-$ARCHITECTURE-$RUNNERVERSION.tar.gz" -L "https://github.com/actions/runner/releases/download/v$RUNNERVERSION/actions-runner-osx-$ARCHITECTURE-$RUNNERVERSION.tar.gz"
RUN tar xzf "./actions-runner-osx-$ARCHITECTURE-$RUNNERVERSION.tar.gz"
RUN ls -al
COPY entrypoint.sh /actions-runner/entrypoint.sh

ENTRYPOINT ["/actions-runner/entrypoint.sh"]

FROM python:3

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y libssl-dev python3-dev libffi-dev \
    build-essential \
    curl \
  && curl https://sh.rustup.rs -sSf | bash -s -- -y \
  && echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
ENV PATH="/root/.cargo/bin:${PATH}"
RUN pip install -U cryptography platformio \
  && pip install --upgrade pip \
  && pio remote agent

COPY start.sh /start.sh
CMD ["/start.sh"]

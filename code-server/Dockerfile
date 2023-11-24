FROM codercom/code-server:latest

# ZSH
RUN sudo apt-get update \
  && sudo apt-get install -y zsh \
  && sudo chsh -s /bin/zsh coder \
  && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

USER root

# KUBECTL
RUN apt-get update && apt-get install -y gnupg apt-transport-https \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
  && apt-get update \
  && apt-get install -y kubectl

# TELEPRESENCE
RUN curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | bash \
  && apt install -y --no-install-recommends telepresence

# ZEROTIER
ENV ZEROTIER_VERSION=1.4.6
RUN set -eux; \
    apt-get install -y unzip wget build-essential; \
    wget https://github.com/zerotier/ZeroTierOne/archive/$ZEROTIER_VERSION.zip -O /zerotier.zip; \
    unzip /zerotier.zip -d /; \
    cd /ZeroTierOne-$ZEROTIER_VERSION; \
    make; \
    DESTDIR=/tmp/build make install; \
    mv /tmp/build/usr/sbin/* /usr/sbin/; \
    mkdir /var/lib/zerotier-one; \
    rm -rf /tmp/build; \
    rm -rf /ZeroTierOne-$ZEROTIER_VERSION; \
    rm -rf /zerotier.zip; \
    zerotier-one -v

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx \
  && ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx \
  && ln -s /opt/kubectx/kubens /usr/local/bin/kubens \
  && mkdir -p /home/coder/.oh-my-zsh/completions \
  && ln -s /opt/kubectx/completion/kubectx.zsh /home/coder/.oh-my-zsh/completions/_kubectx.zsh \
  && ln -s /opt/kubectx/completion/kubens.zsh /home/coder/.oh-my-zsh/completions/_kubens.zsh

USER coder

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

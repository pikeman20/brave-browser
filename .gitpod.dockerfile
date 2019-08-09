FROM gitpod/workspace-full:latest

USER root
RUN apt-get update && apt-get install -y \
  bison \
  build-essential \
  curl \
  g++-multilib \
  gcc-multilib \
  git \
  gperf \
  libgnome-keyring-dev \
  libnotify-dev \
  libssl-dev \
  lsb-release \
  ninja-build \
  python-pip \
  python-setuptools

RUN npm install -g node-gyp@3.3.1
RUN pip install Jinja2==2.8.1

COPY ./install-build-deps.sh .
RUN chmod +x /install-build-deps.sh
RUN ./install-build-deps.sh --unsupported
# BLB source code. Mount ./browser-laptop-bootstrap from the host to here.
WORKDIR /src
VOLUME /src
# Build cache. Mount ./sccache from the host to here.
VOLUME /root/.cache/sccache

CMD bash
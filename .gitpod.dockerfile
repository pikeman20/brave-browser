FROM node:8-stretch

USER root
RUN apt-get update && apt-get install -y  sudo
RUN sudo apt-get update -y
RUN sudo apt-get upgrade -y

RUN npm install -g node-gyp@3.3.1
RUN pip install Jinja2==2.8.1

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install sccache
RUN echo "sccache = /root/.cargo/bin/sccache" > /root/.npmrc
COPY ./install-build-deps.sh /
RUN chmod +x /install-build-deps.sh
RUN ./install-build-deps.sh
# BLB source code. Mount ./browser-laptop-bootstrap from the host to here.
WORKDIR /src
VOLUME /src
# Build cache. Mount ./sccache from the host to here.
VOLUME /root/.cache/sccache

CMD bash
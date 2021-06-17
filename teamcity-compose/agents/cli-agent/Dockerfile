ARG UBUNTU_VERSION=20.04
ARG TEAMCITY_VERSION=2020.2.3
FROM jetbrains/teamcity-agent:${TEAMCITY_VERSION} as cli-agent
USER root
ARG IOHK_LIBSODIUM_GIT_REV=66f017f16633f2060db25e17c170c2afa0f2a8a1
RUN mkdir -p /app/src
RUN apt-get update -y && apt-get install -y \
qrencode \
zip \
unzip \
git \
jq  \
bc \
make \
automake \
rsync \
htop \
curl \
build-essential \
pkg-config \
libffi-dev \
libgmp-dev \
libssl-dev \
libtinfo-dev \
libsystemd-dev \
zlib1g-dev \
make \
g++ \
wget \
libncursesw5 \
libtool \
autoconf \
lsof
WORKDIR /app/src
RUN git clone https://github.com/input-output-hk/libsodium.git &&\
  cd libsodium &&\
  git fetch --all --tags &&\
  git checkout ${IOHK_LIBSODIUM_GIT_REV}
WORKDIR /app/src/libsodium
RUN ./autogen.sh && ./configure && make && make install
ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
ENV PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
WORKDIR /opt/buildagent/work

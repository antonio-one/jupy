FROM ubuntu:18.04

# -e Exit immediately if a command exits with a non-zero status.
# -u Treat unset variables as an error when substituting.
# -x Print commands and their arguments as they are executed.

RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y apt-utils \
        build-essential \
        libreadline-gplv2-dev \
        libncursesw5-dev \
        libssl-dev \
        libsqlite3-dev \
        tk-dev \
        libgdbm-dev \
        libc6-dev \
        libbz2-dev \
        libffi-dev \
        zlib1g-dev \
        wget \
        pgp

# install java
RUN apt-get install -y openjdk-8-jdk
RUN update-alternatives --list java
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

## install python
ARG PYTHON_VERSION=3.8.2
RUN cd /opt && \
    wget -c https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -O - | tar xvz && \
    cd /opt/Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make install
RUN ["bash", "-c", "cd /usr/local/bin/ && ln -s python${PYTHON_VERSION:0:3} python"]
RUN ["bash", "-c", "cd /usr/local/bin/ && ln -s pip${PYTHON_VERSION:0:3} pip"]

LABEL description="Ubuntu 18.04 with preinstalled Java 8 and Python 3.8.2"
LABEL maintainer="antonio.one@protonmail.com"

#CMD ["tail", "-f", "/dev/null"]
# https://www.learnopencv.com/install-opencv3-on-ubuntu/

FROM ubuntu:22.04

ARG PYTHON_VERSION=3.9

LABEL maintainer="jborovec+github@gmail.com"

SHELL ["/bin/bash", "-c"]

# for installing tzdata see: https://stackoverflow.com/a/58264927/4521646
ENV DEBIAN_FRONTEND=noninteractive

RUN
    apt-get update -qq --fix-missing && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        dirmngr \
        gnupg && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-add-repository universe && \
    apt-get -y update -qq --fix-missing && \
    apt-get -y install --no-install-recommends \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-distutils \
        python${PYTHON_VERSION}-dev \
        curl \
    && \

# Set the default python and install PIP packages
    update-alternatives --install /usr/bin/python${PYTHON_VERSION%%.*} python${PYTHON_VERSION%%.*} /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1 && \

# Install python dependencies
    curl "https://bootstrap.pypa.io/get-pip.py" | python && \

# Cleaning
    apt-get autoremove -y && \
    apt-get clean

RUN \
    # Show what we have
    python --version && \
    pip --version && \
    pip list && \
    python -c "import sys; ver = sys.version.split(' ')[0] ; assert ver.split('.')[:2] == '$PYTHON_VERSION'.split('.')[:2], sys.version"

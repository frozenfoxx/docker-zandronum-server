# Base image
FROM ubuntu:20.04

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Variables
ENV HOME=/root \
      APP_DEPS="wget" \
      APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
      BUILD_DEPS="gnupg software-properties-common" \
      DEBIAN_FRONTEND=noninteractive \
      DOOMWADDIR='/wads' \
      FILES='' \
      LANG=en_US.UTF-8 \
      LANGUAGE=en_US.UTF-8 \
      LC_ALL=C.UTF-8

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ${APP_DEPS} ${BUILD_DEPS}

# Set up Zandronum
RUN mkdir -p /root/.config/zandronum
COPY config/zandronum.ini /root/.config/zandronum/
COPY scripts/* /tmp/
RUN /tmp/install_zandronum.sh

# Set up entrypoint
COPY bin/entrypoint.sh /usr/local/bin/entrypoint.sh

# Clean up unnecessary packages
RUN apt-get remove -y ${BUILD_DEPS} && \
  apt-get autoremove --purge -y && \
  rm -rf /var/lib/apt/lists/*
  
# Expose ports
EXPOSE 10666

# Launch process
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

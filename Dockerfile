# Base image
FROM ubuntu:22.04

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Variables
ENV HOME=/root \
  APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
  BUILD_DEPS="gnupg software-properties-common wget" \
  CONFIG="" \
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

# Set up Zandronum Server
RUN mkdir -p /root/.config/zandronum && \
  mkdir -p ${DOOMWADDIR}
COPY config/zandronum.ini /root/.config/zandronum/
COPY scripts/* /usr/local/bin/
COPY wads/* ${DOOMWADDIR}/
RUN /usr/local/bin/install_zandronum_server.sh

# Add the zandronum user
RUN useradd -ms /bin/bash zandronum

# Clean up unnecessary packages
RUN apt-get remove -y ${BUILD_DEPS} && \
  apt-get autoremove --purge -y && \
  rm -rf /var/lib/apt/lists/*
  
# Expose ports
EXPOSE 10666

# Launch process
USER zandronum
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

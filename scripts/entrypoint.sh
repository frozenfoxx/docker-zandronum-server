#!/usr/bin/env bash

# Variables
CONFIG=${CONFIG:-''}
HOME=$(eval echo ~$(whoami))

# Functions

## Build config files
build_configs()
{
  # Create local Zandornum config directory
  mkdir -p ${HOME}/.config/zandronum

  envsubst < /usr/local/etc/zandronum.ini.tmpl > ${HOME}/.config/zandronum/zandronum.ini
}

## Decode CONFIG if specified
decode_config()
{
  # If a user supplied a CONFIG, set it up
  if [[ -n ${CONFIG} ]]; then
    $(echo ${CONFIG} | base64 -d) > /tmp/config.ini
    CONFIG="-config /tmp/config.ini"
  fi
}

# Logic

build_configs
decode_config
zandronum-server ${CONFIG} $@

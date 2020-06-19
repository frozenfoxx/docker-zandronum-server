#!/usr/bin/env bash

# Variables
CONFIG=${CONFIG:-''}

# Functions

## Decode CONFIG if specified
decode_config()
{
  $(echo ${CONFIG} | base64 -d) > /tmp/config.ini
  CONFIG="-config /tmp/config.ini"
}

# Logic

if [[ -n ${CONFIG} ]]; then
  decode_config
fi

## Execute Zandronum server
zandronum-server ${CONFIG} $@

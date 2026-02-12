#!/usr/bin/env bash
set -eu

exec zandronum-server -host "$@"

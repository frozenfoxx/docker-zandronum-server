#!/usr/bin/env bash

# Install Zandronum

# Variables

DISTRO=${DISTRO:-'ubuntu'}
REPO_KEY=${REPO_KEY:-'drdteam.gpg'}
REPO_URL=${REPO_URL:-'http://debian.drdteam.org'}

# Functions

## Add the repository
add_repo()
{
  case "${DISTRO}" in
    debian ) add_repo_debian
             ;;
    ubuntu ) add_repo_debian
             ;;
    * )      echo "This distro is unsupported at this time"
             exit 1
             ;;
  esac
}

## Add a Debian repository
add_repo_debian()
{
  wget -O - ${REPO_URL}/${REPO_KEY} | apt-key add -
  apt-add-repository "deb ${REPO_URL}/ stable multiverse"
}

## Install Zandronum
install_zandronum()
{
  case "${DISTRO}" in
    debian ) install_zandronum_debian
             ;;
    ubuntu ) install_zandronum_debian
             ;;
    * )      echo "This distro is unsupported at this time"
             exit 1
             ;;
  esac
}

## Install Zandronum on Debian-based systems
install_zandronum_debian()
{
  apt update
  apt install -y zandronum
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] install_zandronum.sh [options]"
  echo "  Environment Variables:"
  echo "    DISTRO                distribution to install to (default: 'ubuntu')"
  echo "    REPO_KEY              repository keyfile (default: 'drdteam.gpg')"
  echo "    REPO_URL              repository URL (default: 'http://debian.drdteam.org')"
}

# Logic

## Argument parsing
while [[ "$1" != "" ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
                  ;;
    * )           usage
                  exit 1
                  ;;
  esac
  shift
done

add_repo
install_zandronum


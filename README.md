# docker-zandronum-server

[![Actions Status](https://github.com/frozenfoxx/docker-zandronum-server/workflows/build/badge.svg)](https://github.com/frozenfoxx/docker-zandronum-server/actions)

A [Docker](https://www.docker.com/) container for running a [Zandronum](https://zandronum.com/) server.

Docker Hub: [https://hub.docker.com/r/frozenfoxx/zandronum-server/](https://hub.docker.com/r/frozenfoxx/zandronum-server/)

# How to Build

To build the default image input the following:

```
git clone https://github.com/frozenfoxx/docker-zandronum-server.git
cd docker-zandronum-server
docker build -t frozenfoxx/zandronum-server:latest .
```

If you wish to build WAD files into the container or simply wish to have defaults, include them in the `wads` directory prior to building.

# How to Use this Image

## Quickstart

The following will run the latest Zandronum server with a default configuration.

```
docker run -it \
  --rm \
  -p 10666:10666 \
  -v /Path/To/WADs/:/wads:ro \
  --name=zandronum-server \
  frozenfoxx/zandronum-server:latest
```

## Adding Options

The entrypoint will pass all additional options to the Zandronum server script. To mount an additional WAD file, host a private game, and set developer mode for instance:

```
docker run -it \
  --rm \
  -p 10666:10666 \
  -v /Path/To/WADs/:/wads:ro \
  -v /Path/To/Other/WADs/:/other_wads:ro \
  --name=zandronum-server \
  frozenfoxx/zandronum-server:latest \
  -private \
  +developer 1 \
  /other_wads/savage.wad
```

A full list of options and how to enable them is provided on the [ZDoom Wiki](https://zdoom.org/wiki/Command_line_parameters).

## Multiplay

A [Multiplay](https://unity.com/products/multiplay) compatible version of this container is also available. For deployment to Multiplay, you will need to follow their Container [guildelines](https://docs.unity.com/multiplay/concepts/container-builds.html).

* Copy your WAD files into `wads`.
* Build the container (`docker build -t localhost/zandronum-server:multiplay -f Dockerfile.multiplay .`).
* Authenticate, tag, and push to Multiplay in alignment with their [documentation](https://docs.unity.com/multiplay/guides/get-started.html#Upload2).

# Configuration

## Environment Variables

* **CONFIG**:  contents of a game configuration INI file for Zandronum, encoded in `base64`. If specified it will be loaded when starting the server.

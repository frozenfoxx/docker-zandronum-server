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
  frozenfoxx/zandronum-server:latest \
  -iwad /wads/DOOM2.WAD
```

## Adding Options

All arguments passed to the container are forwarded directly to `zandronum-server -host`. You can pass any combination of Zandronum command-line parameters and console variables:

```
docker run -it \
  --rm \
  -p 10666:10666 \
  -v /Path/To/WADs/:/wads:ro \
  -v /Path/To/Configs/:/configs:ro \
  --name=zandronum-server \
  frozenfoxx/zandronum-server:latest \
  +sv_hostname "My Doom Server" \
  -port 10666 \
  -iwad /wads/DOOM2.WAD \
  -file /wads/brutal_doom.pk3 \
  +exec /configs/global.cfg \
  +exec /configs/coop.cfg
```

A full list of options and how to enable them is provided on the [ZDoom Wiki](https://zdoom.org/wiki/Command_line_parameters).

## Docker Compose

Below is an example `docker-compose.yml` for running a server:

```yaml
services:
  zandronum:
    image: frozenfoxx/zandronum-server:latest
    container_name: zandronum
    network_mode: host
    restart: unless-stopped
    command: >
      +sv_hostname "My Doom Server"
      -port 10666
      -iwad /wads/DOOM2.WAD
      -file /wads/maps/mymod.pk3
      +exec /configs/global.cfg
      +exec /configs/coop.cfg
    volumes:
      - /path/to/wads:/wads:ro
      - /path/to/configs:/configs:ro
```

Complex or per-server arguments can be managed with environment variables and an override `.env` file:

```yaml
services:
  zandronum:
    image: frozenfoxx/zandronum-server:latest
    container_name: zandronum
    network_mode: host
    restart: unless-stopped
    command: >
      +sv_hostname "${ZANDRONUM_HOSTNAME:-My Doom Server}"
      -port ${ZANDRONUM_PORT:-10666}
      ${ZANDRONUM_COMMAND}
    volumes:
      - /path/to/wads:/wads:ro
      - /path/to/configs:/configs:ro
```

With a corresponding `.env` file:

```
ZANDRONUM_COMMAND=-iwad /wads/DOOM2.WAD
  -file /wads/maps/Lexicon/lexicon.pk3
  +exec /configs/global.cfg
  +exec /configs/coop.cfg
  +map VR
ZANDRONUM_PORT=10666
```

## Multiplay

A [Multiplay](https://unity.com/products/multiplay) compatible version of this container is also available. For deployment to Multiplay, you will need to follow their Container [guidelines](https://docs.unity.com/multiplay/concepts/container-builds.html).

* Copy your WAD files into `wads`.
* Build the container (`docker build -t localhost/zandronum-server:multiplay -f Dockerfile.multiplay .`).
* Authenticate, tag, and push to Multiplay in alignment with their [documentation](https://docs.unity.com/multiplay/guides/get-started.html#Upload2).

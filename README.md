# Sphinx-Server

Sphinx-Server allows you to build *Sphinx documentation* using a Docker
image based on Alpine.

![Trueosiris Rules](https://img.shields.io/badge/trueosiris-rules-f08060) 
[![Docker Pulls](https://badgen.net/docker/pulls/trueosiris/sphinx-server?icon=docker&label=pulls)](https://hub.docker.com/r/trueosiris/sphinx-server/) 
[![Docker Stars](https://badgen.net/docker/stars/trueosiris/sphinx-server?icon=docker&label=stars)](https://hub.docker.com/r/trueosiris/sphinx-server/) 
[![Docker Image Size](https://badgen.net/docker/size/trueosiris/sphinx-server?icon=docker&label=image%20size)](https://hub.docker.com/r/trueosiris/sphinx-server/) 
![Github stars](https://badgen.net/github/stars/trueosiris/docker-sphinx-server?icon=github&label=stars) 
![Github forks](https://badgen.net/github/forks/trueosiris/docker-sphinx-server?icon=github&label=forks) 
![Github issues](https://img.shields.io/github/issues/TrueOsiris/docker-sphinx-server)
![Github last-commit](https://img.shields.io/github/last-commit/TrueOsiris/docker-sphinx-server)

**Functionnalities:**

- *Sphinx documentation* served by a python server
- UML support with *PlantUML*
- `dot` support with *Graphviz*
- *Autobuild* with sphinx-autobuild
- HTTP *authentication*

**Limitations:**

- This image is not bundled with LaTeX but you can generate *.tex* files and
  compile them outside of the container

## Installation

### With Docker Hub

Pull the image from Docker Hub using:

```sh
docker pull dldl/sphinx-server
```

If you only want to compile files without using the server, you can use the
following command (for example) at the root of your documentation:

```sh
docker run -t -v "$(pwd)":/web dldl/sphinx-server make html
```

### From source

Clone this repository on your computer and build the image using the following
command:

```sh
docker build -t dldl/sphinx-server .
```

## Usage

You may add a *.sphinx-server.yml* file at the root of your project
documentation if you want to use a custom configuration. You can see the default
*.sphinx-server.yml* in this repository that will be used if you don't add
yours.

### Container creation

**Without autobuild (production mode):**

If you want to enable HTTP authentication, just add a *.sphinx-server.yml* file
at the root of your project documentation and add a `credentials` section. You
also need to set `autobuild` to false.

Run the following command at the root of your documentation:

```sh
docker run -itd -v "$(pwd)":/web -p 8000:8000 --name sphinx-server dldl/sphinx-server
```

**With autobuild enabled:**

Autobuild is enabled by default. You may add folders and files to the `ignore` list.

Run the following command at the root of your documentation:

```sh
docker run -itd -v "$(pwd)":/web -u $(id -u):$(id -g) -p 8000:8000 --name sphinx-server dldl/sphinx-server
```

The web server will be listening on port `8000`.
All the files in the current directory will be mounted in the container.

**Docker compose example with autobuild enabled:**

```
---
version: "3.8"
services:
  sphinx:
    image: dldl/sphinx-server:latest
    container_name: sphinx
    restart: unless-stopped
    environment:
      - TZ=Europe/Brussels
      - UID=0
      - GID=0
    ports:
      - 9000:8000
    volumes:
      - docs:/web

volumes: 
  docs:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '/some/path/on/host/docs'
```

### Interacting with the server

- To stop the server, use `docker stop sphinx-server`
- To start the server, use `docker start sphinx-server`
- To remove the server, use `docker rm -v sphinx-server`

You can use the following command to open a shell into the container:

```sh
docker exec -it sphinx-server /bin/sh
```

You can then run commands like `make html` to build the documentation.

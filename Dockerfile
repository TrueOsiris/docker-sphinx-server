FROM ubuntu:23.04

MAINTAINER Tim Chaubet <tim@chaubet.be>

ENV PLANTUML_JAR_PATH=/plantuml.jar
ENV ASCIIDOC=false

COPY ./requirements.txt requirements.txt

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  python3 \
  python3-venv \
  net-tools \
  make \
  wget \
  ruby \
  ca-certificates \
  fonts-dejavu \
  graphviz \
  asciidoctor \
  enchant-2 \
  libenchant-2-2 \
  imagemagick \
 && apt-get clean -y \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
 && python3 -m venv .venv/sphinx 
RUN .venv/sphinx/bin/pip install --upgrade pip \
 && .venv/sphinx/bin/pip install --no-cache-dir  -r requirements.txt

COPY ./sphinx-server.yml ./
COPY ./start.sh ./
COPY ./plantuml.jar ./

RUN chmod +x /start.sh

VOLUME ["/docs"]
WORKDIR /docs

EXPOSE 8000

CMD ["/start.sh"]

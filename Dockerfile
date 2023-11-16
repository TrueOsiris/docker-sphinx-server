FROM ubuntu:23.04

MAINTAINER Tim Chaubet <tim@chaubet.be>

ENV PLANTUML_JAR_PATH=/plantuml.jar
ENV ASCIIDOC=false

COPY ./requirements.txt requirements.txt

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       python3 \
       python3-venv \
       pipx \
       net-tools \
       make \
       wget \
       ruby \
       ca-certificates 
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       fonts-dejavu \
       graphviz \
       asciidoctor \
       enchant-2 \
       libenchant-2-2 \
       imagemagick 
RUN apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

#RUN python3 -m pip install --upgrade pip && pip3 install --no-cache-dir  -r requirements.txt

COPY ./sphinx-server.yml ./
COPY ./start.sh ./
COPY ./plantuml.jar ./

RUN chmod +x /start.sh

VOLUME ["/docs"]
WORKDIR /docs

EXPOSE 8000

CMD ["/start.sh"]

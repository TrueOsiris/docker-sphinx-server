FROM ubuntu:22.04

MAINTAINER Tim Chaubet <tim@chaubet.be>

COPY ./requirements.txt requirements.txt

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
       python3 \
       python3-pip \
       make \
       ca-certificates \
       ttf-dejavu \
       openjdk-11-jre \
       graphviz
#apk add --no-cache --virtual --update py3-pip make wget ca-certificates ttf-dejavu openjdk8-jre graphviz \

RUN pip install --upgrade pip \
    && pip install --no-cache-dir  -r requirements.txt

#RUN wget http://downloads.sourceforge.net/project/plantuml/plantuml.jar -P /opt/ \
#    && echo -e '#!/bin/sh -e\njava -jar /opt/plantuml.jar "$@"' > /usr/local/bin/plantuml \
#    && chmod +x /usr/local/bin/plantuml

COPY ./server.py /opt/sphinx-server/
COPY ./.sphinx-server.yml /opt/sphinx-server/

WORKDIR /web

EXPOSE 8000 35729

CMD ["python", "/opt/sphinx-server/server.py"]

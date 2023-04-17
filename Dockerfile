FROM trueosiris/ubuntupypip:22.10

MAINTAINER Tim Chaubet <tim@chaubet.be>

COPY ./requirements.txt requirements.txt

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
       make \
       ca-certificates \
       fonts-dejavu \
       openjdk-11-jre \
       graphviz \
       wget
#apk add --no-cache --virtual --update py3-pip make wget ca-certificates ttf-dejavu openjdk8-jre graphviz \

RUN pip install --no-cache-dir  -r requirements.txt

COPY ./server.py /opt/sphinx-server/
COPY ./.sphinx-server.yml /opt/sphinx-server/

WORKDIR /web

EXPOSE 8000 35729

CMD ["python3", "/opt/sphinx-server/server.py"]

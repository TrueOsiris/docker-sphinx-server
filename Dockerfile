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

RUN pip install --no-cache-dir  -r requirements.txt

COPY ./.sphinx-server.yml /docs
COPY ./start.sh ./
RUN chmod +x /start.sh

WORKDIR /docs

EXPOSE 8000

CMD ["/start.sh"]

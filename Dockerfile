FROM trueosiris/ubuntupypip:22.10

MAINTAINER Tim Chaubet <tim@chaubet.be>

COPY ./requirements.txt requirements.txt

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       net-tools \
       make \
       ca-certificates \
       fonts-dejavu \
       graphviz \
       wget \
       asciidoctor \
    && apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir  -r requirements.txt

COPY ./sphinx-server.yml ./
COPY ./start.sh ./
RUN chmod +x /start.sh

VOLUME ["/docs"]
WORKDIR /docs

EXPOSE 8000

CMD ["/start.sh"]

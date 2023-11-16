FROM trueosiris/ubuntupypip:latest

MAINTAINER Tim Chaubet <tim@chaubet.be>

ENV PLANTUML_JAR_PATH=/plantuml.jar
ENV ASCIIDOC=false

COPY ./requirements.txt requirements.txt

RUN pip install --upgrade pip \
 && pip install --no-cache-dir  -r requirements.txt

COPY ./sphinx-server.yml ./
COPY ./start.sh ./
COPY ./plantuml.jar ./

RUN chmod +x /start.sh

VOLUME ["/docs"]
WORKDIR /docs

EXPOSE 8000

CMD ["/start.sh"]

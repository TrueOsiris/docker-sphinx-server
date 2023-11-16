#!/bin/bash
TZ=${TZ:-"Europe/Brussels"}
ASCIIDOC=${ASCIIDOC:-"false"}
echo "loading sphinx-autobuild config..."
if [ ! -f /docs/.sphinx-server.yml ]; then
  echo "copying default config to /docs/.sphinx-server.yml"
  cp /sphinx-server.yml /docs/.sphinx-server.yml
fi
cd /docs
ignorelist=`cat /docs/.sphinx-server.yml | shyaml get-values ignore | xargs` 
echo "starting sphinx-autobuild..."
if [ ! -f /docs/source/conf.py ]; then
	echo "no /docs/source/conf.py found."
	echo "running basic install"
	sphinx-quickstart -p myproject -a trueosiris -r 0.1 -l en --sep --ext-autodoc /docs
fi
if [ "$ASCIIDOC"=="true" || "$ASCIIDOC"==true ]; then
	sphinx-autobuild --host 0.0.0.0 --port 8000 /docs/source /docs/build/html -b asciidoc
else
	sphinx-autobuild --host 0.0.0.0 --port 8000 /docs/source /docs/build/html
fi
#--ignore "$ignorelist"

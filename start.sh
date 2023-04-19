#!/bin/bash
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
sphinx-autobuild --port 8000 --delay 2 source build/html --ignore "$ignorelist"

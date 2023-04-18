#!/bin/bash
echo "loading sphinx-autobuild config..."
if [ ! -f /docs/.sphinx-server.yml ]; then
  echo "copying default config .sphinx-server.yml
  cp /.sphinx-server.yml /docs/
fi
ignorelist=`cat /docs/.sphinx-server.yml | shyaml get-values ignore | xargs` 
echo "starting sphinx-autobuild..."
sphinx-autobuild --port 8000 --delay 2 --ignore $ignorelist /docs /docs/_build/html

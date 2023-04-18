#!/bin/bash
echo "loading sphinx-autobuild config..."
ignorelist=`cat /docs/.sphinx-server.yml | shyaml get-values ignore` 
echo "starting sphinx-autobuild..."
sphinx-autobuild --port 8000 --delay 2 --ignore $ignorelist /docs /docs/_build/html

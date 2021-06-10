#!/bin/bash

echo "Please enter package name..."
read name

docker exec sl_sharelatex tlmgr update --self
docker exec sl_sharelatex tlmgr install $name



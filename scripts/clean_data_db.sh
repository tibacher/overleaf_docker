#!/bin/bash

docker_path=`realpath $(dirname $(readlink -f $0))/../` 
cd $docker_path

./scripts/stop.sh

rm ./sharelatex_data/data/db*

./scripts/start.sh




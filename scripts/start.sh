#!/bin/sh
RC=0

docker_path=`realpath $(dirname $(readlink -f $0))/../` 
cd $docker_path

/usr/bin/docker-compose up -d --remove-orphans || RC=1

sleep 120 && sudo monit monitor sharelatex & sudo monit monitor sharelatex-local &
exit $RC

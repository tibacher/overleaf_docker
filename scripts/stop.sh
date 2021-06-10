#!/bin/sh
RC=0

docker_path=`realpath $(dirname $(readlink -f $0))/../` 
cd $docker_path

sudo monit unmonitor sharelatex && sudo monit unmonitor sharelatex-local
/usr/bin/docker-compose down -v --remove-orphans || RC=1
#rm proxy/conf.d/default.conf
exit $RC

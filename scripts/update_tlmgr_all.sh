#!/bin/bash


docker_path=`realpath $(dirname $(readlink -f $0))/../` 

TEXLIVE_MIRROR=https://ftp.fau.de/ctan/systems/texlive/tlnet
# TEXLIVE_MIRROR=http://mirror.ctan.org/systems/texlive/tlnet


read -r -p "Do want to update tlmgr and all pkgs? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
 echo "Yes...";
 ;;
    [nN][oO]|[nN])
 echo "No..."; exit 0;
       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac

cd $docker_path
# backup pkg list
docker exec sl_sharelatex tlmgr info --only-installed --data name >| tlmgr_pkg_list.txt 

# install updates
docker exec sl_sharelatex tlmgr update --repository ${TEXLIVE_MIRROR} --self --all


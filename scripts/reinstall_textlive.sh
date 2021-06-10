#!/bin/bash


docker_path=`realpath $(dirname $(readlink -f $0))/../` 
cd $docker_path


echo
echo 
read -r -p "Do you want to reinstall texlive (this may take a wihle!)? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
 echo "Yes...update!"; 
 ;;
    [nN][oO]|[nN])
 echo "No...exit"; exit;
       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac

echo
echo "Backup old textlive_data folder..."
mv texlive_data texlive_data.bak
echo "Creating new texlive_data folder."
mkdir texlive_data


TEXLIVE_MIRROR=https://ftp.fau.de/ctan/systems/texlive/tlnet
# TEXLIVE_MIRROR=http://mirror.ctan.org/systems/texlive/tlnet

echo "Using mirror ${TEXLIVE_MIRROR}"

container="sl_sharelatex"

# code: https://www.anginf.de/?p=714
# and code: https://github.com/overleaf/overleaf/blob/master/Dockerfile-base
docker exec $container mkdir install-tl-unx
docker exec $container bash -c "curl -sSL ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz | tar -xzC install-tl-unx --strip-components=1"

docker exec $container bash -c 'echo "tlpdbopt_autobackup 0" >> install-tl-unx/texlive.profile \
&&  echo "tlpdbopt_install_docfiles 0" >> install-tl-unx/texlive.profile \
&&  echo "tlpdbopt_install_srcfiles 0" >> install-tl-unx/texlive.profile \
&&  echo "selected_scheme scheme-full" >> install-tl-unx/texlive.profile'

docker exec $container install-tl-unx/install-tl -profile install-tl-unx/texlive.profile -repository ${TEXLIVE_MIRROR} && echo "Finished installation successfull."

docker exec $container rm -rf install-tl-unx 

#docker exec sl_sharelatex tlmgr update --self
#docker exec sl_sharelatex tlmgr install scheme-full
echo "update all..."
docker exec $container tlmgr update --repository ${TEXLIVE_MIRROR} --self --all

echo
echo 
read -r -p "Do you want to delete your previous texlive backup folder? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
 echo "Yes...delete!"; rm -rf texlive_data.bak
 ;;
    [nN][oO]|[nN])
 echo "No...exit"; exit;
       ;;
    *)
 echo "Invalid input..."
 exit 1
 ;;
esac


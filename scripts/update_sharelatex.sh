#!/bin/bash

docker_path=`realpath $(dirname $(readlink -f $0))/../` 
cd $docker_path
echo "You will update sharelatex docker!"
./scripts/check_activity.sh
read -r -p "Do you want to update? [Y/n] " input

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

# make snapper create here
#N=$(snapper -c home create -d "SL update pre" -t pre -p)


#docker-compose down --remove-orphans
./scripts/stop.sh

docker-compose pull

#docker-compose up -d --remove-orphans
./scripts/start.sh

# backup pkg list
#docker exec sl_sharelatex tlmgr info --only-installed --data name >| tlmgr_pkg_list.txt

echo
echo 
read -r -p "Do you want to update texlive? [Y/n] " input

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




# code: https://www.anginf.de/?p=714
#docker exec sl_sharelatex wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
#docker exec sl_sharelatex tar xvfz install-tl-unx.tar.gz
#echo "#######################################################################"
#echo "Execute 'cd install-tl-[0-9]*; ./install-tl'"
#echo "Please choose 'y' to import settings, then choose 'I' for installation."
#echo "Leave afterwards with 'exit'"
#echo "#######################################################################"
#docker exec -i -t sl_sharelatex /bin/bash
#docker exec sl_sharelatex wget http://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh -O /usr/local/texlive/2020/update-tlmgr-latest.sh
#docker exec sl_sharelatex chmod u+x /usr/local/texlive/2020/update-tlmgr-latest.sh
#docker exec sl_sharelatex /usr/local/texlive/2020/update-tlmgr-latest.sh -- --upgrade
docker exec sl_sharelatex tlmgr update --self
docker exec sl_sharelatex tlmgr install scheme-full
docker exec sl_sharelatex tlmgr update --all
#docker exec sl_sharelatex luaotfload-tool -fu


#snapper -c home create -d "SL update post" -t post --pre-number $N


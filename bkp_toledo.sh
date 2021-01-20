#!/bin/bash

data=`/bin/date +%d-%m-%Y`

#loja
CT="18"
#cria o arquivo de backup
cd $HOME/.PlayOnLinux/wineprefix/MGV5/drive_c/Program\ Files/TOLEDO
tar -zcvf MGV5-${data}.tar.gz MGV5
sudo chmod 777 MGV5-${data}.tar.gz

if grep -qs '/home/toledo/Público' /proc/mounts; then
	mv -v MGV5-${data}.tar.gz $HOME/Público/CPD/BKP_TOLEDO
else
	sudo mount -t cifs -s -o username=usradm18,password='217tenda',rw,users,dir_mode=0777,file_mode=0777 //10.18.1.9/GRP_USR/GRP_TMP /home/toledo/Público
	mv -v MGV5-${data}.tar.gz $HOME/Público/CPD/BKP_TOLEDO
fi



find /home/toledo/Público/CPD/MGV5-* -ctime +7 -type f -exec rm -rvf {} \;



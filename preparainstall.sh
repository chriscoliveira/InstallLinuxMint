
#!/bin/sh

if [ $(id -u) -eq 0 ] ; then echo "${RED}Por favor, execute a instalacao sem o comando 'sudo'.${SET}"  ; exit 1 ; fi


sudo mkdir -p /Instalacao
sudo chmod 777 -R /Instalacao
sudo cp -vr * /Instalacao

cd /Instalacao
sh install.sh

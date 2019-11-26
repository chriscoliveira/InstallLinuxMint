#!/bin/bash


RKGRAY='\033[1;30m'
eRED='\033[0;31;160m'
RED='\033[37;41m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
LIGHTPURPLE='\033[1;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
SET='\033[0m'


date
echo "\n\n\n Colocando o PC no Dominio \n\n"
echo "Instalando pacotes..."
sudo apt-get install -y krb5-user krb5-config winbind samba samba-common smbclient cifs-utils libpam-krb5 libpam-winbind libnss-winbind
echo ""
echo "Copiando arquivos modificados..."

echo "${RED}Digite o Numero da Filial Ex. 18 ${SET}"
read CT

echo "${RED}Digite o IP do Servidor AD ${SET}"
read IP

echo "${RED}Digite o Nome do Computador ${SET}"
read PC

echo "\nAjustando Horario do Computador..."
sudo service ntp stop
sudo ntpdate $IP
sudo hwclock --systohc


echo "resolv"
sudo cp -v /Instalacao/Dominio/resolv.conf /etc/resolv.conf

echo "krb5"

sudo rm -f /Instalacao/Dominio/krb5.conf

sudo echo "[libdefaults]
 default_realm = TENDA.COM.BR
 clockskew = 1000

[realms]
TENDA.COM.BR = {
 kdc = srvadct$CT.tenda.com.br
 default_domain = TENDA.COM.BR
 admin_server = srvadct$CT.tenda.com.br
}

[domain_realm]
 .tenda.com.br = TENDA.COM.BR" >> /Instalacao/Dominio/krb5.conf

sudo chmod 777 /Instalacao/Dominio/krb5.conf
sudo cp -v /Instalacao/Dominio/krb5.conf /etc/

sudo cat /etc/krb5.conf
echo "\n\n"
sleep 6

echo "smb"
sudo cp -v /Instalacao/Dominio/smb.conf /etc/samba/smb.conf

echo "nsswitch"
sudo cp -v /Instalacao/Dominio/nsswitch.conf /etc/nsswitch.conf

echo "common-session"
sudo cp -v /Instalacao/Dominio/common-session /etc/pam.d/common-session

echo "hosts"
sudo rm -f /Instalacao/Dominio/hosts
sudo echo "127.0.0.1	localhost
127.0.1.1	$PC.tenda.com.br $PC
$IP	srvadct$CT.tenda.com.br srvadct$CT
104.41.62.94	adfs.tenda-atacado.com.br


# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" >> /Instalacao/Dominio/hosts

sudo chmod 777 /Instalacao/Dominio/hosts
sudo cp -v /Instalacao/Dominio/hosts /etc/hosts

echo "Nome da maquina"
hostname -f

echo "${RED}Testanto o KRB ${SET}"
sudo kinit usradm$CT@TENDA.COM.BR

sudo klist

sudo /etc/init.d/networking restart

echo "reiniciando serviços"
sudo service winbind restart
#sudo service samba restart


echo "${RED}Entrando no dominio ${SET}"
sudo net ads join -U usradm$CT

if [ $? = "1"  ]
then
	echo "....\n Tentando Entrar no Domínio novamente... \n\n"
	sudo service winbind restart
	sudo net ads join -U usradm$CT
fi

echo "Reiniciando os Serviços"
sudo service winbind restart
sudo service samba restart
echo "Exibindo os grupos do AD para teste"
sudo wbinfo -g
echo "\n\n\n"
echo "caso precise mudar o dono da pasta."
echo "chown -R chapa.chapa /home/chapa"
echo ""
echo ""
echo "${RED}Pressione qualquer tecla para continuar ${SET}"
read x


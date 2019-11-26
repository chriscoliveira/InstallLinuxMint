
#!/bin/sh

RKGRAY='\033[1;30m'
eRED='\033[0;31;160m'
RED='\033[37;41m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[37;44m'
PURPLE='\033[0;35m'
LIGHTPURPLE='\033[1;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
SET='\033[0m'


if [ $(id -u) -eq 0 ] ; then echo "${RED}Por favor, execute a instalacao sem o comando 'sudo'.${SET}"  ; exit 1 ; fi


if [ $(id -u) -ne 0 ] ; then sh iinstalacao.sh ; exit 1 ; fi

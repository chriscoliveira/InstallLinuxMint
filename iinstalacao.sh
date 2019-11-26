#!/bin/sh



#MODIFICAÇÕES
#05092016
#RETIRADO AS OPCOES DE PERSONALIZAR O MENU INICIAR
#AUTOMATIZADO O PROCESSO DE INCLUSAO NO DOMINIO 100%
#CRIAR AS CONEXOES SAP EM MENU INDEPENDENTE
#14012017 - adicionado o script do openautid
#31012017 - adicionado o novo script para o SystemCenter
#06012017 - correcao de bugs entrada de dominio(data hora) colocar chapa sudoers
#15022017 - removido o crossOver e adicionado o playonlinux
#16022017 - adicionado no system center a plataforma x86 (ct33)
#16022017 - Corrigido o antivirus para as plataformas x86 e x64
#22022017 - modificado a entrada no dominio para exibir o arquivo krb5.conf apos a copia para o sistema
#22022017 - solicitado o numero da filial para sair do dominio
#28022017 - alterado a ordem dos itens de instalacao para reduzir a listagem e facilitar o processo
#28022017 - incluido o script para montar e desmontar as pastas de rede
#13032017 - adicionado ao item 13profile a definicao de wallpaper padrao
#22062017 - adicionado o firefox compativel com o Sitef para caixa central e tesouraria
#22062017 - alterado o 13profile para entrar com os endereços do desktop, documentos e tmp manualmente. devido a alterações da estrutura de pastas dos servers.
#22062017 - inserido a opcao ao sap 740
#16082017 - revisao de todo o codigo 
#19082017 - adicionado o script util de entrada no dominio
#19082017 - adicionado informe para utilizar o scanner no mint 18.2
#19082017 - modificado o script de reiniciar servicos toledo
#18012018 - retirado o SAP 7.30 da instalação 
#18012018 - definido o SAP 7.40 para instalar sh 3sap740
#18012018 - modificado para que o Java8 seja instalado "manualmente" e nao via repositorio sh 25Java
#18012018 - para o funcionamento perfeito do sap 7.40 é necessario instalar o java8

#14022018 - removido alguns arquivos sem uso
#14022018 - removido da instalação o Open Office e o Libre Office
#14022018 - corrigido um erro na instalação do firefox ondo o mesmo nao removia a versao original do sistema
#21022018 - corrigido erros refentes a instalacao e criacao das conexoes do SAP, agora esta funcionando corretamente.
#21022018 - corrigido a instalacao do PlayOnlinux, anteriormente apresentava erro de falta de algumas lib's .

#06042018 - adicionado compatibilidade do miniaplicativo localips para o mint 18.3
# - acionado os icones do windows 10, e removido os icones Win-7 pois estava 'estourando' a proporção
# - removido openaudit (sem uso)

#11042018 - corrigido erro ao associar o java ao firefox, agora o sitef esta funcionando corretamente
#11042018 - adicionado o comando ControlPanelJava para abrir o painel de controle do Java apartir do terminal indiferentemente do path que o terminal esteja.
#11042018 - removido mais alguns arquivos afim de deixar a instalacao mais leve
#16042018 - o Java agora sera baixado do Servidor 10.18.1.19 cada instalacao, assim o pacote de instalação ficou mais leve. facilitando a copia do mesmo.
#16042018 - o WPS tambem foi removido do pacote de instalacao assim como o Java o download será feito apartir do servidor 10.18.1.19
#16042018 - a personalização do sistema (temas e icones) esta sendo feita de modo automatico ao executarmos o Item "Personalizar o Sistema". Ficando apenas necessario ajustarmos a tela de login para o FreesansGrrl
#16042018 - na tela inicial do instalador (install.sh) apartir de agora virá com a data da versao do instalador.
#12072018 - adicionado a geração de Log durante a execucao do script de install (arquivo LogInstallMint)
#12072018 - colocado um alerta caso o SO utilizado não seja o Linux Mint 64bits com cinnamon
#12072018 - colorido o terminal em momentos de inicio de execução de algum menu ou quando é necessario chamar a atencao do usuario para a interacao com o script

#21072018 - modificado o sistema de carregamento dos arquivos dos usuario para nao armazenar as senhas em arquivo. agora quando é feito o login é solicitado ao usuario digitar a senha para carregar os arquivos

#21092018 - modificado o .profile para que nao fique gravado no arquivo a senha do usuario. feito ajustes para facilitar o ajuste dos parametros.
#21092018 - modificado a ordem de disposição dos itens no menu de instalação.
#21092018 - feito mudaça no aquivor 5dominio_entrar para forçar a entrada no dominio caso haja erro
#21092018 - feito um processo para validar senha .profile, caso a senha digitada esteja invalida não irá bloquear o usuario. Para recarregar a tela de montagem use o comando: $ recarrega_profile
#21092018 - desmontar limpar lixeira antes de criar perfil padrao
#21092018 - habilitado a copia dos favoritos basicos para a barra de favoritos do firefox e google-chrome no arquivo 27favoritos
#21092018 - não é mais necessario
#07112018 - diversas correções.

#07112018 - funciona no mint 18.3





# 01042019 - corrigido o arquivo preparainstall.sh que anteriormente estava vazio.
# 01042019 - não é mais possivel rodar os arquivos preparainstall e install.sh com o comando sudo.
# 01042019 - removido da instalação o firefox ESR, a versao default do sistema sera usada.
# 01042019 - corrigido a entrada de dominio o comando para parar o serviço de ntp e atualização da hora com base no servidor de ad
# 01042019 - corrigido o problema ao adicionar um usuario no arquivo sudoers apenas pressionando o enter sem digitar nada. e após a inserção do usuario é questionado se deseja adicionar um novo login.
# 01042019 - adicionado a instalação para a impressora Samsung usada para imprimir etiquetas.
# 01042019 - instalaçao dos scripts uteis é executada automaticamente ao rodar o install.sh
# 03042019 - corrigido o script de instalação do WPS
# 05042019 - icones adicionados no painel do iniciar.(chrome,remmina,sitef,sap)
# 05042019 - atualizado o sitef para a nova versao.
# 06042019 - adicionado a tradução para o WPS 2019
# 06042019 - itens necessarios foram marcados como obrigatorios no menu de instalação.
# 15042019 - retirado o link de acesso ao sitefweb do firefox e chrome. o acesso será fetio diretamente do lançador no painel do menu iniciar.
# 15042019 - toda vez que o script de instalacao iniciar sera feito o ajuste de data/hora no computador
# 15042019 - feito a correção que nao deixava o chrome abrir corretamente no mint 18.1
# 15042019 - corrigido bug que nao mostrava o ip da maquina no painel.


#25112019 - compactado as pastas de favoritos dos navegadores para reduzir o tamanho do arquivo.
# - adicionados os drivers para impressoras Ricoh
# - adicionado o app gscan2pdf no menu de impressoras
# - corrigido icone do java



DATAMODIFICADO="25.11.2019"


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


echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "${RED}Script Instalacao para maquinas Linux Tenda Atacado${SET}" 
echo "${RED}$DATAMODIFICADO${SET}"
echo ""
echo ""

sudo chmod -R 777 /Instalacao/*
echo "${BLUE}Define senha root${SET}"
sudo sh trocarsenharoot
date

sair(){
sudo killall -9 gnome-terminal-server 
exit;

}


alerta(){
case $(uname -m) in
x86_64)
    BITS=64
    ;;
i*86)
    BITS=32
    ;;
*)
    BITS=?
    ;;
esac


if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi


DESKTOP=$DESKTOP_SESSION

if [ "$OS" != "Linux Mint" ]; then
	ERRO="1"
fi
if [ "$BITS" != "64" ]; then
ERRO="1"
fi
if [ "$DESKTOP" != "cinnamon" ]; then
ERRO="1"
fi

if [ "$ERRO" = "1" ]; then
echo "aviso"
aviso
fi


}
aviso(){
zenity --warning --width="350" --title "Atenção" --text="Esse Script de instalação foi desenvolvido para o sistema <b>Linux Mint com Cinnamon 64 bits</b>! \n\nÉ recomendavel utilizar a versão 18 (18.1 18.3)</b>"
}

install_essencial(){
echo "${BLUE}\n\n\n Install Essencial \n\n${SET}"
while : ; do

	selecao=$(zenity --list  \
	--width="500"\
	--height="600" \
	--title 'Tenda Atacado LTDA - Add Repositorios e instala os aplicativos essenciais'\
	--column '*' --column 'Item'  \
	1 'Adicionar_Repositorios   -  (Obrigatorio)' \
	2 'Instalar_Pacotes_Essenciais  -  (Obrigatorio)' \
	3 'Personalizar_o_Sistema  -  (Obrigatorio)' \
	4 'Sair')
	    case "$selecao" in
		1) sh 18add_repositorios ;;
		2) pacotes_essenciais ;;
		3) sh 19personalizar ;;
		4) MenuPrincipal
	    esac

done
}





pacotes_essenciais(){
echo "${BLUE}\n\n\n Pacote essencial \n\n${SET}"
while : ; do
selecao=$(zenity --list  \
	--width="500"\
	--height="600" \
	--title 'Tenda Atacado LTDA - Aplicativos Essenciais'\
	--column '*' --column 'Item'  \
	1 'Themes   -  (Obrigatorio)'  \
	2 'Acesso Remoto  -  (Obrigatorio)' \
	3 'Google Chrome  -  (Obrigatorio)'  \
        4 'Colocar os Favoritos no firefox e chrome' \
	5 'Java 8 x64  -  (Obrigatorio)'\
	6 'Sair' )
 case "$selecao" in
		1) sh 22themes ;;
		2) sh 23acesso_remoto ;;
		3) sh 24chrome ;;
        4) sh 27favoritos ;;
		5) sh 25java ;;
		6) install_essencial
	    esac
done
}

sap(){
echo "${BLUE}\n\n\n sap \n\n${SET}"
while : ; do
selecao=$(zenity --list  \
	--width="500"\
	--height="600" \
	--title 'Tenda Atacado LTDA - SAP'\
	--column '*' --column 'Item'  \
	1 'Instalar SAP740   -  (Obrigatorio)'  \
	2 'Criar Conexao  -  (Obrigatorio)' \
	3 'Abrir SAP' \
	4 'Sair' )
 case "$selecao" in
		1) sudo sh 3sap740 ;;
		2) sh 3.1sap ;;
		3) /opt/SAPClients/SAPGUI7.40rev4/bin/guilogon ;;
		4) MenuPrincipal
	    esac
done
}

dominio(){
echo "${BLUE}\n\n\n Dominio \n\n${SET}"
while : ; do
selecao=$(zenity --list  \
	--width="500"\
	--height="600" \
	--title 'Tenda Atacado LTDA - Domínio'\
	--column '*' --column 'Item'  \
	1 'Entrar Dominio  -  (Obrigatorio)'  \
	2 'Retirar Dominio ' \
	3 'Colocar chapa no Sudoers  -  (Obrigatorio)' \
	4 'Sair' )
 case "$selecao" in
		1) sudo sh 5dominioentrar.sh ;;
		2) sudo sh 6dominio_sair ;;
		3) sudo sh 12sudoers ;;
		4) MenuPrincipal
	    esac
done
}

impressora(){
echo "${BLUE}\n\n\n Impressora \n\n${SET}"
while : ; do
selecao=$(zenity --list  \
	--width="500"\
	--height="600" \
	--title 'Tenda Atacado LTDA - Impressora'\
	--column '*' --column 'Item'  \
	1 'Instalar Brother' \
	2	'Corrigir scaner Mint 18 64bits' \
	3 'Instalar Lexmark' \
    4 'Instalar impressora Ricoh' \
	5 'Remover Brother' \
	6 'Instalar Programa para Scaner' \
    7 'Sair' )
 case "$selecao" in
		1) sh 7brother_instalar ;;
		2) gedit Impressora/Brother/scanMint18 && gksu & ;;
		3) sh 7.2lexmark_instalar ;;
		4) sh 7.3ricoh_instalar ;;
        5) sh 8brother_remover ;;
		6) sh 7.4digitalizador ;;
        7) MenuPrincipal
	    esac
done
}

office(){
echo "${BLUE}\n\n\n Office \n\n${SET}"
while : ; do
selecao=$(zenity --list  \
	--width="500"\
	--height="500" \
	--title 'Tenda Atacado LTDA - OFFICE'\
	--column '*' --column 'Item'  \
	1 'WPS' \
	2 'Sair' )
 case "$selecao" in
		1) sh 11wps ;;		
		2) MenuPrincipal
	    esac
done
}

usb(){

echo "${BLUE}\n\n\n USB \n\n${SET}"
while : ; do
selecao=$(zenity --list  \
	--width="500"\
	--height="600" \
	--title 'Tenda Atacado LTDA - USB'\
	--column '*' --column 'Item'  \
	1 'USB Bloqueio  -  (Obrigatorio)' \
	2 'USB Desbloqueio' \
	3 'Sair' )
 case "$selecao" in
		1) sh 14usb_bloquear ;;
		2) sh 14.1usb_desbloquear ;;	
		3) MenuPrincipal
	    esac
done
}

montardesmontar(){
echo "${BLUE}\n\n\n Scripts Uteis \n\n${SET}"
sudo cp -v /Instalacao/Scripts/* /usr/bin/
sudo chmod 777 /usr/bin/acertar_horario
sudo chmod 777 /usr/bin/desmontar_tudo  
sudo chmod 777 /usr/bin/montasmb
sudo chmod 777 /usr/bin/atualizar_sistema
sudo chmod 777 /usr/bin/desmontasmb        
sudo chmod 777 /usr/bin/reiniciar_servicos_toledo
sudo chmod 777 /usr/bin/reseta_painel
sudo chmod 777 /usr/bin/recarrega_profile
sudo chmod 777 /usr/bin/montaprofile

}

util(){
echo "${BLUE}\n\n\n Scripts Uteis \n\n${SET}"

zenity --info  \
	--title 'Tenda Atacado LTDA'\
	--height="300" \
        --width="400" \
	--text='\n<b><big>Scripts Uteis</big>\n\nPara acessar a pasta de algum servidor \n utilize o comando no terminal</b> \n $ <i> montasmb </i> \n <b> Para desmontar a pasta utilize o comando </b> \n $ <i>desmontasmb</i> \n <b>Para desmontar tudo do usuario</b>\n $<i> desmontar_tudo</i> \n <b> Para acertar o horario da maquina use</b> \n $ <i>acertar_horario</i> \n <b> Para fechar os servicos MGV use </b>\n $ <i>reiniciar_servicos_toledo</i> \n <b>Para resetar o painel do iniciar</b>\n $<i> reseta_painel</i> \n <b>Para recarregar o .Profile</b>\n $<i> recarrega_profile</i> \n <b>Para entrar novamente no dominio use</b> \n $<i> entrar_dominio</i>'  \

}

#inicia o bloco de menu
MenuPrincipal(){
echo "${BLUE}\n\n\n Menu Principal \n\n${SET}"
while : ; do

	MENU=$(zenity --list  \
		--width="500"\
		--height="450" \
		--title "Tenda Atacado LTDA - v. $DATAMODIFICADO"\
		--column '*' --column 'Item'  \
		1 'Add Repositorios e aplicativos essenciais  -  (Obrigatorio)' \
		2 'Configurar o VNC  -  (Obrigatorio)' \
		3 'SAP  -  (Obrigatorio)' \
		4 'Dominio  -  (Obrigatorio)' \
		5 'Impressora Brother e Samsung' \
		6 'Instalar o PlayOnLinux' \
		7 'Office  -  (Obrigatorio)' \
		8 'USB  -  (Obrigatorio)' \
		9 'SystemCenter  -  (Obrigatorio)' \
		10 'Montagem de Arquivos de Usr  -  (Obrigatorio)' \
		11 'Criar um perfil modelo  -  (Obrigatorio)' \
        12 'Reiniciar o Computador' \
		13 'Biometria' \
        14 'Agent Snow' \
		15 'Guia de Scripts Uteis' \
		0 'Sair ')

	    # De acordo com a opção escolhida, dispara programas
	    case "$MENU" in
		1) install_essencial | tee -a logInstallMint ;;
		2) sh 2vnc | tee -a logInstallMint ;;
		3) sap | tee -a logInstallMint ;;
		4) dominio | tee -a logInstallMint ;;
		5) impressora | tee -a logInstallMint ;;
		6) sh 9playonlinux | tee -a logInstallMint ;;
	        7) office | tee -a logInstallMint ;;
		8) usb | tee -a logInstallMint ;; 
		9) sh 15systemcenter | tee -a logInstallMint ;;		
		10) sh 13profile | tee -a logInstallMint ;;
        11) sh 4perfil_padrao | tee -a logInstallMint ;;		
	    12) sudo reboot -nf ;;
		13) sudo sh 28biometria | tee -a logInstallMint ;;	
        14) sh 29snow ;;
		15) util ;;
		0) sair
	    esac

done

}

alerta
montardesmontar


echo ""
echo "AJUSTANDO O HORARIO DO COMPUTADOR.. AGUARDE!"
sudo systemctl stop ntp.service
sudo ntpdate 10.128.0.24
date
echo "HORARIO ATUALIZADO."


MenuPrincipal | tee -a logInstallMint

 # ~/.profile: executed by the command interpreter for login shells.
 # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
 # exists.
 # see /usr/share/doc/bash/examples/startup-files for examples.
 # the files are located in the bash-doc package.
 
 # the default umask is set in /etc/profile; for setting the umask
 # for ssh logins, install and configure the libpam-umask package.
 #umask 022
 
 # if running bash
 if [ -n "$BASH_VERSION" ]; then
     # include .bashrc if it exists
     if [ -f "$HOME/.bashrc" ]; then
         . "$HOME/.bashrc"
     fi
 fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

sleep 8
 
info1=$(zenity --forms --title "Tenda Atacado" --text="Digite a senha do usuario $USER" --add-password "Senha")
pWd=$(echo $info1 | cut -d "|" -f 2)
 
if [ "$pWd" != '' ];then



###################################################################################################################################################################
#
#Confirme se o Caminho da área de trabalho esta conforme o endereço da pasta alocada no servidor
sudo mount -t cifs -s -o username=$USER,password=$pWd,rw,users,dir_mode=0777,file_mode=0777 //10.NUMLOJA.1.9/grp_usr/grp_SETOR/Desktop/ $HOME/Área\ de\ Trabalho
    AVISO=$?        
    if [ $AVISO -eq 0 ]
	then
#Confirme se o Caminho da documentos esta conforme o endereço da pasta alocada no servidor
sudo mount -t cifs -s -o username=$USER,password=$pWd,rw,users,dir_mode=0777,file_mode=0777 //10.NUMLOJA.1.9/grp_usr/grp_SETOR/Documents/ $HOME/Documentos
#
###################################################################################################################################################################


	    sudo mount -t cifs -s -o username=$USER,password=$pWd,rw,users,dir_mode=0777,file_mode=0777 //IPADLOJA/grp_usr/GRP_TMP $HOME/Público
	    sudo mount -t cifs -s -o username=$USER,password=$pWd,rw,users,dir_mode=0777,file_mode=0777 //IPADLOJA/grp_prg/pasta_Wallpaper $HOME/WallPaper
    fi
    if [ $AVISO -eq 1 ]
    then
        zenity --warning --width="350" --title "Atenção" --text="<b>Erro na autenticação da senha! Chame o CPD local!</b>"
    fi
fi


gsettings set org.cinnamon.desktop.background picture-uri file:///$HOME/WallPaper/800x600.jpg
gsettings set org.cinnamon.desktop.background picture-options 'stretched'


#!/bin/bash
#
#
# Author:          Arian Hosseini - https://github.com/arianXdev
# Collaboration:   Fernando Souza - https://www.youtube.com/@fernandosuporte/ | https://github.com/tuxslack
# Date:            19/01/2025        
# Script:          ~/.local/share/plank/themes/Arian Theme Light/install.sh
# Version:         0.2
#
#
# Arian Plank Theme
#
# https://www.gnome-look.org/p/1911700
#
# ----------------------------------------------------------------------------------------

# Cores (tabela de cores: https://gist.github.com/avelino/3188137)

VERM="\033[1;31m"	# Deixa a saída na cor vermelho.
VERD="\033[0;32m"	# Deixa a saída na cor verde.
CIAN="\033[0;36m"	# Deixa a saída na cor ciano.

NORM="\033[0m"		# Volta para a cor padrão.

# ----------------------------------------------------------------------------------------

# Lista dos programas a serem verificados.

programas=("plank")

# Variável para armazenar a lista de programas que não estão instalados.

programas_faltando=""

# Verifica se cada programa está instalado.

for programa in "${programas[@]}"; do

    if ! command -v "$programa" &>/dev/null; then

        programas_faltando+="$program is not installed.\n"

    fi

done

# ----------------------------------------------------------------------------------------


# Se algum programa não estiver instalado, exibe a tela de erro.

if [ -n "$programas_faltando" ]; then

    echo -e "${VERM}\n\nThe following programs are not installed:\n\n$missing_programs \n ${NORM}"

    exit 

fi

# ----------------------------------------------------------------------------------------


# Verificar se o Picom está instalado.

if ! command -v picom &> /dev/null; then

    echo -e "${VERM}\n\nPicom is not installed. \n ${NORM}"
    
    exit 1
    
else

    echo -e "${VERD}\nPicom is installed. \n ${NORM}"
    
fi

# ----------------------------------------------------------------------------------------

# Verificar se o processo Picom está rodando.

if pgrep -x "picom" > /dev/null; then

    echo -e "${VERD}\nPicom is running. \n ${NORM}"
    
    killall -9 picom
    
else

    echo -e "${VERM}\n\nPicom is not running. \n ${NORM}"
    
    # exit 2
fi

# ----------------------------------------------------------------------------------------

# Verificar se há algum erro no retorno do Picom (se há alguma mensagem de erro)

# Rodando o Picom em segundo plano e redirecionando a saída de erro para um arquivo.

picom &> /tmp/picom.log & 

# Espera um tempo para o Picom tentar iniciar.

sleep 2 

if [[ -s /tmp/picom.log ]]; then

    echo -e "${VERM}\n\nThere was an error starting Picom. Check /tmp/picom.log for details. \n ${NORM}"
    
    cat /tmp/picom.log
    
    exit 3
else
    echo -e "${VERD}\nPicom started successfully without errors. \n ${NORM}"
fi

# Limpeza

rm /tmp/picom.log

# ----------------------------------------------------------------------------------------


read -p "Do you want to install Arian theme (Light version) for Plank?" answer

PLANK_DIR="$HOME/.local/share/plank/themes"

case "$answer" in
    [yY][eE][sS]|[yY]|"")

    echo "Installing... Please wait!"

    if [ -d $PLANK_DIR ]; then
		cp -Ri . $PLANK_DIR/"Arian Theme Light"
		echo "Done!"
            read -p "Arian theme (Light) for Plank has been installed successfully! Do you want to open Plank preferences?" answer

            case "$answer" in
                [yY][eE][sS]|[yY]|"")
                plank --preferences

                echo "Finish! Enjoy it :)"
                ;;
            *)
            esac
	else
 
        echo -e "${VERD}
 
		Couldn't find $PLANK_DIR
  
		Please Make sure Plank Dock is installed properly
  
		For Arch-based distros: Try '# pacman -S plank'
  
                For Void Linux-based distros: Try '# xbps-install -Suvy plank'
		
		In Debian-based distros: Try '# apt install -y plank'
  
         ${NORM}"
   
		exit 1
  fi

    ;;
*)
esac

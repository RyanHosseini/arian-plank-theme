#!/bin/bash
#
#
# Author:          Arian Hosseini - https://github.com/arianXdev
# Collaboration:   Fernando Souza - https://www.youtube.com/@fernandosuporte/ | https://github.com/tuxslack
# Date:            19/01/2025        
# Script:          ~/.local/share/plank/themes/Arian Theme/install.sh
# Version:         0.2
#
#
# Arian Plank Theme
#
# https://www.gnome-look.org/p/1911700
#
# ----------------------------------------------------------------------------------------

programas=("picom" "plank")

# Verificar cada programa

for prog in "${programas[@]}"; do

    if command -v "$prog" &> /dev/null; then
    
        echo -e "\n$prog is installed.\n"
	
    else
    
        echo -e "\n$prog is not installed.\n"
	
        exit 1
	
    fi
    
done

# ----------------------------------------------------------------------------------------

read -p "Do you want to install Arian theme for Plank? (y/n) " answer

PLANK_DIR="$HOME/.local/share/plank/themes"
SOURCE_DIR="./Arian Theme"
SOURCE_LIGHT_DIR="./Arian Theme Light"

case "$answer" in
    [yY][eE][sS]|[yY]|"")
    
        echo "Installing... Please wait!"

        # Verificar se os diretórios de origem existem
	
        if [ -d "$SOURCE_DIR" ] && [ -d "$SOURCE_LIGHT_DIR" ]; then
	
            # Verificar se o diretório de instalação do Plank existe
	    
            if [ -d "$PLANK_DIR" ]; then
	    
                cp -Ri "$SOURCE_DIR" "$PLANK_DIR" && cp -Ri "$SOURCE_LIGHT_DIR" "$PLANK_DIR"
		
                echo "Done!"
                
                read -p "Arian theme for Plank has been installed successfully! Do you want to open Plank preferences? (y/n) " answer
		
                case "$answer" in
                    [yY][eE][sS]|[yY]|"")
		    
                        plank --preferences &
			
                        echo "Finish! Enjoy it :)"
			
                        ;;
                    *)
		    
                        echo "Skipping Plank preferences."
			
                        ;;
                esac
            else
	    
                echo "Couldn't find $PLANK_DIR"
                echo ""
                echo "Please make sure Plank Dock is installed properly."
                echo "For Arch-based distros: Try '# pacman -S plank'"
                echo "For Void Linux-based distros: Try '# xbps-install -Suvy plank'"
                echo "In Debian-based distros: Try '# apt install -y plank'"
		
                exit 1
            fi
        else
	
            echo "Couldn't find the theme directories: '$SOURCE_DIR' or '$SOURCE_LIGHT_DIR'"
	    
            exit 1
        fi
        ;;
    *)
    
        echo "Installation aborted."
	
        exit 2
        ;;
esac

exit 0

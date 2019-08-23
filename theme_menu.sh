#!/bin/bash
#=============================================================================
#title:         theme_menu.sh
#description:   Menu which allows GPi theme selection
#author:        Crash edited by bebeidon
#created:       June 24 2019
#updated:       21.08.2019
#version:       1.0
#usage:         ./theme_menu.sh
#==============================================================================
export NCURSES_NO_UTF8_ACS=1

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " GPi THEME MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "Select a theme or update this script" 25 75 20 \
            1 "Pixel-GPi" \
            2 "Super-Retroboy-GPi" \
            3 "GBZ35-GPi" \
            4 "GBZ35-dark-GPi" \
            5 "Minijawn-GPi" \
            6 "Update this script" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) pixel  ;;
            2) super-retroboy  ;;
            3) gbz35  ;;
            4) gbz35-dark  ;;
            5) minijawn  ;;
            6) update  ;;
            *)  break ;;
        esac
    done
}

function pixel() {
github='https://github.com/bebeidon/es-theme-pixel/archive/master.zip'
#tmp_folder is the name of the downloaded and extracted archive, generated by github URL
#don't change unless you know it changed on source!
tmp_folder='es-theme-pixel-master'
name='pixel-gpi'
submenu
}
function super-retroboy() {
github='https://github.com/SinisterSpatula/Super_Retroboy_Theme/archive/master.zip'
tmp_folder='es-theme-Super-Retroboy-master'
name='Super-Retroboy-gpi'
submenu
}
function gbz35() {
github='https://github.com/rxbrad/es-theme-gbz35/archive/master.zip'
tmp_folder='es-theme-gbz35-master'
name='gbz35-gpi'
submenu
}
function gbz35-dark() {
github='https://github.com/rxbrad/es-theme-gbz35-dark/archive/master.zip'
tmp_folder='es-theme-gbz35-dark-master'
name='gbz35-dark-gpi'
submenu
}
function minijawn() {
github='https://github.com/pacdude/es-theme-minijawn/archive/master.zip'
tmp_folder='es-theme-minijawn-master'
name='minijawn-gpi'
submenu
}

function submenu(){

    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " $name THEME MENU " \
            --ok-label OK --cancel-label Back \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Install / Update $name theme" \
            2 "Apply $name theme" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) install_update  ;;
            2) change_theme  ;;
            *)  break ;;
        esac
    done
}

######################
# Functions for menu #
######################

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
    return 0
  else
    return 1
  fi
}

function install_update() {
if validate_url $github; then
mkdir -p /opt/retropie/configs/all/emulationstation/themes
cd /opt/retropie/configs/all/emulationstation/themes
sudo wget -O master.zip $github
sudo unzip -o master.zip
sudo rm -f master.zip
sudo mkdir -p $name
sudo cp -rf $tmp_folder/* $name
sudo rm -rf $tmp_folder/
sudo chown -R pi:pi $name/

echo "--------------------------------------------------------------------------------"
echo "Latest version of $name installed"
echo ""
echo "If you want to apply the theme, choose the next option [2 Use $name theme] in the menu!"
echo "--------------------------------------------------------------------------------"
sleep 10s
  else
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo ".                                      ."
    echo ".FAILED! File not available or wifi off."
    echo ".                                      ."
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    sleep 5s
fi
}

function change_theme() {
cd /opt/retropie/configs/all/emulationstation/themes

if [ -d "/opt/retropie/configs/all/emulationstation/themes/$name" ]
then
        if [ -d "$name/retropie/icons" ]
        then
                if [ -d "/home/pi/RetroPie/retropiemenu/icons_default" ]
                then
                        echo "Directory /home/pi/RetroPie/retropiemenu/icons_default exists. Skipping."
                else
                        mkdir -p /home/pi/RetroPie/retropiemenu/icons_default
                        cp /home/pi/RetroPie/retropiemenu/icons/* /home/pi/RetroPie/retropiemenu/icons_default
                fi

        sudo rm -rf /home/pi/RetroPie/retropiemenu/icons/*
        sudo cp $name/retropie/icons/* /home/pi/RetroPie/retropiemenu/icons/
        cp  -n /home/pi/RetroPie/retropiemenu/icons_default/* /home/pi/RetroPie/retropiemenu/icons

        else
                if [ -d "/home/pi/RetroPie/retropiemenu/icons_default" ]
                then
                        cp -f /home/pi/RetroPie/retropiemenu/icons_default/* /home/pi/RetroPie/retropiemenu/icons
                else
                        echo "Directory /home/pi/RetroPie/retropiemenu/icons_default does not exist. Skipping."
                fi
        fi

sudo sed -i -- 's:<string name="ThemeSet" value=.*/>:<string name="ThemeSet" value="'$name'" />:g' /opt/retropie/configs/all/emulationstation/es_settings.cfg

echo "--------------------------------------------------------------------------------"
echo "Theme changed to $name"
echo ""
echo "Emulationstation will be restarted now. Exiting the script. Please be patient."
echo "--------------------------------------------------------------------------------"
sleep 10s
es_restart

else
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo ".                                      ."
    echo ". FAILED! Theme is not installed yet!  ."
    echo ".                                      ."
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    sleep 5s
fi
}

function update() {
if validate_url https://raw.githubusercontent.com/bebeidon/gpi-theme-menu/master/theme_menu.sh; then
cd
cd /home/pi/RetroPie/retropiemenu/gpitools/
sudo wget -O theme_menu.sh https://raw.githubusercontent.com/bebeidon/gpi-theme-menu/master/theme_menu.sh
sudo chmod a+x theme_menu.sh
    echo "---------------"
    echo "|| Success!  ||"
    echo "---------------"
    sleep 5s
    $0
    exit 1
  else
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo ".                                      ."
    echo ".FAILED! File not available or wifi off."
    echo ".                                      ."
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    sleep 5s
fi
}

function launch_commandline() {
break
}

function es_restart() {
touch /tmp/es-restart && sudo pkill -f "/opt/retropie/supplementary/.*/emulationstation([^.]|$)"
exit 1
}

# Main

main_menu

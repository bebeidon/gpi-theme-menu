# gpi-theme-menu

# Follow these instructions for update function to work:

Create the `/home/pi/RetroPie/retropiemenu/gpitools/` directory

Put the `theme_menu.sh` in the `/home/pi/RetroPie/retropiemenu/gpitools/` directory
```
cd /home/pi/RetroPie/retropiemenu
mkdir gpitools
cd gpitools
wget -O theme_menu.sh https://raw.githubusercontent.com/bebeidon/gpi-theme-menu/master/theme_menu.sh
chmod 755 theme_menu.sh
```

# Follow these instructions for new icons to appear
The icons for the GPi-Tools folder and more GPi specific icons will be downloaded by the theme_menu.
You will have to edit your `gamelist.xml` in `/opt/retropie/configs/all/emulationstation/gamelists/retropie/` to include the new images like this:
```
    <game>
        <path>./gpitools</path>
        <name>GPi-Tools</name>
        <desc>Various tools for GPi</desc>
        <image>./icons/gpitools.png</image>
    </game>
    <game>
        <path>./gpitools/control_updater_menu.sh</path>
        <name>Control Updater Menu</name>
        <desc>Xboxdrv - Advanced Framework Updater by Adam.</desc>
        <image>./icons/controllertools.png</image>
    </game>
    <game>
        <path>./gpitools/theme_menu.sh</path>
        <name>GPi Theme Menu</name>
        <desc>Theme Menu for GPi by bebeidon</desc>
        <image>./icons/theme_menu.png</image>
    </game>
    <game>
        <path>./gpitools/Kernel_Boot_Logo.sh</path>
        <name>Kernel Boot Logo</name>
        <desc>Change the Boot Logo before the splashscreen/video</desc>
        <image>./icons/kernelbootlogo.png</image>
    </game>
```

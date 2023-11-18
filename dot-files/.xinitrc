#!/bin/bash

## KEYBOARD
setxkbmap fr&       												## layout (before every others keyboard options).
kill $( pidof xcape ); xcape -e "Super_L=Control_L|Escape"&			## 
xcape -e "Super_R=Control_L|Escape"&								## Super key (for keybinding (rofi/dmenu/whiskermenu/...)
numlockx on&														## Turn on numlock (before numpad as mouse).
setxkbmap -option "keypad:pointerkeys"&     						## Numpad as mouse (shift + numlock to enable)
kill $( pidof sxhkd ); sxhkd&                               	    ## Keyboard shortcut.

## DESKTOP
xsetroot -grey&     												## Desktop background.
xrdb -merge -load ~/.Xresources		 								## Load X colors.
kill $( pidof picom ); picom&                     			        ## Screen compositor.
kill $( pidof jgmenu ); jgmenu --at-pointer --hide-on-startup&  	## Desktop menu.
/home/lespink/.screenlayout/layout.sh&								## Display resolution/layout.
xrandr --output HDMI-A-0 --scale 1.27 --mode 1360x768				## Set custom resolution.
randombg&															## Set a random background.

## UTLITY
kill $( pidof nm-applet ); nm-applet&        	                    ## Network tray icon.
kill $( pidof meteo-qt ); meteo-qt -c -i orange -o brown -a -t 10&	## Meteo indicator.
kill $( pidof psensor ); psensor&									## Temperature monitor.
xterm -e "sudo btop"&

## ACCESSIBILITY
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1&		## Auth agent.

kill $( pidof xfce4-clipman ); xfce4-clipman&                   	## Clipboard manager.
kill $( pidof pasystray ); pasystray&            	                ## Pulseaudio tray icon.
kill $( pidof dunst ); dunst --startup-notification&         	    ## Notification.
kill $( pidof geoclue ); /usr/libexec/geoclue-2.0/demos/agent&  	## Geolocation service.
kill $( pidof redshift-gtk ); redshift-gtk&                     	## Blue light filter.
#kill $( pidof onboard ); onboard&     		                        ## Onscreen keyboard
#kill $( pidof caffeine-indicator ); caffeine-indicator&  	        ## stay awake

## BATTERY
#kill $( pidof upowerd ); kill $( pidof xfce4-power-manager ); xfce4-power-manager&		## Power manager.
#kill $( pidof xbattbar ); xbattbar -c -i orange -o brown -a -t 10&						## Battery indicator
#kill $( pidof xscreensaver ); xscreensaver&											## Screen saver.


startDwm() {
	wmname "LG3D"&
	slstatus&
	exec dwm\
			>> ~/.dwm.log
}
startDwm

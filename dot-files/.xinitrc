#!/bin/bash

export AWT_TOOLKIT='MToolKit'
export _JAVA_AWT_WM_NONREPARENTING='1'

xrdb -merge -load ${HOME}/.Xresources ## load Xcolors
xsetroot -grey&     ## desktop colors
setxkbmap fr&       ## layout (before every others keyboard options)
numlockx on&        ## turn on numlock (before numpad as mouse)
setxkbmap -option "keypad:pointerkeys"&     ## numpad as mouse (shift + numlock to enable)

kill $( pidof xcape ); xcape -e "Super_L=Control_L|Escape"&			## super key (for keybinding (rofi/dmenu/whiskermenu/...)
kill $( pidof xcape ); xcape -e "Super_R=Control_L|Escape"&			## super key (for keybinding (rofi/dmenu/whiskermenu/...)
kill $( pidof sxhkd ); sxhkd&                               	    ## keyboard shortcut
kill $( pidof xfce4-clipman ); xfce4-clipman&                   	## clipboard manager
kill $( pidof onboard ); onboard&     		                        ## onscreen keyboard
kill $( pidof nm-applet ); nm-applet&        	                    ## network tray icon
kill $( pidof pasystray ); pasystray&            	                ## pulseaudio tray icon
kill $( pidof caffeine-indicator ); caffeine-indicator&  	        ## stay awake
kill $( pidof dunst ); dunst --startup-notification&         	    ## notification
kill $( pidof jgmenu ); jgmenu --at-pointer --hide-on-startup&  	## desktop menu
kill $( pidof geoclue ); /usr/libexec/geoclue-2.0/demos/agent&  	## enable geolocation
kill $( pidof redshift-gtk ); redshift-gtk&                     	## blue light filter
kill $( pidof picom ); picom -i 0.8&                     			## blue light filter
#kill $( pidof upowerd ); kill $( pidof xfce4-power-manager ); xfce4-power-manager&
#kill $( pidof xbattbar ); xbattbar -c -i orange -o brown -a -t 10&	## bottom battery indicator
kill $( pidof xscreensaver ); xscreensaver&
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1&

startDwm() {
	slstatus&
	exec dwm\
			>> ~/.dwm.log
}

startTwm() {
	exec twm\
			>> ~/.twm.log
}

startDwm||startTwm

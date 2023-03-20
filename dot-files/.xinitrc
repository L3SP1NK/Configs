#!/bin/sh

if [ -e ${HOME}/.Xresources ]; then
	xrdb -merge -load ${HOME}/.Xresources&
fi

setxkbmap fr&
setxkbmap -option keypad:pointerkeys& ## Numpad as mouse (shift + numlock to enable)
#numlockx on&

kill $(pidof dunst> /dev/null)2>/dev/null; dunst --startup-notification&
kill $(pidof geoclue> /dev/null)2>/dev/null; /usr/libexec/geoclue-2.0/demos/agent&
kill $(pidof redshift-gtk> /dev/null)2>/dev/null; redshift-gtk&
kill $(pidof nm-applet> /dev/null)2>/dev/null; nm-applet&
kill $(pidof pasystray> /dev/null)2>/dev/null; pasystray&
kill $(pidof xscreensaver> /dev/null)2>/dev/null; xscreensaver&
kill $(pidof caffeine-indicator> /dev/null)2>/dev/null; caffeine-indicator&
kill $(pidof xcape> /dev/null)2>/dev/null; xcape -e "Super_L=Control_L|Escape"&
kill $(pidof xfce4-clipman> /dev/null)2>/dev/null; xfce4-clipman&

if [ -e ${HOME}/.config/sxhkd/sxhkdrc ]; then
	kill $(pidof sxhkd> /dev/null)2>/dev/null; sxhkd&
fi

startDwm(){
	slstatus&
	exec dwm \
			>> ~/.dwm.log
}
startTwm(){
	exec twm \
			>> ~/.twm.log
}
startDwm
#startTwm

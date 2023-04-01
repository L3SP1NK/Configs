#!/bin/sh

setColors() {
    if [ -e ${HOME}/.Xresources ]; then
	    xrdb -merge -load ${HOME}/.Xresources&
    fi

    xsetroot -grey&
}
setColors

kbOpt() {
    setxkbmap fr&
    setxkbmap -option "keypad:pointerkeys"& ## Numpad as mouse (shift + numlock to enable)
    numlockx on&
}
kbOpt

bgJobs() {
    kill $(pidof dunst); dunst --startup-notification&
    kill $(pidof geoclue); /usr/libexec/geoclue-2.0/demos/agent&
    kill $(pidof redshift-gtk); redshift-gtk&
    kill $(pidof nm-applet); nm-applet&
    kill $(pidof pasystray); pasystray&
    kill $(pidof xscreensaver); xscreensaver&
    kill $(pidof caffeine-indicator); caffeine-indicator&
    kill $(pidof xcape); xcape -e "Super_L=Control_L|Escape"&
    kill $(pidof xfce4-clipman); xfce4-clipman&
    kill $(pidof sxhkd); sxhkd&
}
bgJobs

exportJavaOpt() {
    export AWT_TOOLKIT=MToolKit
    export _JAVA_AWT_WM_NONREPARENTING=1
}
exportJavaOpt

startDwm() {
	slstatus&
	exec dwm \
			>> ~/.dwm.log
}

startTwm() {
	exec twm \
			>> ~/.twm.log
}

startDwm
#startTwm

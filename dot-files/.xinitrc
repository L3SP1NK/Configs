#!/bin/sh

export AWT_TOOLKIT=MToolKit
export _JAVA_AWT_WM_NONREPARENTING=1

coproc xrdb -merge -load ${HOME}/.Xresources ## load Xcolors
coproc xsetroot -grey     ## desktop colors
coproc setxkbmap fr       ## layout (before every others keyboard options)
coproc numlockx on        ## turn on numlock (before numpad as mouse)
coproc setxkbmap -option "keypad:pointerkeys"     ## numpad as mouse (shift + numlock to enable)

coproc kill $( pidof xcape )
coproc xcape -e "Super_L=Control_L|Escape"     ## super key (for keybinding (rofi/dmenu/whiskermenu/...)
coproc xcape -e "Super_R=Control_L|Escape"

coproc kill $( pidof sxhkd ); sxhkd                                   ## keyboard shortcut
coproc kill $( pidof xfce4-clipman ); xfce4-clipman                   ## clipboard manager
coproc kill $( pidof onboard ); onboard                               ## onscreen keyboard
coproc kill $( pidof nm-applet ); nm-applet                           ## network tray icon
coproc kill $( pidof pasystray ); pasystray                           ## pulseaudio tray icon
coproc kill $( pidof xscreensaver ); xscreensaver                     ## screensaver
coproc #kill $( pidof caffeine-indicator ); caffeine-indicator         ## stay awake
coproc kill $( pidof dunst ); dunst --startup-notification            ## notification
coproc kill $( pidof jgmenu ); jgmenu --at-pointer --hide-on-startup  ## desktop menu
coproc kill $( pidof geoclue ); /usr/libexec/geoclue-2.0/demos/agent  ## enable geolocation
coproc kill $( pidof redshift-gtk ); redshift-gtk                     ## blue light filter

startDwm() {
	slstatus
	exec dwm\
			>> ~/.dwm.log
}

startTwm() {
	exec twm\
			>> ~/.twm.log
}

startDwm||startTwm

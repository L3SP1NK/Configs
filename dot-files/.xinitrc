#!/bin/bash

export QT_QPA_PLATFORMTHEME='qt6ct'
export XDG_SESSION_TYPE='x11'
export _JAVA_AWT_WM_NONREPARENTING='1'

## Load X colors
xrdb -merge -load ~/.Xresources&

## Keyboard layout (before every others keyboard options)
setxkbmap fr&

## Reverse touchpad scroool direction
xinput --set-prop 8 "libinput Natural Scrolling Enabled" 1&

## Turn on numlock (before numpad as mouse)
numlockx on&


## Numpad as mouse (shift + numlock to enable)
setxkbmap -option "keypad:pointerkeys"&

xbindkeys&

## Super key (for keybinding (rofi/dmenu/whiskermenu/...)
if pidof xcape;	then
	killall xcape
fi
xcape -e "Super_L=Control_L|Escape"&
#xcape -e "Super_R=Control_L|Escape"&

## Keyboard shortcut
if pidof sxhkd; then
	killall sxhkd
fi
sxhkd&

## Meteo indicator
#if pidof meteo-qt; then
#	killall meteo-qt
#fi
#meteo-qt -c -i orange -o brown -a -t 10&

## Network tray icon
if pidof nm-applet; then
	killall nm-applet
fi
nm-applet&

### Temperature monitor
#if pidof psensor; then
#	killall psensor
#fi
#psensor&

## Clipboard manager
if pidof xfce4-clipman; then
	killall xfce4-clipman
fi
xfce4-clipman&

## Sound indicator
if pidof pasystray; then
	killall pasystray
fi
pasystray&

## Notifications
if pidof dunst; then
	killall dunst
fi
dunst --startup-notification&

## Geolocation service
if pidof geoclue||pidof agent; then
	killall geoclue agent
fi
/usr/libexec/geoclue-2.0/demos/agent&

### Blue light filter
if pidof redshift-gtk; then
	killall redshift-gtk
fi
redshift-gtk&
#
### Onscreen keyboard
#if pidof onboard; then
#	killall onboard
#fi
#onboard&

### Stay awake
#if pidof caffeine-indicator; then
#	killall caffeine-indicator
#fi
#caffeine-indicator&

## Set a random background
randombg&

## Desktop right click menu
kill $( pidof jgmenu ); jgmenu --at-pointer --hide-on-startup&

## System monitor
#x-terminal-emulator -e 'btop'&
xterm -e 'byobu'&

## Auth agent
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1&

### Power manager
#if pidof xfce4-power-manager; then
#	killall xfce4-power-manager
#fi
#xfce4-power-manager&
#
### Battery indicator
#if pidof xbattbar; then
#	killall xbattbar
#fi
#xbattbar -c -i orange -o brown -a -t 10&

### Screensaver
#if pidof xscreensaver; then
#	killall xscreensaver
#fi
#xscreensaver&

## Screen compositor
if pidof picom; then
	killall picom
fi

picom&

startDwm() {

	wmname 'LG3D'&

	${HOME}/.screenlayout/layout.sh&

	slstatus&

	dwm

}

startDwm
#startxfce4

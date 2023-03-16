#!/bin/sh

startX(){
	##############
	## X COLORS ##
	##############

	loadXcolors(){
		if [ -e ${HOME}/.Xresources ];then
			xrdb -merge -load ${HOME}/.Xresources&
		fi
	}
	loadXcolors

	##################
	## NOTIFICATION ##
	##################

	startDunst(){
		if which dunst>/dev/null;then
			if ! pidof dunst>/dev/null;then
				dunst --startup_notification&
			fi
		fi
	 }
	startDunst


	#############
	## SYSTRAY ##
	#############

	setDisplayTemp(){
		if apropos geoclue>/dev/null;then
			if which redshift>/dev/null;then
				if ! pidof geoclue;then
					/usr/libexec/geoclue-2.0/demos/agent&
				fi

				if ! pidof redshift-gtk>/dev/null;then
					redshift-gtk&
				fi
			fi
		fi
	}
	setDisplayTemp

	startNetworkTray(){
		if which nm-applet>/dev/null;then
			if ! pidof nm-applet>/dev/null;then
				nm-applet&
			fi
		fi
	}
	startNetworkTray

	startSoundTray(){
		if which pulseaudio>/dev/null;then
			if which pasystray>/dev/null;then
				if ! pidof pasystray>/dev/null;then
					pasystray&
				fi
			fi
		fi
	}
	startSoundTray

	################
	## DESKTOP BG ##
	################

	setDesktopBackground(){
		setMoonDesktopBackgorund(){
			## Set the desktop background to an image of the current moon phase.
			if which pngphoon feh>/dev/null;then
				stars_num='100' ## Number of stars to display behind the moon.
				res_x=`xrandr|grep "\*" | head -n1 | awk '{print $1}'|cut -d "x" -f 1`
				res_y=`xrandr|grep "\*" | head -n1 | awk '{print $1}'|cut -d "x" -f 2`
				pngphoon -w ${res_x} -h ${res_y} -x 1 -s ${stars_num} -f -|feh --bg-fill - &
			fi
		}

		setAntFarmDesktopBackground(){
			## Set the desktop backgroun to an ant farm.
			xantfarmbin='/opt/xantfarm/xantfarm'
			if [ -e ${xantfarmbin} ];then
				ant_num='9000' ## warning!
				air_color='CornFlowerBlue'
				sand_color='GoldenRod'
				ant_color='SaddleBrown'

				nice -20 ${xantfarmbin} -num ${ant_num} -c 0 -air ${air_color} -sand ${sand_color} -ant ${ant_color}
			fi
		}
		#setAntFarmDesktopBackground
		setMoonDesktopBackground
	}
	setDesktopBackground

	#################
	## SCREENSAVER ##
	#################

	startScreensaver(){
		if which xscreensaver>/dev/null;then
			if ! pidof xscreensaver>/dev/null;then
				xscreensaver&
			fi
		fi
	}
	startScreensaver

	##############
	## KEYBOARD ##
	##############

	keyboardOptions(){
		setKeyboardLayout(){
			setxkbmap fr&
			if which numlockx>/dev/null;then
				numlockx on&
			fi
		}
		setKeyboardLayout

		bindModKey(){
			if which xcape>/dev/null;then
				if ! pidof xcape>/dev/null;then
					mod='Super_L'
					xcape -e "${mod}=Control_L|Escape"&
				fi
			fi
		}
		bindModKeys

		startKeyboardShortcutDaemon(){
			if which sxhkd>/dev/null;then
				if [ -e ${HOME}/.config/sxhkd/sxhkdrc ];then
					if ! pidof sxhkd>/dev/null;then
						sxhkd&
					fi
				fi
			fi
		}
		startKeyboardShortcutDaemon

		startClipboardManager(){
			if which xfce4-clipman>/dev/null;then
				if ! pidof xfce4-clipman>/dev/null;then
					xfce4-clipman&
				fi
			fi
		}
		startClipboardManager
	}
	keyboardOptions

	#############
	## SYSINFO ##
	#############

	printSysInfo(){
		if which xmessage>/dev/null
			then
 				printf "`whoami`\n\n`uname -a`\n\n`cat /proc/cmdline`\n\n"|xmessage -nearmouse -file -&
		fi
	}
	printSysInfo

	####################
	## WINDOW MANAGER ##
	####################

	startWindowManager(){
		startDwm(){
			if ! which slstatus>/dev/null;then
				echo "slstatus not found!"
				exit 1
			else
				if ! pidof slstatus>/dev/null;then
					slstatus&
				fi
			fi

			if ! which dwm>/dev/null;then
				echo "DWM not found!"
				exit 1
			else
				if ! pidof dwm>/dev/null;then
					exec dwm\
						>>~/.dwm.log
				fi
			fi

		}

		startEvilWM(){

			if ! which evilwm>/dev/null;then
				echo "EvilWM not found!"
				exit 1
			else
				exec evilwm\
					-fg '#2777ff'\
					--fc magenta\
					--bg black\
					--snap 4\
					--bw 2\
					--mask2 mod4\
					--altmask control+alt\
					--app polybar --dock\
					--numvdesks 6\
					--fn 'IBM 3270'\
						>>~/.evilwm.log
			fi
		}
		startDwm
		#startEvilWM
	}
	startWindowManager
}
startX

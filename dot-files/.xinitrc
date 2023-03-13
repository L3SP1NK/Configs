#!/bin/sh

startX(){
	##############
	## X COLORS ##
	##############

	if [ -e ${HOME}/.Xresources ];then
		xrdb -merge -load ${HOME}/.Xresources&
	fi

	##################
	## SOUND SERVER ##
	##################

	if which pulseaudio>/dev/null;then
		if which pasystray>/dev/null;then
			pasystray&
		fi
	fi

	################
	## DESKTOP BG ##
	################

	setBg(){
		setMoonBg(){
			## Set the background to an image of the current moon phase.
			if which pngphoon feh>/dev/null;then
				stars_num='100' ## Number of stars to display behind the moon.
				res_x=`xrandr|grep '*' | head -n1 | awk '{print $1}'|cut -d "x" -f 1`
				res_y=`xrandr|grep '*' | head -n1 | awk '{print $1}'|cut -d "x" -f 2`
				pngphoon -w ${res_x} -h ${res_y} -x 1 -s ${stars_num} -f -|feh --bg-fill - &
			fi
		}

		setAntFarmBg(){
			xantfarmbin='/opt/xantfarm/xantfarm'
			if [ -e ${xantfarmbin} ];then
				ant_num='9000' ## warning!
				air_color='CornFlowerBlue'
				sand_color='GoldenRod'
				ant_color='SaddleBrown'

				nice -20 ${xantfarmbin} -num ${ant_num} -c 0 -air ${air_color} -sand ${sand_color} -ant ${ant_color}
			fi
		}
		#setAntFarmBg
		setMoonBg
	}
	setBg

	##############
	## KEYBOARD ##
	##############

	kbOpt(){
		setxkbmap fr&
		if which numlockx>/dev/null;then
			numlockx on&
		fi

		if which xcape>/dev/null;then
			mod='Super_L'
			xcape -e "${mod}=Control_L|Escape"&
		fi

		if which sxhkd>/dev/null;then
			if [ -e ${HOME}/.config/sxhkd/sxhkdrc ];then
				sxhkd&
			fi
		fi

		if which xfce4-clipman>/dev/null;then
			if ! pidof xfce4-clipman>/dev/null;then
				xfce4-clipman&
			fi
		fi
	}
	kbOpt

	####################
	## WINDOW MANAGER ##
	####################

	startWm(){
		startDwm(){
			if ! which dwm>/dev/null;then
				echo "DWM not found!"
				exit 1
			fi

			if ! which slstatus>/dev/null;then
				echo "slstatus not found!"
			fi

			#slstatus&
			exec dwm\
				>>~/.dwm.log

		}

		startEvilWM(){

			if ! which evilwm>/dev/null;then
				echo "EvilWM not found!"
				exit 1
			fi

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
		}

		startDwm
		#startEvilWM
	}

	printSysInfo(){
		if which xmessage>/dev/null
			then
 				echo -e "`whoami`\n\n`uname -a`\n\n`cat /proc/cmdline`\n\n"|xmessage -file -&
		fi
	}
	printSysInfo
	startWm
}
startX

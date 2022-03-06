##############################################################
##															##
##	 ██                               ██          ██		##
##	░██                       ██████ ░░          ░██		##
##	░██        █████   ██████░██░░░██ ██ ███████ ░██  ██	##
##	░██       ██░░░██ ██░░░░ ░██  ░██░██░░██░░░██░██ ██		##
##	░██      ░███████░░█████ ░██████ ░██ ░██  ░██░████		##
##	░██      ░██░░░░  ░░░░░██░██░░░  ░██ ░██  ░██░██░██		##
##	░████████░░██████ ██████ ░██     ░██ ███  ░██░██░░██	##
##	░░░░░░░░  ░░░░░░ ░░░░░░  ░░      ░░ ░░░   ░░ ░░  ░░		##
##															##
##############################################################

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## General config and variables. ##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
export PATH=${HOME}/bin:/usr/local/bin:${PATH}:/sbin:/usr/sbin:/${HOME}/.cargo/bin:${HOME}/.local/bin
export ZSH=${HOME}/.oh-my-zsh
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch x86_64"
export UPDATE_ZSH_DAYS=1
export LANG=en_US.UTF-8
export EDITOR=nano
export QT_QPA_PLATFORMTHEME="qt5ct"
export XDG_SESSION_TYPE=x11

CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_MAGIC_FUNCTIONS="true"
COMPLETION_WAITING_DOTS="true"
#ZSH_THEME="random"

##~~~~~~~~~~##
## History. ##
##~~~~~~~~~~##
## History is removed and linked to /dev/null.

##~~~~~~~~~~##
## Plugins. ##
##~~~~~~~~~~##
plugins=(
	zsh-completions
	zsh-syntax-highlighting
	zsh-autosuggestions
	command-not-found
## FZF
## shortcuts:
## 	- Ctrl + T = Paste the path of file or directory found on the command line.
## 	- Ctrl + R = Find history command and paste command on the command line.
## 	- Alt  + C = Go to specific directory.
#	fzf

## History (load it after FZF).
	zsh-navigation-tools
)

## Base zsh script (after plugins).
## "." is like "source" but slightly faster to load.
. ${ZSH}/oh-my-zsh.sh

## Load personal aliases.
[[ -f ~/.alias ]] && . ~/.alias || echo '\e[31m Alias file missing!'

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Syntax highligthing configuration. ##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
. ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[precommand]=fg=green
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow,bold,underline
ZSH_HIGHLIGHT_STYLES[comment]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=cyan
ZSH_HIGHLIGHT_STYLES[named-fd]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[numeric-fd]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=yellow
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=yellow

## Path.
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=cyan
ZSH_HIGHLIGHT_STYLES[path]=fg=grey,underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=grey,underline
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=fg=grey,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold

## Substitution.
ZSH_HIGHLIGHT_STYLES[command-substitution]=cyan
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[process-substitution]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold

## Hyphens.
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta,bold

## Quotes.
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=red,bold

## Brackets.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

## Man/less color.
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

##~~~~~~~~~##
## Prompt. ##
##~~~~~~~~~##
## Colors.
RC="\e[0m"
BOLD="\e[1m"
GREY="\e[37m"
YELLOW="\e[33m"
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
BLUE="\e[34m"
MAGENTA="\e[35m"

## Set prompt color according to the distro.
DISTRO=$(cat /etc/os-release | grep PRETTY | cut -d "=" -f 2 | sed 's/"//g' | awk '{print $1}')
case ${DISTRO} in
	Kali)
		HOSTNAME_COLOR=cyan
		HOSTNAME_COLOR_B=${CYAN}
		;;
	Debian)
		HOSTNAME_COLOR=magenta
		HOSTNAME_COLOR_B=${MAGENTA}
		;;
	*)
		HOSTNAME_COLOR=grey
		HOSTNAME_COLOR_B=${GREY}
		;;
esac

## Change username color if root.
if [[ "${EUID}" -ne 0 ]]
	then
		NAME_COLOR=green
	else
		NAME_COLOR=red
fi

## Left prompt.
## user@host:/dir/ $
## Color based on the distro.
PROMPT='%{$fg_bold[${NAME_COLOR}]%}%n%{$fg_bold[yellow]%}@%{$fg_bold[${HOSTNAME_COLOR}]%}%m%{$reset_color%}:%{$fg_bold[blue]%}%~%{$reset_color%}%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%(!.#.$)%{$reset_color%} '
## Green/red if root.
#PROMPT='%{$fg_bold[${NAME_COLOR}]%}%n@%m:%{$fg_bold[blue]%}%~%{$reset_color%}%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%(!.#.$)%{$reset_color%} '
## Green/red if root + bracket.
#PROMPT='[%{$fg_bold[${NAME_COLOR}]%}%n@%m:%{$fg_bold[blue]%}%~%{$reset_color%}]%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%(!.#.$)%{$reset_color%} '
## Right prompt.
## Time.
#RPROMPT='%{$fg[white]%}%D{%T}%{$reset_color%}'

## Display system information if connected through SSH.
if [[ ${SSH_CONNECTION} ]]
	then
		which neofetch > /dev/null
			if [[ ${?} -eq "0" ]]
				then
					neofetch
				else
					## Show basic info if neofetch is not installed.
					echo -e "${HOSTNAME_COLOR_B}$(cat /etc/os-release | grep --color=never -iE '^name=')"|sed "s/NAME=//g"|sed 's/"//g'
					free -h
			fi
fi

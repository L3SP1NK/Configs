## ~/.bashrc: executed by bash(1) for non-login shells.
## see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
## for examples

## If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## don't put duplicate lines or lines starting with space in the history.
## See bash(1) for more options
HISTCONTROL=ignoreboth

## append to the history file, don't overwrite it
shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

##~~~~~~~~~~##
## History. ##
##~~~~~~~~~~##
## See https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh.
alias history="history 0"
HIST_STAMPS="+%d %b %T"
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=999999999
SAVEHIST=999999999

set BANG_HIST				# Treat the '!' character specially during expansion.
set EXTENDED_HISTORY			# Write the history file in the ":start:elapsed;command" format.
set INC_APPEND_HISTORY		# Write to the history file immediately, not when the shell exits.
set SHARE_HISTORY			# Share history between all sessions.
set HIST_EXPIRE_DUPS_FIRST	# Expire duplicate entries first when trimming history.
set HIST_IGNORE_DUPS			# Don't record an entry that was just recorded again.
set HIST_IGNORE_ALL_DUPS		# Delete old recorded entry if new entry is a duplicate.
set HIST_FIND_NO_DUPS		# Do not display a line previously found.
set HIST_IGNORE_SPACE		# Don't record an entry starting with a space.
set HIST_SAVE_NO_DUPS		# Don't write duplicate entries in the history file.
set HIST_REDUCE_BLANKS		# Remove superfluous blanks before recording entry.
set HIST_VERIFY				# Don't execute immediately upon history expansion.
set HIST_BEEP				# Beep when accessing nonexistent history.
export SAVEHIST=${HISTSIZE}

## Previous config.
#HISTFILE=~/.zsh_history
#HISTSIZE=1000
#SAVEHIST=2000
## Delete duplicates first when HISTFILE size exceeds HISTSIZE.
#set hist_expire_dups_first
## Ignore duplicated commands history list.
#set hist_ignore_dups
## Ignore commands that start with space.
#set hist_ignore_space
## Show command with history expansion to user before running it.
#set hist_verify
## Share command history data.
#set share_history

##~~~~~~~~##
## Alias. ##
##~~~~~~~~##
## Add verbose mode.
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias trash='trash -v'
alias mkdir="mkdir -v"
alias pip="pip -v"
alias pip3="pip3 -v"

## Add color.
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

## Custom.
alias l='ls --time-style="+%d-%b-%y %T" -hAl'
alias netspeed='ethtool eth0 | grep Speed'
alias emoji="cat ~/.emoji | tac"
alias c='ccze -A'
alias stopx='xfce4-session-logout -f -l'
alias cal="calcurse"

## check the window size after each command and, if necessary,
## update the values of LINES and COLUMNS.
shopt -s checkwinsize

## If set, the pattern "**" used in a pathname expansion context will
## match all files and zero or more directories and subdirectories.
##shopt -s globstar

## make less more friendly for non-text input files, see lesspipe(1)
##[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

## set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
##force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	## We have color support; assume it's compliant with Ecma-48
	## (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	## a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [[ ${EUID} -eq "0" ]]
	then
	    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	else
	    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

unset color_prompt force_color_prompt

## If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

## colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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
RESET_COLOR="\e[0m"
BOLD="\e[1m"
GREY="\e[37m"
YELLOW="\e[33m"
GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"


## Alias
[[ -f ~/.alias ]] && . ~/.alias || echo '\e[31m Alias file missing!'
## Display system information if connected through SSH.
if [[ ${SSH_CONNECTION} ]]
	then
		which neofetch > /dev/null
			if [[ ${?} -eq "0" ]]
				then
					neofetch
				else
					if [[ ${DISTRO} == 'Kali GNU/Linux Rolling' ]]
						then
							echo -e "${BOLD}${BLUE}$(cat /etc/os-release | grep PRETTY_NAME | cut -d "=" -f 2 | sed 's/"//g')" ; echo -e "${GREY}${BOLD}$(free -h --si)" ; echo -e "\n\e[33m$(apt list --installed 2>/dev/null| wc -l) packages currently installed"
					elif [[ ${DISTRO} == 'Debian GNU/Linux 11 (bullseye)' ]]
						then
							echo -e "${BOLD}${RED}$(cat /etc/os-release | grep PRETTY_NAME | cut -d "=" -f 2 | sed 's/"//g')" ; echo -e "${GREY}${BOLD}$(free -h --si)" ; echo -e "\n\e[33m$(apt list --installed 2>/dev/null| wc -l) packages currently installed"
						else
							echo -e "${BOLD}$(cat /etc/os-release | grep PRETTY_NAME | cut -d "=" -f 2 | sed 's/"//g')" ; echo -e "${GREY}${BOLD}$(free -h --si)" ; echo -e "\n\e[33m$(apt list --installed 2>/dev/null| wc -l) packages currently installed"
					fi
			fi
fi

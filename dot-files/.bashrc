export PATH="/home/lespink/.local/bin:$PATH"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR=nano
# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=
HISTSIZE=
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=oneline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
	# override default virtualenv indicator in prompt
	VIRTUAL_ENV_DISABLE_PROMPT=1

	if [ "$color_prompt" = yes ]; then
			if [ "${EUID}" -eq '0' ]; then
				PS1="\e[30m\e[1m\${?}\e[30m\e[1m|\e[31m\u@\h\e[30m\e[1m:\e[34m\e[1m\W\e[30m\e[1m \$\e[0m "
				PS1='\[\e[30m\e[1m\]${?}\[\e[30m\e[1m\]|\[\e[31m\]\u@\h\[\e[30m\e[1m\]:\[\e[34m\e[1m\]\W\[\e[30m\e[1m\] $\[\e[0m\] '


					else
				PS1="\e[30m\e[1m\${?}\e[30m\e[1m|\e[32m\u@\h\e[30m\e[1m:\e[34m\e[1m\W\e[30m\e[1m \$\e[0m "
				PS1='\[\e[30m\e[1m\]${?}\[\e[30m\e[1m\]|\[\e[32m\]\u@\h\[\e[30m\e[1m\]:\[\e[34m\e[1m\]\W\[\e[30m\e[1m\] $\[\e[0m\] '

			fi
	else
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	fi
unset color_prompt force_color_prompt
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

#[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions
	export FZF_DEFAULT_OPTS='--color=bg+:#1f1f1f,bg:#0d0d0d,border:#1f1f1f,spinner:#ff0000,hl:#ffffff,fg:#ffffff,header:#719872,info:#15FFBE,pointer:#FF0000,marker:#E17899,fg+:#ffffff,preview-bg:#D9D9D9,prompt:#0099BD,hl+:#FCFF15'

	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias diff='diff --color=auto'
	alias ip='ip --color=auto'

	export LESS_TERMCAP_mb=$'\E[1;31m'	 # begin blink
	export LESS_TERMCAP_md=$'\E[1;36m'	 # begin bold
	export LESS_TERMCAP_me=$'\E[0m'		# reset bold/blink
	export LESS_TERMCAP_so=$'\E[01;33m'	# begin reverse video
	export LESS_TERMCAP_se=$'\E[0m'		# reset reverse video
	export LESS_TERMCAP_us=$'\E[1;32m'	 # begin underline
	export LESS_TERMCAP_ue=$'\E[0m'		# reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

## Load personal aliases.
if [ -e ~/.aliasrc ]; then
	source $HOME/.aliasrc
else
	echo -e '\e[31m Alias file missing!'
fi

if [[ "${SSH_CONNECTION}" || "${TTY}" == "/dev/tty1" ]]; then
	fastfetch
fi

if [ "${MC_SID}" ]; then
	PS1="📂${PS1}"
fi

if [ "${SSH_CONNECTION}" ]; then
	PS1="🛜${PS1}"
fi

edit_files_fzf() {
		local FILE; FILE=$(find -O3 . -maxdepth 9 -type f -o -type l 2>/dev/null|fzf)

		if [[ -n "${FILE}" ]]; then
				if [[ -O "${FILE}" ]]; then
				"${EDITOR}" "${FILE}"
				else
				sudo "${EDITOR}" "${FILE}"
			fi
		fi
}

bind -x '"\ee": edit_files_fzf'
bind -x '"\^el": clear; tree -L1'
bind -x '"\eo":open "$(fzf)"'
bind -x '"\e[1~": clear; cd ~'

if [[ ${TTY} =~ /dev/tty[0-6] ]]; then
		while true; do
				reset
				echo "Press [ENTER] to start the X server..."
				read&&nice -19 startx
		done
fi


#if command -v zoxide>/dev/null; then
#		alias cd='z'
#		eval "$(zoxide init zsh)"
#fi
#complete -cf doas

#eval "$(oh-my-posh init bash --config ~/.omp.yaml)"
#
#. "$HOME/.local/bin/env"
#. "$HOME/.cargo/env"

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples
setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
#setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
DISABLE_MAGIC_FUNCTIONS=true
#WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

## enable completion features
#autoload -Uz compinit
#compinit -d ~/.cache/zcompdump
#zstyle ':completion:*:*:*:*:*' menu1 select
##zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete
##zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
#zstyle ':completion:*' rehash true
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
#zstyle ':completion:*' verbose true
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE="${HOME}/.zsh_history"
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
#setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data
HISTFILESIZE=
HISTSIZE=
# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
NEWLINE_BEFORE_PROMPT=no
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}


plugins=(
	zoxide
    fzf
	zsh-syntax-highlighting
	zsh-autosuggestions
	#zsh-navigation-tools
	zsh-completions
	command-not-found
	man
	colored-man-pages
)

OMZ="${HOME}/.oh-my-zsh"
## Base zsh script (load it after plugins).
source ${OMZ}/oh-my-zsh.sh
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Syntax highligthing configuration. ##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
[[ -f ${OMZ}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ${OMZ}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[comment]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=cyan
ZSH_HIGHLIGHT_STYLES[named-fd]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[numeric-fd]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=yellow
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=yellow
## Path.
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=cyan
ZSH_HIGHLIGHT_STYLES[path]=fg=cyan
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=cyan
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=fg=cyan
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

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\e[1;32m'     # begin blink
    export LESS_TERMCAP_md=$'\e[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\e[01;34m'    # begin reverse video
    export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\e[1;34m'     # begin underline
    export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

## Load personal aliases.
aliasrc="${HOME}/.aliasrc"
if [ -e "${aliasrc}" ]; then
	source "${aliasrc}"
else
	echo -e '\n\e[31m Alias file missing!\n'
fi

## red username if root
if [[ "${EUID}" -ne '0' ]]; then
	PROMPT='%B%F{black}%(?..%?|)%B%F{green}%n@%m%F{black}:%F{blue}%c%F{black} %#%b%f '
else
	PROMPT='%B%F{black}%(?..%?|)%B%F{red}%n@%m%F{black}:%F{blue}%c%F{black} %#%b%f '
fi

if [[ "${SSH_CONNECTION}" || "${TTY}" == "/dev/tty1" ]]; then
    neofetch
fi

if [[ "${MC_SID}" ]]; then
    PROMPT="📂 ${PROMPT}"
fi

if [[ "${SSH_CONNECTION}" ]]; then
    PROMPT="🛜 ${PROMPT}"
fi


# load cargo env
CARGO_DIR="${HOME}/.cargo/bin"
if [[ -d ${CARGO_DIR} ]]; then
	PATH="${PATH}:${CARGO_DIR}"
fi

# configure key keybindings
bindkey ' ' magic-space                           	# do history expansion on space
bindkey '^U' backward-kill-line                   	# ctrl + U
bindkey '^[[3;5~' kill-word                       	# ctrl + Supr
bindkey '^[[3~' delete-char                       	# delete
bindkey '^[[1;5C' forward-word                    	# ctrl + ->
bindkey '^[[1;5D' backward-word                   	# ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    	# page up
bindkey '^[[6~' end-of-buffer-or-history          	# page down
bindkey '^[[H' beginning-of-line                 	# home
bindkey '^[[F' end-of-line                        	# end
bindkey '^[[Z' undo                               	# shift + tab undo last action

EDITOR='nano'

edit_files_fzf() {
	local FILE; FILE=$(find . -maxdepth 9 -type f -o -type l|fzf)

	if [[ -n "${FILE}" ]]; then
		if [[ -O "${FILE}" ]]; then
	        "${EDITOR}" "${FILE}"
		else
	        sudo "${EDITOR}" "${FILE}"
	    fi
	fi
}

bindkey -s '^[e' 'edit_files_fzf\n' 				# alt + E edit a file.
bindkey -s '^[l' ';clear;tree -L 1\n'				# List files.
bindkey '^Z' undo									# undo last action
bindkey -s '^[^[[1~' ';clear;cd ~\n'					# return to home
complete -cf doas

if [[ "${TTY}" =~ /dev/tty[0-6] && "${EUID}" -ne '0' ]]; then
	while true; do
		reset
		echo "Press [ENTER] to start the X server..."
		read&&nice -19 startx
	done
fi


if command -v zoxide>/dev/null; then
	alias cd='z'
	eval "$(zoxide init zsh)"
fi

eval "$(oh-my-posh init zsh --config ~/.omp.yaml)"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac



# Append to the history file, don't overwrite it
shopt -s histappend

# Don't put duplicate lines into the history
export HISTCONTROL=ignoredups

# Increase history size from 500 to 1000 command
export HISTSIZE=1000
export HISTFILESIZE=2000



# Check the window size after each command and update LINES and COLUMNS
shopt -s checkwinsize



# The pattern "**" used in a pathname expansion context will match all files and
# zero or more directories and subdirectories
shopt -s globstar



# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi



# Set a fancy prompt (non-colour, unless we know we "want" colour)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a coloured prompt, if the terminal has the capability
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have colour support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such a
        # case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # Colours
    yellow=$(tput setaf 3)
    green=$(tput setaf 2)
    blue=$(tput setaf 104)
    bold=$(tput bold)
    reset=$(tput sgr0)

    PS1="\n${debian_chroot:+($debian_chroot)}\[\$yellow\]\u\[\$reset\]@\[\$green\]\h\[\$reset\]: \[\$blue\$bold\]\w\[\$reset\]\n \$ "
else
    PS1='\n${debian_chroot:+($debian_chroot)}\u@\h: \w\n \$ '
fi

unset color_prompt force_color_prompt



# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac



# Enable colour support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls="ls --color=auto"
    alias grep="grep --color=auto"
fi

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'



# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



# Enable programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile sources
# /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi



# Set LS_COLORS environment by Deepin
if [[ ("$TERM" = *256color || "$TERM" = screen* || "$TERM" = xterm* ) && -f /etc/lscolor-256color ]]; then
    eval $(dircolors -b /etc/lscolor-256color)
else
    eval $(dircolors)
fi



# Make less more friendly for non-text input files
if [ -x /usr/bin/lesspipe ]; then
    eval $(lesspipe)
fi



export VISUAL=nano
export EDITOR=nano



# Add Composer global vendor to PATH
if [ -d ~/.config/composer/vendor/bin ]; then
    export PATH=~/.config/composer/vendor/bin:$PATH
fi

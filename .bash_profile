
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
if [ -d "/Library/Frameworks/Python.framework/Versions/3.4/bin" ]; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
    export PATH
fi

alias ls='ls -G'
alias ll='ls -la'

alias grep='grep --color=auto'

# Include better completion for bash
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ $TERM == "xterm-256color" ]; then
    colour=true
fi

if [ "$colour" == true ]; then
    export PS1="\`if [ \$? == 0 ]; then echo \"\[\033[1;32m\]:D\[\033[00m\]\"; else echo \"\[\033[0;31m\]:O\[\033[00m\]\" ; fi\` \u@\h: \[\033[0;32m\]\W\[\033[00m\]\$ "
else
    export PS1="\`if [ \$? == 0 ]; then echo :D; else echo \":O\" ; fi\` \u@\h: \W\$ "
fi
#export PS1="\u@\h: \[\033[0;32m\]\W\[\033[00m\]\$ "


if [ -d "/usr/local/heroku/bin" ]; then
    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"
fi

if [ -d "/Library/PostgreSQL/9.3/bin" ]; then
    ### Add postgress to the toolchain
    export PATH="/Library/PostgreSQL/9.3/bin:$PATH"
fi

# Functions for burning disks to storage cards
alias lsbd="diskutil list"
umbd() { diskutil umountDisk "/dev/$1"; }
burn() { pv $1 | sudo dd of="/dev/r$2" bs="1m" ;}


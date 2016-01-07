# bash rc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Function to run upon exit of shell.
function _exit()
{
    printf "${BRed}Au revoir, monsieur${NC}\n"
}
trap _exit EXIT


#-----------------
# Command prompt look and feel
#-----------------
if [ $TERM == "xterm-256color" ]; then
    colour=true
fi

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

function git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

#function error_smiley() {
#    if [ $? == 0 ]; then
#        printf ":D \xe2\x9c\x93\x0a";
#    else
#        printf ":O \xe2\x9c\x97\x0a";
#    fi
#}

function error_smiley() {
    if [ $? == 0 ]; then
        printf "\xe2\x9c\x93\x0a";
    else
        printf "\xe2\x9c\x97\x0a";
    fi
}

function error_smiley_colour() {
    local ret_code=$?
    if [ $ret_code == 0 ]; then
        printf "${BGreen}";
    else
        printf "${ALERT}";
    fi
    return $ret_code
}

trap _exit EXIT
if [ "$colour" == true ]; then
    export PS1="\[\$(error_smiley_colour)\]\$(error_smiley)\[${NC}\] \u@\h: \[${Green}\]\W\[${NC}\] \[${Purple}\]\$(git_branch)\[${NC}\]\$ "
else
    export PS1="\$(error_smiley) \u@\h: \W \$(git_branch)\$ "
fi


#------------------
# Aliases
#------------------
# System aliases
alias ls='ls -G'
alias ll='ls -la'

alias grep='grep --color=auto'

# Functions for burning disks to storage cards
alias lsbd="diskutil list"
umbd() { diskutil umountDisk "/dev/$1"; }
burn() { pv $1 | sudo dd of="/dev/r$2" bs="1m" ;}

function is_installed()
{
    command -v $1 > /dev/null 2>&1
    local ret_val=$?
    local err_str="Command $1 is not in PATH"
    if [ $ret_val -ne 0 ]; then
        if [ "$colour" == true ]; then
            err_str=${ALERT}$err_str${NC}
        fi
        printf "$err_str\n" 1>&2
    fi
    return $ret_val
}

function ct() {
    local ctags_dir="${HOME}/ctags"

    is_installed "ctags"
    local ctags_exists=$?

    if [ $ctags_exists -eq 0 ]; then
        ctags_cmd="ctags -R -f \"$ctags_dir\" --exclude=.git --exclude=*.js \"$1\""
        printf "${BWhite}Executing: ${On_Green}$ctags_cmd${NC}\n"
        eval "$ctags_cmd"
    fi
}

# History related settings
shopt -s histappend
HISTCONTROL=ignoreboth

# Bash window
shopt -qs checkwinsize
shopt -qs hostcomplete

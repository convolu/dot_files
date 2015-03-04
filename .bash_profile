# bash_profile file

function exists()
{
    command -v "$1" > /dev/null 2>&1
}

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
if [ -d "/Library/Frameworks/Python.framework/Versions/3.4/bin" ]; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
    export PATH
fi


# Environment Variable Preferences
exists vim && export EDITOR=vim
exists less && export PAGER=less


# Include better completion for bash
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

exists brew && source `brew --repository`/Library/Contributions/brew_bash_completion.sh

if [ -d "/usr/local/heroku/bin" ]; then
    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"
fi

if [ -d "/Library/PostgreSQL/9.3/bin" ]; then
    ### Add postgress to the toolchain
    export PATH="/Library/PostgreSQL/9.3/bin:$PATH"
fi


if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

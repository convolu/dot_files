# bash_profile file

function exists()
{
    command -v "$1" > /dev/null 2>&1
}


# Environment Variable Preferences
exists vim && export EDITOR=vim
exists less && export PAGER=less


# Include better completion for bash
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -d "/usr/local/heroku/bin" ]; then
    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:${PATH}"
fi

if [ -d "/Library/PostgreSQL/9.3/bin" ]; then
    ### Add postgress to the toolchain
    export PATH="/Library/PostgreSQL/9.3/bin:${PATH}"
fi

if [ -d "${HOME}/Library/Android/sdk/platform-tools" ]; then
    ### Add android tools to the Path
    export PATH="${HOME}/Library/Android/sdk/platform-tools:${PATH}"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Setting PATH for Python 3.4
if [ -d "/Library/Frameworks/Python.framework/Versions/3.4/bin" ]; then
    export PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
fi

# Setting PATH for Python 3.5
if [ -d "/Library/Frameworks/Python.framework/Versions/3.5/bin" ]; then
    export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
fi

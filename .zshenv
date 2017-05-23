#
#  .zshenv
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export PATH=/usr/local:$PATH
export PATH=/usr/local/bin:${PATH}


export PATH=$HOME/local/node/bin:$PATH
export PATH=/usr/local/lib/node_modules:$PATH
if [ -d ${HOME}/node_modules/.bin ]; then
    export PATH=${PATH}:${HOME}/node_modules/.bin
fi

export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH=/usr/local/ruby/bin:$PATH
export PATH=$HOME/.rbenv/shims:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/versions/anaconda3-4.3.1/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

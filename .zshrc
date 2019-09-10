#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Arch
# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi
# alias upt=yay -Suy && yay -Scc

export EDITOR="nvim"
alias vi=nvim
alias sudovi="sudo -E nvim"

# Urxvt
# export TERM=xterm-256color

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Source fzf
# Fedora
# source "/usr/share/fzf/shell/key-bindings.zsh"
# Arch
source "/usr/share/fzf/completion.zsh"  
source "/usr/share/fzf/key-bindings.zsh"
# Ubuntu
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# make history search unique
# see this patch: https://github.com/junegunn/fzf/pull/1363/commits/6d31209fc9bc8b3dba4589f9ac3ed7b9c8821f05

# Go
export GOROOT=/usr/local/go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Ruby
# export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin

# Npm
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# # place this after nvm initialization!
# autoload -U add-zsh-hook
# load-nvmrc() {
#  local node_version="$(nvm version)"
#  local nvmrc_path="$(nvm_find_nvmrc)"

#  if [ -n "$nvmrc_path" ]; then
#    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#    if [ "$nvmrc_node_version" = "N/A" ]; then
#      nvm install
#    elif [ "$nvmrc_node_version" != "$node_version" ]; then
#      nvm use
#    fi
#  elif [ "$node_version" != "$(nvm version default)" ]; then
#    echo "Reverting to nvm default version"
#    nvm use default
#  fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

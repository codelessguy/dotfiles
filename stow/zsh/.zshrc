##############
# Zsh config #
##############
# History
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Color
autoload -U colors && colors
export PS1="%{$fg[red]%}[%n@%m %{$reset_color%}%2d%{$fg[red]%}]%# %{$reset_color%}"

#################
# Other configs #
#################
# alias upt="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt clean"
alias upt="sudo dnf update && sudo dnf autoremove"

export EDITOR="nvim"
alias vi=nvim
alias sudovi="sudo -E nvim"
alias zic="cd ~/data/Music && cmus"

export TERM=xterm

# export CC=/usr/bin/clang
# export CXX=/usr/bin/clang++

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# FZF
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
# make history search unique
# see this patch: https://github.com/junegunn/fzf/pull/1363/commits/6d31209fc9bc8b3dba4589f9ac3ed7b9c8821f05

# Go
# export GOROOT=/usr/local/go
export GOPATH=$HOME/.go
# export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# Npm
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export NODEROOT=/usr/local/node-v13.3.0-linux-x64
export PATH="$NODEROOT/bin:$PATH"

#export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}


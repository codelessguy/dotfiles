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
# export PS1="%{$fg[red]%}[%n@%m %{$reset_color%}%2d%{$fg[red]%}]%# %{$reset_color%}"
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
comp_options+=(globdots)  # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

#------------------
# Default Settings
#------------------

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt walters

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# show vcs info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT' ${vcs_info_msg_0_}'

# alias
alias ls="ls -h --color=auto"
alias ll="ls -l"
alias la="ls -la"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias open="xdg-open"

#-----------------------------------
# thirdparty software configuration
#-----------------------------------

# tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color"


#--------------------
# version management
#--------------------

# gvm
# [[ -s "/home/jingle/.gvm/scripts/gvm" ]] && source "/home/jingle/.gvm/scripts/gvm"

# golang
export GOPATH=$HOME/.golang
export PATH=$HOME/.golang:$PATH

# rbenv
# export PATH=$"$PATH:$HOME/.rbenv/bin"
# eval "$(rbenv init -)"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PATH:$PYENV_ROOT/bin:"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

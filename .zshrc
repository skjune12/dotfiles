#------------------
# Default Settings
#------------------

# Set up the prompt

autoload -Uz promptinit
autoload -Uz colors
promptinit

case ${UID} in
0)
    PROMPT='%n@%U%m%u# '
    RPROMPT='%F{green}%d%f'
    ;;
*)
    PROMPT='%n@%U%m%u> '
    RPROMPT='%F{green}%d%f'
    ;;
esac

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
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
function _vcs_precmd () {
    LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _vcs_precmd

setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

case "${OSTYPE}" in
darwin*)
    export LSCOLORS=gxfxcxdxbxegexabagacad
    alias ls="ls -hG"
    alias ll="ls -lG"
    alias la="ls -laG"
    ;;
linux*)
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
;;
esac

#-----------------------------------
# thirdparty software configuration
#-----------------------------------

# tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color"
export PATH=$HOME/.tmux/bin:$PATH

#--------------------
# version management
#--------------------

# golang
export GOPATH=$HOME/.golang
export PATH=$PATH:$HOME/.golang/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin:"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin brew"

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# peco + ghq
setopt hist_ignore_all_dups

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

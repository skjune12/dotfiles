# highlighting ls
autoload colors
colors

# completion
autoload -U compinit
compinit
zstyle ':completion:*' list-colors "${LS_COLORS}"

# keybind
bindkey -e

# history
HISTFILE=~/.zsh_history
HISTSIZE=999
SAVEHIST=999
setopt hist_ignore_dups
setopt share_history

# cd
setopt auto_cd
setopt auto_pushd

# prompt
case ${USERNAME} in
    'root')
        # when user is root
        PROMPT="%B[%!] %F{red}%n@%m%f%b: %~
# "
        ;;
    *)
        # when user is general user
        PROMPT="%B[%!] %F{green}%n@%m%f%b: %~
$ "
;;
esac

# git
autoload -Uz vcs_info
RPROMPT="%1(v|%B%F{yellow}%1v%f%b|)"

zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color"

# neovim
export XDG_CONFIG_HOME=~/.config


#-------
# alias
#-------

# color setting
alias ls="ls -h --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias ll="ls -l"
alias la="ls -lah"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

if [ "$(uname)" = "Linux" ]; then
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
fi

#--------------------
# version management
#--------------------

# gvm
[[ -s "/home/jingle/.gvm/scripts/gvm" ]] && source "/home/jingle/.gvm/scripts/gvm"

# golang
export GOPATH=$HOME/.golang
export PATH=$HOME/.golang:$PATH

# rbenv
export PATH=$"$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin:"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# echo
echo "(*'-') < Hello, `whoami`"

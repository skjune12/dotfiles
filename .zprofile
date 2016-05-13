#--------------------
# general setting
#--------------------

# golang
export GOPATH=$HOME/.golang/third_party:$HOME/.golang/my_project
export PATH=$HOME/.golang/third_party/bin:$HOME/.golang/my_project/bin:$PATH

# rbenv
export PATH=$"$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin:"
eval "$(pyenv init -)"

# Mecab
# export MECAB_PATH="/usr/lib/libmecab.so.2"

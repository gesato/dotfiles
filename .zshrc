# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme: look in ~/.oh-my-zsh/themes/
ZSH_THEME="gianu"

# stamp shown in the history command output.
HIST_STAMPS="mm/dd/yyyy"

# plugins
plugins=(bundler ruby rails)

# cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

# execute oh-my-zsh
source $ZSH/oh-my-zsh.sh

# zsh option
setopt nonomatch

# alias
alias g='hub'
alias -g A='| ag'
alias -g G='| grep'
alias -g L='| less'

# vim
alias vim='env LANG=ja_JP.UTF-8 reattach-to-user-namespace /usr/local/bin/vim "$@"'

#################
# peco
#################

alias lscd='cd `find . -maxdepth 1 -type d | sed -e "s;\./;;" | peco --prompt "CHANGE DIRECTORY PATH>"`'
alias pim='vim `find . -name "*" | peco --prompt "VIM OPEN FILE>"`'
alias gim='vim `git ls-files | peco --prompt "VIM OPEN FILE>"`'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'


# history
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
      eval $tac | \
      peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# search directory
function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^@' peco-cdr


# git add
function peco-select-git-add() {
  local SELECTED_FILE_TO_ADD="$(git status --porcelain | \
    peco --query "$LBUFFER" | \
    awk -F ' ' '{print $NF}')"
  if [ -n "$SELECTED_FILE_TO_ADD" ]; then
    BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
    CURSOR=$#BUFFER
  fi
  zle accept-line
}
zle -N peco-select-git-add
bindkey "^g^a" peco-select-git-add


# git branch
function peco-git-recent-branches () {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
    perl -pne 's{^refs/heads/}{}' | \
    peco)
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-git-recent-branches
bindkey "^g^b" peco-git-recent-branches

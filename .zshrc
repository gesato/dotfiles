# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme: look in ~/.oh-my-zsh/themes/
ZSH_THEME="gianu"

# stamp shown in the history command output.
HIST_STAMPS="mm/dd/yyyy"

# plugins
plugins=(bundler ruby rails)

# execute oh-my-zsh
source $ZSH/oh-my-zsh.sh

# zsh option
setopt nonomatch

# alias
alias g='hub'
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

function is_frontmost {
  iterm_is_frontmost_application=$(osascript -e 'tell application "iTerm" to get frontmost')
  frontmost_in_iterm=$(osascript -e 'tell application "iTerm" to tell the current terminal to tell the current session to get id')
  this_terminal=`tty`

  frontmost="true"
  if [[ $iterm_is_frontmost_application == "true" ]]; then
    if [[ $frontmost_in_iterm == $this_terminal ]]; then
      frontmost=
    fi
  fi
}

function gemcd {
  cd `dirname \`gem which $1\``
}

function ghistory
{
  git grep $1 $(git rev-list --all)
}

export BREW=/usr/local/bin/brew
export BREW_HOME=`$BREW --prefix`
export CABAL_HOME=$HOME/.cabal
export PATH=./bin:$CABAL_HOME/bin:$BREW_HOME/bin:$BREW_HOME/sbin:$HOME:$PATH:$HOME/bin:/usr/local/share/npm/bin:$GOPATH/bin
export EDITOR=/usr/local/bin/vim
export VISUAL=$EDITOR
export CDPATH=.:~:~/Development
export GOPATH=$HOME/Development/go
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_OPTS="-Xmx4096m -Xss2048k"
export TERM=xterm-256color

alias :q="exit"
alias :e="$EDITOR"
alias rerc='source ~/.bash_profile'
alias rr='export RUBIES=(/usr/local/rubies/*)'
alias mvim='mvim --servername VIM --remote-tab-silent'
alias be='bundle exec'
alias remigrate='rake db:migrate && rake db:migrate:redo && rake db:schema:dump db:test:prepare'
alias dnsip='dig myip.opendns.com @resolver1.opendns.com +short'
alias psg='ps aux | ag'
alias ln='ln -v'
alias servedir='ruby -run -e httpd . -p 9090'
alias listening='lsof -iTCP -sTCP:LISTEN -P -n'

# shortcut git
function g {
if [[ $# > 0 ]]; then
  git $@
else
  git st
fi
}

set -o vi

eval `ssh-agent`
ssh-add 2> /dev/null
source /usr/local/opt/asdf/asdf.sh

# Tab-completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
if [ -f $HOME/.bash/completions.bash ]; then
  . $HOME/.bash/completions.bash
fi

# Configuration in well-named files
for bashfile in $HOME/.bash/*.bash; do
  source $bashfile
done

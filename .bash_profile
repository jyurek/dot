function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo '✏ '
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function latest_command {
  history | tail -n 1 | sed 's/[0-9 ]*\(.*\)/\1/'
}

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

function growl_latest_command {
  priority="Normal"
  if [[ $1 != 0 ]]; then
    priority="Emergency"
  fi

  latest_command | growlnotify -p $priority -n "Command Prompt $priority" `pwd` 1>/dev/null 2>&1
}

function prompt_command_function
{
  last_result=$?
  timer_stop
  # growl_latest_command $last_result

  last_result="\[\e[33m\]$last_result\[\e[0m\]"
  titlebar_last_command="\[\e]2;$(latest_command)\a\]"

  git_branch=$(parse_git_branch)
  git_dirty=$(parse_git_dirty)

  git_dirty=${git_dirty:+" \[\e[31m\]$git_dirty\[\e[0m\]"}
  git_branch=${git_branch:+" (\[\e[35m\]${git_branch}\[\e[0m\]${git_dirty})"}

  # current_ruby=$(basename ${RUBY_ROOT:-none})
  current_ruby=$(chruby | ag \\\* | cut -d" " -f 3)

  PS1="$last_result \[\e[32m\]${timer_show}s\[\e[0m\] \[\e[33m\]$current_ruby\[\e[0m\] \[\e[32m\]\w\[\e[0m\]$git_branch \$ "
  # PS1="$last_result \[\e[32m\]${timer_show}s\[\e[0m\] \[\e[32m\]\w\[\e[0m\]$git_branch \$ "
}

function gemcd {
  cd `dirname \`gem which $1\``
}

function ghistory
{
  git grep $1 $(git rev-list --all)
}

export PROMPT_COMMAND=prompt_command_function

export BREW=/usr/local/bin/brew
export BREW_HOME=`$BREW --prefix`
export CABAL_HOME=$HOME/.cabal
export PATH=./bin:$CABAL_HOME/bin:$BREW_HOME/bin:$BREW_HOME/sbin:$HOME:$PATH:$HOME/.dotfiles/bin:$HOME/bin:/usr/local/share/npm/bin:$GOPATH/bin
export EDITOR=/usr/local/bin/vim
export VISUAL=$EDITOR
export CDPATH=.:~:~/Development
export GOPATH=$HOME/Development/go
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_OPTS="-Xmx4096m -Xss2048k"

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

export AWS_ACCOUNT=jyurek
function aws_account {
  if [ -f $HOME/.aws/$1 ]; then
    source $HOME/.aws/$1
    export AWS_ACCOUNT=$1
  else
    echo "No AWS Credentials for $1"
  fi
}
aws_account $AWS_ACCOUNT

# Tab-completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f $HOME/.bash/completions.bash ]; then
  . $HOME/.bash/completions.bash
fi

complete -C aws_completer aws

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

for bashfile in $HOME/.bash/*.bash; do
  source $bashfile
done

# For 1pass
export ONEPASSWORD_KEYCHAIN=$HOME/Documents/Dropbox\ \(Personal\)/1Password/1Password.agilekeychain

export HOMEBREW_GITHUB_API_TOKEN=6d06b95ef776dcd0cb2be1346152bb9f10d8870e

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_COMPLETION_TRIGGER='``'
export GEM_HOME=

source /usr/local/opt/chruby/share/chruby/chruby.sh

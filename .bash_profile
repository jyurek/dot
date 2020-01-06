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

export BREW=brew
export BREW_HOME=`$BREW --prefix`
export PATH=./bin:/usr/local/opt/mongodb@3.2/bin:$BREW_HOME/bin:$BREW_HOME/sbin:$PATH:$HOME/bin
export EDITOR=/usr/local/bin/vim
export VISUAL=$EDITOR
export CDPATH=.:~:~/Development
export TERM=xterm-256color
export TERM_ITALICS=true

alias :q="exit"
alias :e="$EDITOR"
alias rerc='source ~/.bash_profile'
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

# Tab-completions
if [ -r $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
  . $(brew --prefix)/etc/profile.d/bash_completion.sh
fi
if [ -r $HOME/.bash/completions.bash ]; then
  . $HOME/.bash/completions.bash
fi

# Configuration in well-named files
for bashfile in $HOME/.bash/*.bash; do
  source $bashfile
done

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# BEGIN ANSIBLE MANAGED BLOCK
XCODE="$(xcode-select -p 2>/dev/null || echo /Applications/Xcode.app/Contents/Developer)"
JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"; export JAVA_HOME
PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/Library/Python/3.7/bin:${HOME}/Library/Python/2.7/bin:${JAVA_HOME}/bin:/usr/local/gnu/bin:/usr/local/bin:/usr/local/sbin:${PATH}"; export PATH
MANPATH="/usr/local/gnu/man:/usr/local/share/man:/usr/share/man:${XCODE}/Toolchains/XcodeDefault.xctoolchain/usr/share/man:${XCODE}/usr/share/man"; export MANPATH
HOMEBREW_CASK_OPTS="--appdir=/Applications"; export HOMEBREW_CASK_OPTS
HOMEBREW_NO_ENV_FILTERING=1; export HOMEBREW_NO_ENV_FILTERING
HOMEBREW_NO_AUTO_UPDATE=1; export HOMEBREW_NO_AUTO_UPDATE
HOMEBREW_NO_UPDATE_CLEANUP=1; export HOMEBREW_NO_UPDATE_CLEANUP
# END ANSIBLE MANAGED BLOCK

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

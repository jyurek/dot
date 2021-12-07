export RUBIES=/opt/rubies
source $BREW_HOME/opt/chruby/share/chruby/chruby.sh
chruby `cat ~/.ruby-version`

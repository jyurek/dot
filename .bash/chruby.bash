source /usr/local/opt/chruby/share/chruby/chruby.sh
RUBIES+=(/usr/local/rubies/*)
chruby $(cat $HOME/.ruby)

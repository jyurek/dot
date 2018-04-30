export V2_HOME=$HOME/Development/sermo
export WORKING_COPY=true
export ENABLE_JASMINE=true
export SERMO_SETTINGS_PATH=$V2_HOME/lib/rails_deploy/config/settings.yml
export LOCALHOST_DOMAIN="http://`hostname`"
export DEV_ASSET_HOST="$LOCALHOST_DOMAIN:81"
export BUILD_TARGET="/tmp/builds"
export EMAIL_OVERRIDE="jyurek@thoughtbot.com"
export EDITOR=vim

alias all_apps=$HOME/Development/sermo/lib/rails_deploy/bin/local/all_apps
alias reload_passenger=$HOME/Development/sermo/lib/rails_deploy/bin/local/reload_passenger

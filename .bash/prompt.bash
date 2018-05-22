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

function prompt_command_function
{
  last_result=$?
  timer_stop

  last_result="\[\e[33m\]$last_result\[\e[0m\]"
  titlebar_last_command="\[\e]2;$(latest_command)\a\]"

  git_branch=$(parse_git_branch)
  git_dirty=$(parse_git_dirty)

  git_dirty=${git_dirty:+" \[\e[31m\]$git_dirty\[\e[0m\]"}
  git_branch=${git_branch:+" (\[\e[35m\]${git_branch}\[\e[0m\]${git_dirty})"}

  current_ruby=$(chruby | ag \\\* | cut -d" " -f 3)

  PS1="$last_result \[\e[32m\]${timer_show}s\[\e[0m\] \[\e[33m\]$current_ruby\[\e[0m\] \[\e[32m\]\w\[\e[0m\]$git_branch \$ "
}

export PROMPT_COMMAND=prompt_command_function

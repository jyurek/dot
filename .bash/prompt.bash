function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

function parse_git_dirty {
  # [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo '✏ '
  $(git diff-index --quiet HEAD 2>/dev/null) && echo -n '' || echo -n '✏ '
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function parse_dot_dirty {
  $(dot diff-index --quiet HEAD 2>/dev/null) && echo -n '34m' || echo -n '35m'
}

function parse_dot_branch {
  dot branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
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
  dot_dirty=$(parse_dot_dirty)
  dot_branch=$(parse_dot_branch)

  current_ruby=
  type chruby > /dev/null 2>&1 && current_ruby=$(chruby | ag \\\* | cut -d" " -f 3)
  # current_ruby=$(cat ~/.tool-versions | ag ruby | cut -d" " -f 2)

  PS1="$last_result \[\e[32m\]${timer_show}s\[\e[0m\] \[\e[${dot_dirty}\]${dot_branch}\[\e[0m\] \[\e[33m\]$current_ruby\[\e[0m\] \[\e[32m\]\w\[\e[0m\]$git_branch \$ "
}

export PROMPT_COMMAND=prompt_command_function

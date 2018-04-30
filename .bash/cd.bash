function cd {
  builtin cd $*
  if [[ -f .ruby-version ]]; then
    chruby $(cat .ruby-version)
  else
    gemfile_version=$(grep '^ruby ".*"' Gemfile 2>/dev/null | cut -d'"' -f 2)
    if [[ -n $gemfile_version ]]; then
      chruby $gemfile_version
    fi
  fi
}

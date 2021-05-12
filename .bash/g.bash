# shortcut git
function g {
if [[ $# > 0 ]]; then
  git $@
else
  git st
fi
}

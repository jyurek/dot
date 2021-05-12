export AWS_ACCOUNT=jyurek
function aws_account {
  if [ -f $HOME/.aws/$1 ]; then
    source $HOME/.aws/$1
    export AWS_ACCOUNT=$1
  else
    echo "No AWS Credentials for $1"
  fi
}

# aws_account $AWS_ACCOUNT

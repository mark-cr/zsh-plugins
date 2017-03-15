# Docker environment switcher
denv () {
  # No environment argument present
  if [ -z "$@" ]; then
    if [ -z "$DOCKER_ENV_NAME" ]; then
      # No environment set, assuming & forcing localhost
      $(cat ~/.docker/.env-export)
      DOCKER_ENV_NAME=localhost
    fi
    echo "Current Docker environment: \"$DOCKER_ENV_NAME\""
  
  # "localhost" environment 
  elif [ "$@" = "localhost" ]; then
    $(cat ~/.docker/.env-export)
    DOCKER_ENV_NAME=localhost
    echo "Current Docker environment: \"localhost\""
  
  # Other environment declared: perform lookup.
  else
    if [ -f ~/.docker/remotes/"$@"/.env-export ]; then
      $(cat ~/.docker/remotes/"$@"/.env-export)
      DOCKER_ENV_NAME=$@
      echo "Current Docker environment: \"$DOCKER_ENV_NAME\""
    else
      echo "Unknown Docker environment: \"$@\""
    fi
  fi
}

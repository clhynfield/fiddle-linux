#!/usr/bin/env bash

set -x

rando() {
  local length=${1:-5}

  local sha=$(echo "$(date +%Y%m%d%H%M%S.%N)" | shasum)
  echo "$sha" | awk '{print substr($1,1,'$length')}'
}

ssh_auth_setup_args() {
  if test -n "$SSH_AUTH_SOCK"; then
    echo "--volume $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) --env SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
  fi
}

container_name_args=${1:+--name "$1"}

exec docker run \
    $container_name_args \
    --rm \
    --volume ~/workspace:/workspace \
    --tty --interactive \
    $(ssh_auth_setup_args) \
    clhynfield/fiddle-linux


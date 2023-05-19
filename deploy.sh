#!/bin/bash

set -eu

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function usage () {
  echo $0 "<node>" [playbook]
  echo
  echo $0 "desktop"
  echo $0 "laptop"
}


my-ansible-playbook() {
  local playbook=$1
  local limit=$2

  if [ -z "${playbook}" ]; then
      echo "No playbook supplied"
      return
  fi

  docker run -ti --rm \
    -v $(pwd):/work/ \
    ${ANSIBLE_GALAXY_CONTAINER_IMAGE}

  docker run -ti --rm \
    -v $(pwd)/:/work/ \
    -v $HOME/.ssh:/home/user/.ssh:ro \
    --network=host \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    --security-opt apparmor:unconfined \
    -e ANSIBLE_HOST_KEY_CHECKING=False \
    -e LIMIT=${LIMIT} \
    -e PLAYBOOK=${playbook} \
    ${ANSIBLE_PLAYBOOK_CONTAINER_IMAGE}

}


# mount vault if not mounted already

#LIMIT="--limit=$1"
LIMIT=${1:-all}
PLAYBOOK=${2:-main}

LIMIT="--limit=$LIMIT"
#echo \$LIMIT: $LIMIT
#echo \$PLAYBOOK: $PLAYBOOK


if [[ $# -eq 0 ]]; then
  usage
elif [[ $# -gt 2 ]]; then
  usage
else
  cd ${DIR}/container
  source set-env.sh
  docker build -f Containerfile -t $ANSIBLE_CONTAINER_IMAGE .
  docker build -f Containerfile.ansible-galaxy -t $ANSIBLE_GALAXY_CONTAINER_IMAGE .
  docker build -f Containerfile.ansible-playbook -t $ANSIBLE_PLAYBOOK_CONTAINER_IMAGE .

  cd ${DIR}

  my-ansible-playbook $PLAYBOOK.yaml $LIMIT

fi


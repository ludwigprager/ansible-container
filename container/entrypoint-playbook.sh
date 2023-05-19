#!/bin/bash
set -e

ansible-playbook \
  --private-key /home/user/.ssh/id_rsa \
  -i /work/inventory.yaml \
  --vault-password-file /work/VAULT_PASSWORD \
  --user root \
  /work/playbook/${PLAYBOOK} \
  ${LIMIT} --diff

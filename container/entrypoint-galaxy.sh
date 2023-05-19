#!/bin/bash
set -e

/usr/bin/ansible-galaxy \
  install \
  -r /work/requirements.yml \
  --roles-path /work/playbook/roles/

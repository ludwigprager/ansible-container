# Ansible-Container
This project is a blue-print for the usage of ansible in the context of a container. It includes ansible-galaxy and ansible-vault but both can be skipped, ignored for now or used at a later time.
An inventory file is prepared to help you get started.

# TL;DR
```
git clone https://github.com/ludwigprager/ansible-container.git

./deploy.sh <target host> [playbook]
```

# Prerequisites
A linux system with docker installed.

# Usage

Place an arbitrary [ansible-vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html) password in `./VAULT_PASSWORD`.
To get started place a random string in that file:
```
echo $RANDOM > VAULT_PASSWORD
```


Run the following command to apply a simple playbook to host `desktop01`
```
./deploy.sh desktop01
```

Most likely, the script exits with an error message because there is no `desktop01` machine.  
As a first test you might add `desktop01` to your `/etc/hosts` file pointing to some machine.

# Automated system configuration with Ansible

## Installation

First, `ansible` is required in the system. See the [installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html) for different methods of getting Ansible.

Then, do
```
ansible-pull --url git@github.com:tien-vo/system-config.git --checkout archlinux-dev
```
for running the playbook remotely, or
```
ansible-playbook local.yml -K
```
for local repository. Note: It is more preferrable to install locally.

# Automated system configuration with Ansible

## Installation

First and foremost, `ansible` is required in the system. See the [installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html) for different methods of getting Ansible.

Then, run the following playbooks in order
```
ansible-playbook pre-install.yml -K
ansible-playbook install.yml -K
```

To enable custom callbacks with [townk/ansible-beautiful-output](https://github.com/Townk/ansible-beautiful-output), install `watchdog` and set
```
ANSIBLE_STDOUT_CALLBACK="beautiful"
```
while running the playbooks.

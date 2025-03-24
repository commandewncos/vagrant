# UTILIZANDO O ANSIBLE COM O VAGRANT

## Crie um ambiente virtual com python:
```python
pyton3 -m venv .venv
```

## Instale as dependencias do arquivo requirements:
```python
pip install -r requirementes.txt
```
---

```sh
# 01
ansible-playbook --inventory hosts playbook.yml --user vagrant --private-key '~/.vagrant.d/insecure_private_key'

# 02
ansible-playbook  provisioner.yml --inventory hosts
```
#!/bin/bash
cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo python3 -m pip install ansible
tee -a playbook.yml > /dev/null <<EOT
- hosts: localhost
  tasks:
  - name: Instalar Python3, virtualenv
    apt:
      pkg: 
        - python3
        - virtualenv
      update_cache: yes
    become: yes
  - name: Git clone
    ansible.builtin.git:
      repo: https://github.com/alura-cursos/clientes-leo-api.git
      dest: /home/ubuntu/iac
      version: master
      force: yes
  - name: Instalar dependencias com pip, django e djangorest
    pip:
      virtualenv: /home/ubuntu/iac/venv
      requirements: /home/ubuntu/iac/requirements.txt
  - name: Alterando hosts do settings
    lineinfile:
      path: /home/ubuntu/iac/setup/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes
  - name: configurando o bando de dados
    shell: '. /home/ubuntu/iac/venv/bin/activate; python /home/ubuntu/iac/manage.py migrate'
  - name: carregando dados iniciais
    shell: '. /home/ubuntu/iac/venv/bin/activate; python /home/ubuntu/iac/manage.py loaddata clientes.json'
  - name: iniciando o servidor
    shell: '. /home/ubuntu/iac/venv/bin/activate; nohup python /home/ubuntu/iac/manage.py runserver 0.0.0.0:8000 &'
EOT
ansible-playbook playbook.yml
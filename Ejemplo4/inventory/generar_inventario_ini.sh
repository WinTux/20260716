#!/bin/bash
echo "[springboot]" > inventario2.ini
terraform output - jason ip_de_spring | jq -r '.[]' >> inventario2.ini
echo "[springboot:vars]" >> inventario2.ini
echo "ansible_user=ubuntu" >> inventario2.ini
echo "ansible_ssh_private_key_file=/home/rusok/Descargas/EjemploAnsible.pem" >> inventario2.ini

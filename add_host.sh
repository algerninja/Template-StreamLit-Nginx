#!/bin/bash

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
    echo "Por favor, ejecuta este script como root o usando sudo."
    exit 1
fi

# Variables para la dirección IP y el dominio
IP_ADDRESS="$1"
DOMAIN_NAME="$2"

# Comprobar si se han proporcionado argumentos
if [ -z "$IP_ADDRESS" ] || [ -z "$DOMAIN_NAME" ]; then
    echo "Uso: $0 <dirección_IP> <nombre_dominio>"
    exit 1
fi

# Agregar la entrada al archivo /etc/hosts
echo "" >>/etc/hosts
echo "### (BEGIN) Streamlit local routes" >>/etc/hosts
echo "$IP_ADDRESS $DOMAIN_NAME" >>/etc/hosts
echo "### (END) Streamlit local routes" >>/etc/hosts

# Confirmación
echo "Se ha agregado la entrada: $IP_ADDRESS $DOMAIN_NAME a /etc/hosts"

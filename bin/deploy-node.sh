#!/bin/bash

TARGET=$1
NODE=$2
CRAWLER=$3

all-playbooks=false
if [ "${NODE}" = "all"]; then
  all-playbooks=true
fi

if [ "${NODE}" = "nginx" ] || [ "${all-playbooks}" = true]; then
  /etc/ansible/bin/ansible-playbook -i /etc/ansible/hosts \
  --extra-vars="target=${TARGET}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-nginx.yml

elif [ "${NODE}" = "scrapy" ] || [ "${all-playbooks}" = true]; then
  /etc/ansible/bin/ansible-playbook -i /etc/ansible/hosts \
  --extra-vars="target=${TARGET} docker_host_ip=${DOCKER_HOST_IP} crawler=${CRAWLER}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-scrapy.yml

fi

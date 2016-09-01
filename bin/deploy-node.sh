#!/bin/bash

TARGET=$1
NODE=$2
CRAWLER=$3

all_playbooks=false
if [ "${NODE}" = "all" ]; then
  all_playbooks=true
fi

if [ "${NODE}" = "scrapy" ]; then
  /etc/ansible/bin/ansible-playbook -i ../hosts \
  --extra-vars="target=${TARGET} crawler=${CRAWLER}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-scrapy.yml

elif [ "${NODE}" = "nginx" ] || [ "${all_playbooks}" = true ]; then
  /etc/ansible/bin/ansible-playbook -i ../hosts \
  --extra-vars="target=${TARGET} docker_host_ip=${DOCKER_HOST_IP}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-nginx.yml

elif [ "${NODE}" = "node-server" ] || [ "${all_playbooks}" = true ]; then
  /etc/ansible/bin/ansible-playbook -i ../hosts \
  --extra-vars="target=${TARGET}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-node-server.yml

elif [ "${NODE}" = "kibana" ] || [ "${all_playbooks}" = true ]; then
  /etc/ansible/bin/ansible-playbook -i ../hosts \
  --extra-vars="target=${TARGET}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-kibana.yml

elif [ "${NODE}" = "elasticsearch" ] || [ "${all_playbooks}" = true ]; then
  /etc/ansible/bin/ansible-playbook -i /etc/ansible/hosts \
  --extra-vars="target=${TARGET}" \
  /opt/deploy/ansible/playbooks/deploy/deploy-elasticsearch.yml

fi

#!/bin/bash
set -e

# Change directory to terraform and apply
cd terraform
terraform init
terraform apply -auto-approve

# Get the public IP
INSTANCE_IP=$(terraform output -raw instance_public_ip)
echo "Instance IP: ${INSTANCE_IP}"

# Go back to root then to ansible
cd ..
cd ansible

# Create inventory file
echo "[app]" > inventory
echo "${INSTANCE_IP} ansible_user=ubuntu ansible_ssh_private_key_file=${SSH_KEY_PATH}" >> inventory

# Wait for SSH to be ready
echo "Waiting for SSH to be ready on ${INSTANCE_IP}..."
until nc -zv ${INSTANCE_IP} 22; do
  sleep 5
done

# Run the playbook
ansible-playbook -i inventory setup.yml

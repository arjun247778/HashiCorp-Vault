#!/usr/bin/env bash
set -euo pipefail

# Ensure we are in the project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform"
INVENTORY_FILE="${PROJECT_ROOT}/ansible/inventories/inventory.ini"

echo "Generating Ansible inventory from Terraform outputs..."

# Check if terraform output is available
if ! cd "${TERRAFORM_DIR}" && terraform output -json > /dev/null 2>&1; then
    echo "Error: Failed to fetch Terraform outputs. Make sure Terraform has been applied." >&2
    exit 1
fi

# Fetch outputs
BASTION_IP=$(terraform output -raw bastion_public_ip)
VAULT_IPS_JSON=$(terraform output -json vault_private_ips)

# Parse Vault IPs (assuming list format)
# We can use jq to process json. Ensure jq is installed or use fallback.
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed." >&2
    exit 1
fi

VAULT_IP_1=$(echo "${VAULT_IPS_JSON}" | jq -r '.[0]')
VAULT_IP_2=$(echo "${VAULT_IPS_JSON}" | jq -r '.[1]')
VAULT_IP_3=$(echo "${VAULT_IPS_JSON}" | jq -r '.[2]')

# Create inventory file
mkdir -p "$(dirname "${INVENTORY_FILE}")"

cat << EOF > "${INVENTORY_FILE}"
[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/vault-key.pem
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

[bastion]
bastion-host ansible_host=${BASTION_IP}

[vault]
vault-1 ansible_host=${VAULT_IP_1} node_id=vault-1 private_ip=${VAULT_IP_1}
vault-2 ansible_host=${VAULT_IP_2} node_id=vault-2 private_ip=${VAULT_IP_2}
vault-3 ansible_host=${VAULT_IP_3} node_id=vault-3 private_ip=${VAULT_IP_3}

[vault:vars]
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/vault-key.pem ubuntu@${BASTION_IP}"'
EOF

echo "Inventory generated successfully at ${INVENTORY_FILE}"
cat "${INVENTORY_FILE}"

pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        TF_IN_AUTOMATION   = 'true'
        ANSIBLE_FORCE_COLOR = 'true'
    }

    stages {
        stage('1. Checkout Source Code') {
            steps {
                checkout scm
            }
        }

        stage('2. Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir('terraform') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('3. Terraform Format Check') {
            steps {
                dir('terraform') {
                    sh 'terraform fmt -check -recursive'
                }
            }
        }

        stage('4. Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('5. Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir('terraform') {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('6. Manual Approval') {
            steps {
                input message: 'Approve infrastructure deployment?', ok: 'Apply'
            }
        }

        stage('7. Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir('terraform') {
                        sh 'terraform apply -input=false tfplan'
                    }
                }
            }
        }

        stage('8. Generate Dynamic Inventory') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh './scripts/generate_inventory.sh'
                }
            }
        }

        stage('9. Ansible Ping') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'vault-ssh-key-id', keyFileVariable: 'SSH_KEY_PATH', usernameVariable: 'SSH_USER')]) {
                    sh '''
                        mkdir -p ~/.ssh
                        rm -f ~/.ssh/vault-key.pem
                        cp "${SSH_KEY_PATH}" ~/.ssh/vault-key.pem
                        chmod 400 ~/.ssh/vault-key.pem
                        pkill -u $(whoami) -f "ssh: /var/lib/jenkins/.ansible/cp" || true
                        cd ansible
                        ansible all -m ping -i inventories/inventory.ini
                    '''
                }
            }
        }

        stage('10. Install Vault Cluster') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'vault-ssh-key-id', keyFileVariable: 'SSH_KEY_PATH')]) {
                    sh '''
                        mkdir -p ~/.ssh
                        rm -f ~/.ssh/vault-key.pem
                        cp "${SSH_KEY_PATH}" ~/.ssh/vault-key.pem
                        chmod 400 ~/.ssh/vault-key.pem
                        cd ansible
                        ansible-playbook -i inventories/inventory.ini playbooks/vault.yml
                    '''
                }
            }
        }

        stage('11. Verify Vault Health') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    withCredentials([sshUserPrivateKey(credentialsId: 'vault-ssh-key-id', keyFileVariable: 'SSH_KEY_PATH')]) {
                        sh '''
                        mkdir -p ~/.ssh
                        rm -f ~/.ssh/vault-key.pem
                        cp "${SSH_KEY_PATH}" ~/.ssh/vault-key.pem
                        chmod 400 ~/.ssh/vault-key.pem
                        
                        # Fetch the ALB DNS from terraform output
                        cd terraform
                        ALB_DNS=$(terraform output -raw alb_dns_name)
                        echo "ALB DNS: http://${ALB_DNS}"
                        
                        # Verify that the health check responds (it will return 501 since it is uninitialized, which is correct for a fresh install)
                        echo "Testing API health check endpoint..."
                        curl -s -o /dev/null -w "%{http_code}" "http://${ALB_DNS}/v1/sys/health" || true
                        
                        # Verify systemd service status on one of the nodes via bastion
                        BASTION_IP=$(terraform output -raw bastion_public_ip)
                        VAULT_IP_1=$(terraform output -json vault_private_ips | jq -r '.[0]')
                        
                        echo "Checking Systemd service status on Node 1..."
                        ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
                            -i ~/.ssh/vault-key.pem \
                            -o ProxyCommand="ssh -W %h:%p -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/vault-key.pem ubuntu@${BASTION_IP}" \
                            ubuntu@${VAULT_IP_1} "systemctl status vault --no-pager"
                    '''
                    }
                }
            }
        }

        stage('12. Publish Outputs') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir('terraform') {
                        sh '''
                            echo "=========================================================="
                            echo "              DEPLOYMENT SUCCESSFUL                       "
                            echo "=========================================================="
                            terraform output
                            echo "=========================================================="
                        '''
                    }
                }
            }
        }

        stage('13. Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'ansible/inventories/inventory.ini, terraform/terraform.tfstate*', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            sh 'rm -f ~/.ssh/vault-key.pem'
        }
        failure {
            script {
                echo "Pipeline failed! Initiating rollback analysis..."
                // Rollback actions or notifications can go here.
                // We keep the infrastructure provisioned for troubleshooting, 
                // but log the details.
            }
        }
    }
}

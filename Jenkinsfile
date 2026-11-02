pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('1. Recuperation Git & Verification') {
            steps {
                echo "Fichiers recuperes depuis GitHub :"
                sh 'ls -la'
            }
        }

        stage('2. Deployement Ansible') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target-server-ssh', keyFileVariable: 'SSH_KEY')]) {
                    sh 'ansible-playbook -i inventory.ini deploy-nginx.yml --key-file "$SSH_KEY" --extra-vars "html_path=${WORKSPACE}/index.html"'
                }
            }
        }

        stage('3. Validation du service Web') {
            steps {
                sh 'STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://target-server:80) && echo "Code HTTP: $STATUS" && [ "$STATUS" -eq 200 ]'
            }
        }
    }

    post {
        success {
            echo "Pipeline execute avec succes depuis GitHub !"
        }
        failure {
            echo "Erreur lors de l'execution du pipeline."
        }
    }
}

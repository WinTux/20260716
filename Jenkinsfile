pipeline {
  agent any
  tools {
    terraform 'Terraform_2.X'
  }
  environment {
    APP_NAME = "ejemplo-0.0.1-SNAPSHOT"
    JAR_PATH = "target/${APP_NAME}.jar"
    ANSIBLE_ROLE_PATH = "roles/springboot/files"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      } 
    }
    stage('Build & test') {
      steps {
        dir('Ejemplo4') {
          sh '''
          ./mvnw clean package -DskipTests=false
          mv target/ejemplo-*.jar target/ejemplo.jar
          '''
        }
      }
      post {
        success {
          echo "Compilacion y pruebas exitosas"
        }
        failure {
          error("Fallaron las pruebas. Pipeline se detiene!")
        }
      }
    }
    stage('Copiar Jar al rol de Ansible') {
      steps {
        dir('Ejemplo4') {
          sh """
          pwd
          cp target/ejemplo.jar ${ANSIBLE_ROLE_PATH}/ejemplo.jar
          ls -lh ${ANSIBLE_ROLE_PATH}
          """
        }
      }
    }
    stage('Validacion Terraform') {
      steps {
        dir('Ejemplo4') {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials'],file(credentialsId: 'clasesdevops-pem', variable: 'AWS_KEY_FILE')]) {
          sh """
          pwd
          terraform init
          terraform validate
          terraform plan -var="ruta_private_key=${AWS_KEY_FILE}" -out=tfplan
          terraform apply -auto-approve tfplan
          """
        }
        }
      }
    }
    stage('Deploy con Ansible') {
      steps {
        sh """
        pwd
        ansible-playbook -i Ejemplo4/inventory/inventario main.yml
        """
      }
    }
    stage('Terraform Destroy') {
      steps {
        input message: "Desea destruir la infraestructura creada?"
        dir('Ejemplo4') {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials'],file(credentialsId: 'clasesdevops-pem', variable: 'AWS_KEY_FILE')]) {
          sh """
          pwd
          terraform init
          terraform destroy -auto-approve -var="ruta_private_key=${AWS_KEY_FILE}"
          """
        }
        }
      }
    }
  }
}

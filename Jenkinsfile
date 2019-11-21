pipeline {
  agent {
    dockerfile {
      filename 'JenkinsAgentDockerfile'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }

    stage('Test') {
      post {
        always {
          junit 'target/surefire-reports/*.xml'
        }

      }
      steps {
        sh 'mvn test'
      }
    }

    stage('Package') {
      steps {
        sh 'sam --version'
      }
    }

    stage('Deploy') {
      steps {
        sh 'sam deploy --template-file packaged.yaml --stack-name aws-sam-java-rest-stack --region us-east-1 --capabilities CAPABILITY_IAM'
      }
    }

  }
}

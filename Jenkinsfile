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
    
    stage('Sonar Scan') {
      steps {
        withSonarQubeEnv('sandbox sonarqube') {
          sh 'mvn sonar:sonar'
        }
      }
    }
    
    stage('Quality Gate') {
      steps {
        timeout(time: 1, unit: 'HOURS') {
          script {
            def qg = waitForQualityGate()
            if (qg.status != 'OK') {
              error "Pipeline aborted due to quality gate failure: ${qg.status}"
            }
          }
        }
      }
    }

    stage('Package') {
      steps {
        withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
          sh 'sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket aws-sam-java-rest-test'
        }
      }
    }

    stage('Deploy') {
      steps {
        withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
          sh 'aws cloudformation describe-stack-events --stack-name aws-sam-java-rest-stack'
          sh 'sam deploy --template-file packaged.yaml --stack-name aws-sam-java-rest-stack --region us-east-1 --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset'
        }
      }
    }

  }
}

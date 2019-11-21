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
        sh 'export AWS_ACCESS_KEY_ID=AKIAY46JZWIAZMWY5O42'
        sh 'export AWS_SECRET_ACCESS_KEY=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'
        sh 'export AWS_DEFAULT_REGION=us-east-1'
        sh 'sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket aws-sam-java-rest-test'
      }
    }

    stage('Deploy') {
      steps {
        sh 'export AWS_ACCESS_KEY_ID=AKIAY46JZWIAZMWY5O42'
        sh 'export AWS_SECRET_ACCESS_KEY=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'
        sh 'export AWS_DEFAULT_REGION=us-east-1'
        sh 'sam deploy --template-file packaged.yaml --stack-name aws-sam-java-rest-stack --region us-east-1 --capabilities CAPABILITY_IAM'
      }
    }

  }
}

pipeline {
  agent {
    docker {
      image 'maven:3-alpine'
      args '-v /root/.m2:/root/.m2'
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
        withEnv(['PATH+EXTRA=/usr/sbin:/usr/bin:/sbin:/bin:/home/linuxbrew/.linuxbrew/bin']) {          
          sh 'sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket aws-sam-java-rest-test'
        }
      }
    }

    stage('Deploy') {
      steps {
        sh 'sam deploy --template-file packaged.yaml --stack-name aws-sam-java-rest-stack --region us-east-1 --capabilities CAPABILITY_IAM'
      }
    }

  }
}

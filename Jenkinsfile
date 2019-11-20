pipeline {
  agent any
  stages {
    stage('install dependencies') {
      steps {
        sh 'mvn package'
        sh 'sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket aws-sam-java-rest-test'
        sh 'sam deploy --template-file packaged.yaml --stack-name aws-sam-java-rest-stack --region us-east-1 --capabilities CAPABILITY_IAM '
      }
    }

  }
}
pipeline {
  agent none

environment {
   MAJOR_VERSION = 1
}

stages {
  stage('Unit Testing') {
    steps {
      sh 'ant -f test.xml -v'
      junit 'reports/result.xml'
}
}
  stage('Build') {
    agent {
      label 'Centos'
    }
    steps {
      sh 'ant -f build.xml -v'
    post {
      success {
        archiveArtifacts artifacts: 'dist/*.jar', fingerprint: true
}
   }
      }
    }
  stage('Deploy') {
    steps {
      sh "cp dist/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar /var/www/html/rectangles/all/"
   }
}
}
}

pipeline {
  agent {
    label 'Centos'
}

environment {
   MAJOR_VERSION = 1
}

stages {
  stage('Build') {
    steps {
      sh 'ant -f build.xml -v'
      
}
}
}
post {
  always {
     archiveArtifacts artifacts: 'dist/*.jar', fingerprint: true
}
}
}

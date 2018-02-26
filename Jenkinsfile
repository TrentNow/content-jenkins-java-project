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
post {
  always {
     archiveArtifacts artifacts: 'dist/*.jar', fingerprint: true
}
}
}
  stage('deploy') {
    steps {
       sh 'rectangle_${MAJOR_VERSION}.${BUILD_NUMER}.jar 4 5'
}
}
}
}

pipeline {
  agent {
    label 'Centos'
}

stages {
  stage('Build') {
    steps {
      sh 'ant -f build.xml -v'
      
}
}

post {
  always {
     archiveArtifacts artifacts: 'dist/*.jar', fingerprint: true
}
}
  stage('deploy') {
    steps {
      java -jar dist/rectangle_1.8.jar 6 10
}
}
}



}

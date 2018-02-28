pipeline {
  agent none

environment {
   MAJOR_VERSION = 1
}

stages {
  stage('Unit Testing') {
    agent {
    label 'Centos'
}
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
     }
    post {
      success {
        archiveArtifacts artifacts: 'dist/*.jar', fingerprint: true
}
   }
    }
  stage('Deploy') {
    agent {
      label 'Centos'
   }
    steps {
      sh "cp dist/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar /var/www/html/rectangles/all/"
   }
}
  stage('Running on Centos') {
  agent {
    label 'Centos'
}
    steps {
      sh "wget http://ec2-52-0-6-126.compute-1.amazonaws.com/rectangles/all/rectanle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar"
      sh "java -jar rect
anle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar 12 4"
}
      }
}
}
}

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
      sh "mkdir -p /var/www/html/rectangles/all/${env.BRANCH_NAME}"
      sh "cp dist/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar /var/www/html/rectangles/all/${env.BRANCH_NAME}"
   }
}
  stage('Running on Centos') {
  agent {
    label 'Centos'
}
    steps {
      sh "wget http://ec2-52-0-6-126.compute-1.amazonaws.com/rectangles/all/${env.BRANCH_NAME}/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar"
      sh "java -jar rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar 12 4"
}
      }
   stage('Running on Docker Container') {
   agent {
     docker 'openjdk:8u151-jre-stretch'
}
     steps {
       sh "wget http://ec2-52-0-6-126.compute-1.amazonaws.com/rectangles/all/${env.BRANCH_NAME}/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar"
       sh "java -jar rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar 20 10"
}
}
   stage('Promote to Green') {
   agent {
     label 'Centos'
}
   when {
     branch 'master'
}
     steps {
       sh "cp /var/www/html/rectangles/all/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar /var/www/html/rectangles/green/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar"
}
}
   stage('Promote Development Branch to Master') {
   agent {
     label 'Centos'
}
   when {
   branch 'development'
}
   steps {
     echo "Stashing Any local Changes"
     sh "git stash"
     echo "Checking out development branch"
     sh "git checkout development"
     echo "fecthing repo"
     sh "git fetch"
     echo "Checking Master branch"
     sh "git config --add remote.origin.fetch 
     sh "git fetch --no-tags"
     sh "git pull origin"
     sh "git checkout master"
     echo "Merging development branch"
     sh "git merge development"
     echo "Push to origin master"
     sh "git push origin master"
}
}
}
}

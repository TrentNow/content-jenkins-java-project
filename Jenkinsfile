pipeline {
  agent none

environment {
   MAJOR_VERSION = 1
}

stages {
  stage('Say Hello') {
  agent any
    steps {
      sayHello 'Awesomesauce'
}
}
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
      sh "if ![' -d /var/www/html/rectangles/all/${env.BRANCH_NAME}']; then mkdir -p /var/www/html/rectangles/all/${env.BRANCH_NAME}; fi"
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
       sh "cp /var/www/html/rectangles/all/${env.BRANCH_NAME}/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar /var/www/html/rectangles/green/rectangle_${MAJOR_VERSION}.${BUILD_NUMBER}.jar"
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
     echo "Pulling origin"
     sh "git pull origin"
     echo "Checking our master"
     sh "git checkout master"
     echo "Merging development branch"
     sh "git merge development"
     echo "Push to origin master"
     sh "git push origin master"
     echo "Tagging release"
     sh "git tag rectangle-${env.MAJOR_VERSION}.${env.BUILD_NUMBER}"
     sh "git push origin rectangle-${env.MAJOR_VERSION}.${env.BUILD_NUMBER}"
}
  post {
   success {
     emailext(
       subject: "${env.JOB_NAME} [${env.BUILD_NUMBER}] Development Promoted To Master!",
        body: """<p>'${env.JOB_NAME} [${env.BUILD_NUMBER}]' Development Promoted To Master!":</p>
        <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
        to: "trentonlcain@gmail.com"
      )
    }
}
}
}
   post {
    failure {
      emailext(
        subject: "${env.JOB_NAME} [${env.BUILD_NUMBER}] Failed!",
        body: """<p>'${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed!":</p>
        <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
        to: "trentonlcain@gmail.com"
      )
    }
}
}

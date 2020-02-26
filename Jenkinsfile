#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        HUGO = '/bin/hugo'
        DEPLOY_DIR = '/www/wwwroot/css0209.cn/public'
    }
    stages {
          stage('Init') {
            steps {
                sh 'echo "hugo version:"'
                sh '$HUGO version'
            }
        }
        stage('Build') {
            steps {
                sh 'ls -a'
                sh '$HUGO --baseUrl="https://css0209.cn" -t white -D'
                sh 'ls ./public'
            }
        }
        stage('Deploy') {
            steps {
                sh 'rm -rf $DEPLOY_DIR'
                sh 'mv ./public $DEPLOY_DIR'
                sh 'echo "deploy on $DEPLOY_DIR"'
            }
        }
    }
}

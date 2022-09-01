pipeline {
  agent any
  tools {
        nodejs "nodejs"
    }
    stages {
        stage('SCM checkout phase') {
	     agent { 
    		label 'deploy-agent'
		}
            steps {
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mangesh16cloud/react-project.git']]])
		
		stash 'source'
            }
        }
        stage('Sonar-analysis phase') {
            steps {
                unstash 'source'
                echo 'unstash successful'
                sh '/opt/sonar-scanner/bin/sonar-scanner --version'
                withSonarQubeEnv('sonar') {
                sh  """/opt/sonar-scanner/bin/sonar-scanner \
                -Dsonar.projectKey=nodejs \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://10.1.76.15:9000 \
                -Dsonar.login=8bea0ed7cd81cfb952e1971850430bf0804e7689"""
                stash 'source'
            }
        }
        }
	
        stage('Build phase') {
            steps {
                unstash 'source'
                echo 'unstash successful'
                sh 'npm i'
                sh 'chmod 777 node_modules'
		        sh 'npm run build'
		        stash 'source'
                
        }
        }
       /* stage ('Test phase UNDER CONSTRUCTION') {
            steps{
                unstash 'source'
                echo 'unstash is successfull'
                sh 'npm -v'
                echo 'node build successfull'
            }
        } */
        stage ('Deployment phase') {
            steps{
                unstash 'source'
                echo 'unstash successful'
                //sh 'rm -rf * /var/www/react'
                //sh 'mv /var/www/workspace/react /var/www/'
                sh 'cd /var/www/workspace/react'
                //sh 'npm start -d'
            }
        }
        stage ('Docker build + Tag phase'){
            steps {
                unstash 'source'
                echo 'unstash successfull'
                sh 'docker build -t samplereactapp:latest .' 
                sh 'docker tag samplereactapp mangeshsk/samplereactapp:latest'
                sh 'docker tag samplereactapp mangeshsk/samplereactapp:$BUILD_NUMBER'
            }
        }
        stage('Publish image on Docker Hub phase') {
          
            steps {
                withDockerRegistry([ credentialsId: "docker-id", url:""  ]) {
                sh  'docker push mangeshsk/samplereactapp:latest'
                sh  'docker push mangeshsk/samplereactapp:$BUILD_NUMBER' 
        }
                  
          }
        } 
        stage('Run Docker container on remote server phase ') {
             
            steps {
                sh 'docker stop c1'
                sh 'docker container rm c1'
                sh "docker run -d -p 3001:3000 --name c1 mangeshsk/samplereactapp "
 
            }
        }
        stage('SMTP notification stage for team phase') {
             
            steps {
                emailext (attachLog: true, body: '', recipientProviders: [culprits()], subject: 'jenkins notification and BUILD LOG:$BUILD_NUMBER for developers,testers', to: 'aws16cloud@gmail.com,mangesh@bhumiitech.com')
               
                //sh "docker -H ssh://ubuntu@10.1.76.15 run -d -p 3001:3000 mangeshsk/samplereactapp"
 
            }
        }

    }
    
}

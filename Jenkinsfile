pipeline {
  agent any
  tools {
        nodejs "nodejs"
    }
    stages {
        stage('Jenkins Master checkout phase') {
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
                echo 'unstash is successful'
                sh '/opt/sonar-scanner/bin/sonar-scanner --version'
                withSonarQubeEnv('sonar') {
                sh  """/opt/sonar-scanner/bin/sonar-scanner \
  		-Dsonar.projectKey=React \
  		-Dsonar.sources=. \
  		-Dsonar.host.url=http://10.1.76.15:9000 \
  		-Dsonar.login=81ae10e7be774177fd588ce3242a0e97186eca3c"""
                stash 'source'
            }
        }
        }
	
        stage('Build phase') {
            steps {
                unstash 'source'
                echo 'unstash is Successful'
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
                echo 'unstash Successful'
                //sh 'rm -rf * /var/www/React'
                //sh 'mv /var/www/workspace/React /var/www/'
                sh 'cd /var/www/workspace/React'
                //sh 'npm start -d'
            }
        }
        stage ('Docker build + Tag phase'){
            steps {
                unstash 'source'
                echo 'unstash successfull'
                sh 'docker build -t reactdemo:latest .' 
                sh 'docker tag reactdemo mangeshsk/reactdemo:latest'
                sh 'docker tag reactdemo mangeshsk/reactdemo:$BUILD_NUMBER'
            }
        }
        stage('Publish image on Docker Hub phase') {
          
            steps {
                withDockerRegistry([ credentialsId: "docker-id", url:""  ]) {
                sh  'docker push mangeshsk/reactdemo:latest'
                sh  'docker push mangeshsk/reactdemo:$BUILD_NUMBER' 
        }
                  
          }
        } 
        stage('Docker Container is alive phase ') {
             
            steps {
                sh 'docker stop c1'
                sh 'docker container rm c1'
                sh "docker run -d -p 3001:3000 --name c1 mangeshsk/reactdemo "
 
            }
        }
        stage('notification phase') {
             
            steps {
                emailext (attachLog: true, body: '', recipientProviders: [culprits()], subject: 'jenkins notification and BUILD LOG NO:$BUILD_NUMBER for developers,testers', to: 'aws16cloud@gmail.com,mangesh@bhumiitech.com')
               
                //sh "docker -H ssh://ubuntu@10.1.76.15 run -d -p 3001:3000 mangeshsk/samplereactapp"
 
            }
        }

    }
    
}

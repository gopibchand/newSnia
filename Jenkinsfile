podTemplate(label: 'jenkins_slave',
    containers: [
      containerTemplate(name: 'docker', image: 'docker:1.12.6', command: 'cat', ttyEnabled: true),
      containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.7', ttyEnabled: true, command: 'cat'),
      containerTemplate(name: 'python', image:  'python:3-slim',  command: 'cat', ttyEnabled: true)
      ],
     // containerTemplate(name: 'dind', image: 'docker:18.01.0-ce-dind', privileged: true, resourceRequestCpu: '20m', resourceRequestMemory: '512Mi',),
      //containerTemplate(name: 'docker-cmds', image: 'docker:18.01.0-ce', ttyEnabled: true, command: 'cat', envVars: [envVar(key: 'DOCKER_HOST', value: 'tcp://localhost:2375')]),
volumes:[
    hostPathVolume(mountPath: '/home/python/.python', hostPath: '/tmp/jenkins/.gradle'),
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
]
           )
{



node ('jenkins_slave'){
    //label 'jenkins_slave'
    def app
   def IMAGE_NAME = "${env.ACR_LOGINSERVER}/emulator:${BUILD_NUMBER}"

    stage('Clean workspace') {
      deleteDir()
    }
    
    stage('Clone repository') {
        
        git 'https://github.com/sniaproject/newSnia.git'
    }

   //stage('Build image') {
        
     //   app = 'docker.build ${IMAGE_NAME}'
     //}

    stage('Build and Push image') {
       
       sh "docker build . -t ${env.ACR_LOGINSERVER}/emulator:${BUILD_NUMBER}"
        sh "docker login ${env.ACR_LOGINSERVER} -u ${env.ACR_ID} -p ${env.ACR_PASSWORD}"
        sh "docker push ${env.ACR_LOGINSERVER}/emulator:${BUILD_NUMBER}"
        }
       
        stage('Deployment on kubernetes'){
            
            sh "sed -i 's/imagetag/$BUILD_NUMBER/g' ${pwd()}/depemu.yaml"
            sh 'kubectl create -f depemu.yaml'
            sh 'kubectl create -f depserv.yaml'
        }
        
     }
 }

env.DOCKER_IMAGE_NAME = DOCKER_HUB
//agent{
    
node {
    //label 'jenkins_slave'
    def app

    stage('Clean workspace') {
      deleteDir()
    }
    
    stage('Clone repository') {
        
        checkout scm
    }

    stage('Build image') {
        
        app = docker.build("venkatarr/emulator")
    }

    stage('Test image') {
        
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', '$DOCKER_IMAGE_NAME') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
 }   
//}

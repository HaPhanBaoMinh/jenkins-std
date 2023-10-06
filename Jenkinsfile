node {
    stage("git checkout"){
       git branch: 'main', url: 'https://github.com/HaPhanBaoMinh/jenkins-std.git'
    }
    
    stage("Docker build image"){
        sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID baominh/$JOB_NAME:v1.$BUILD_ID'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID baominh/$JOB_NAME:latest'
    }
    
    stage("Docker push"){
        withCredentials([string(credentialsId: 'docker-pwd', variable: 'DockerPassword')]) {
            sh "docker login -u baominh -p ${DockerPassword}"
            sh "docker image push baominh/$JOB_NAME:v1.$BUILD_ID"
            sh "docker image push baominh/$JOB_NAME:latest"
            
            sh "docker image rm baominh/$JOB_NAME:v1.$BUILD_ID baominh/$JOB_NAME:latest"
        }
    }
    
    stage("Docker container deployment"){
        def Dockerrun = ""
        sshagent(['ec2-server']) {
            sh "ssh -o StrictHostKeyChecking=no ec2-user@47.128.66.233 docker --version"
            sh "ssh -o StrictHostKeyChecking=no ec2-user@47.128.66.233 docker rm -f $JOB_NAME"
            sh "ssh -o StrictHostKeyChecking=no ec2-user@47.128.66.233 docker rmi -f baominh/$JOB_NAME:latest"
            sh "ssh -o StrictHostKeyChecking=no ec2-user@47.128.66.233 docker pull baominh/$JOB_NAME:latest"
            sh "ssh -o StrictHostKeyChecking=no ec2-user@47.128.66.233 docker run -d -p 80:80 --name $JOB_NAME baominh/$JOB_NAME:latest"
           
        }
    }
    
}
pipeline{
    agent any
    tools{
        maven "M2_HOME"
    }
    stages{
        stage("clone the code"){
            steps{
                git branch: 'main', url: 'https://github.com/Manojmuthu13/EMS1.git'
            }
        }
        stage("maven build"){
            steps{
                sh "mvn clean install"
            }
        }
        stage("code-checking-quality"){
            steps{
                sh "mvn sonar:sonar"
            }
        }
        stage("Artifact-Upload"){
            steps{
                s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'bitbucket-restore-code', excludedFile: '', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: false, selectedRegion: 'ap-south-1', showDirectlyInBrowser: false, sourceFile: '**/*.war', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 's3', userMetadata: []
            }
        }
        stage("docker build image and push"){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerpasvar', usernameVariable: 'manoj3214')]) {
                        sh 'docker login -u ${manoj3214} -p ${dockerpasvar}'
                        sh 'docker build -t ${manoj3214}/virat:latest .'
                        sh 'docker push ${manoj3214}/virat:latest'
                        sh 'docker run -d --name dhoni -p 9999:8080 ${manoj3214}/virat:latest'
                    }
                }
            }
        }
        stage("kubernetes deployment"){
            steps{
                script{
                   echo "Deploying the EKS"
                    
                    sh 'envsubst < deployment.yaml | sudo /root/bin/kubectl apply -f -'
                    sh 'envsubst < hpa.yaml | sudo /root/bin/kubectl apply -f -'
                    
                }
            }
        }
    }
}

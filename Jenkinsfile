pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: docker
                    image: docker:dind
                    command:
                    - sh
                    - -c
                    - |
                      dockerd-entrypoint.sh &
                      sleep 5
                      docker info
                    tty: true
                    securityContext:
                      privileged: true
                    volumeMounts:
                    - mountPath: /var/run/docker.sock
                      name: docker-sock
                  volumes:
                  - name: docker-sock
                    hostPath:
                      path: /var/run/docker.sock
                '''
            }
        }
        stages {
                stage('Build Docker Image') {
                    steps {
                        container('docker') {
                        sh 'docker build -t gcr.io/amplified-lamp-384112/hello:1.0.0 .'
                        sh 'docker push gcr.io/amplified-lamp-384112/hello:1.0.0'
                        }
                    }
                }
            }
        }

pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: jenkins-build-job
            image: python:3-alpine
            command:
            - sh
            - -c
            - apk add --no-cache gcc musl-dev libffi-dev openssl-dev docker-cli && python3 -m ensurepip && pip3 install --upgrade pip && pip3 install docker
            tty: true
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
        container('jenkins-build-job') {
          sh 'pip3 install flask'
          sh 'docker build -t gcr.io/amplified-lamp-384112/hello:1.0.0 .'
          sh 'docker push gcr.io/amplified-lamp-384112/hello:1.0.0'
        }
      }
    }
  }
}

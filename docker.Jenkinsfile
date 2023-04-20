pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            best-company: supersmart
        spec:
          containers:
          - name: docker
            image: docker:latest
            command:
            - cat
            tty: true
            volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-sock
          volumes:
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock
        '''
      retries 2
    }
  }
  stages {
    stage('Build') {
      environment {
        GCR_CREDENTIALS = credentials('gcp_creds')
      }
      steps {
        container('docker') {
          sh 'docker build -t gcr.io/amplified-lamp-384112/hello:${BUILD_NUMBER} .'
          sh 'echo "$GCR_CREDENTIALS" > credentials.json'
          sh 'sleep 99999'
          sh 'docker login -u _json_key -p "$(cat credentials.json)" https://gcr.io'
          sh 'docker push gcr.io/amplified-lamp-384112/hello:${BUILD_NUMBER}'
        }
      }
    }
  }
}

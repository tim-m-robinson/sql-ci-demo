node {
    stage('Prep') {
        deleteDir()
        checkout scm
    }
    stage('Create Test DB') {
        sh: 'rm -rf /tmp/oradata'
        sh: 'cp -R /tmp/oradata-ref/* /tmp/oradata/
    }
    stage('Apply Changes') {
        echo 'b'
    }
    stage('Unit Test') {
        echo 'c'
    }
    stage('Package') {
        echo 'd'
    }
}

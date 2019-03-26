node {
    stage('Prep') {
        deleteDir()
        checkout scm

        // capture GID of Docker group
        env.DOCKER_GID = sh (
            script: 'ls -la /var/run/docker.sock|cut -d" " -f4',
            returnStdout: true
        ).trim()
        echo "Docker GID: ${DOCKER_GID}"
    }

    stage('Create Test DB') {
        sh: 'rm -rf /tmp/oradata'
        sh: 'cp -R /tmp/oradata-ref/* /tmp/oradata/'
    }

    withDockerContainer(image: 'oracle/database:18.3.0-ee',
                         args: '''--network="citools"
                                  --group-add ${DOCKER_GID}
                                  -v /var/run/docker.sock:/var/run/docker.sock
                                  -e ORACLE_SID=HDWS 
                                  -e ORACLE_PDB=PDB1
                                  -e ORACLE_PWD=password
                                  -e ORACLE_CHARACTERSET=AL32UTF8''') { c->

      stage('Apply Changes') {
        echo 'b'
      }

      stage('Unit Test') {
        sh: 'ls'
        env.TEST_STATUS = sh(
          script: 'cd test;sqlplus hdws/hdws @test_db.sql;echo $?',
          returnStdout: true
        ).trim()
        echo ${TEST_STATUS}
      }
    }

    stage('Package') {
        echo 'd'
    }
}

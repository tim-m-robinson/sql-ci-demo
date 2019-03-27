
de {
    stage('Prep') {
        deleteDir()
        checkout scm
    }

    stage('Create Test DB') {
        sh (
            script: 'sudo rm -rf /tmp/oradata/*',
            returnStdout: true
            )
        sh (
            script: 'sudo cp --preserve -R /tmp/oradata-ref/* /tmp/oradata',
            returnStdout: true
            )
    }
    
    docker.image('oracle/database:18.3.0-ee').withRun(
        '''--network="citools" \
          --network-alias="hdwsdb" \
          -v /oracle/oradata-1:/opt/oracle/oradata \
          -e ORACLE_SID=HDWS \
          -e ORACLE_PDB=PDB1 \
          -e ORACLE_PWD=password \
          -e ORACLE_CHARACTERSET=AL32UTF8''') { db->
          
        //WAIT FOR DB TO START
        sleep 20
          
        docker.image('oracle/database:18.3.0-ee').inside('--network="citools"') { c->   
        
            stage('Load Test Data') {
                sh script: 'ls', returnStdout: true
                sh script: 'tnsping //hdwsdb:1521/HDWS', returnStdout: true
                env.DATA_STATUS = sh(
                    script: 'cd src/data;sqlplus "hdws/hdws@//hdwsdb:1521/HDWS" @data_db_v1.sql;echo $?',
                    returnStatus: true
                )
                echo "Data Status: ${DATA_STATUS}"
                if (env.DATA_STATUS != '0') {
                    error('Data Load Failed')
                }
            }
                
            stage('Apply Changes') {
                echo 'b'
            }

            stage('Unit Test') {
                sh script: 'ls', returnStdout: true
                sh script: 'tnsping //hdwsdb:1521/HDWS', returnStdout: true
                env.TEST_STATUS = sh(
                    script: 'cd test;sqlplus "hdws/hdws@//hdwsdb:1521/HDWS" @test_db.sql;echo $?',
                    returnStatus: true
                )
                echo "Test Status: ${TEST_STATUS}"
                if (env.TEST_STATUS != '0') {
                    error('Unit Tests Failed')
                }
            }
        }
    }

    stage('Package') {
        zip (
            zipFile: 'HDWS_DB.V1.0.0.RC1.zip',
            archive: true
            )
    }
}

#!/bin/bash
docker run --rm --network citools -v $(pwd)/:/tmp/oratest/ -e 'SQLPATH=/tmp/oratest' oracle/database:18.3.0-ee sqlplus 'hdws/hdws@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=hdwsdb)(Port=1521))(CONNECT_DATA=(SID=HDWS)))' @test_db.sql

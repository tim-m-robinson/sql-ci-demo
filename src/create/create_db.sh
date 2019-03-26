#!/bin/bash
docker run -rm oracle sqlplus 'hdws/hdws@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=orcl)(Port=1521))(CONNECT_DATA=(SID=HDWS)))' @create_db.sql
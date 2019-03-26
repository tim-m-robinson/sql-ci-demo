WHENEVER SQLERROR EXIT SQL.SQLCODE

INSERT INTO EMP (id, first_name, last_name)
VALUES(1, 'John', 'Smith'); 

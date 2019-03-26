CREATE OR REPLACE PROCEDURE TEST
IS
   n_rows NUMBER;
BEGIN
   SELECT count(*) into n_rows FROM EMP WHERE id = 1;
   IF n_rows != 1 THEN
      raise_application_error(-20000,'Test emp_1 failed');
   END IF;
END;
/

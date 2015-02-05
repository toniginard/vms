ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;

ALTER USER APEX_PUBLIC_USER IDENTIFIED BY agora;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY agora;

SELECT DBMS_XDB.GETHTTPPORT FROM DUAL;
EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);

CREATE USER usu1 IDENTIFIED BY agora DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;
GRANT ALL PRIVILEGES TO usu1;
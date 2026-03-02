
------------------------------------------------------
-- Create users
------------------------------------------------------

> sqlplus/nolog
> conn sys as sysdba
> orcl 
> CREATE USER tms_user IDENTIFIED BY tms_user;

-- grant sysdba to tms_user;
// SQL> grant CREATE TABLE TO tms_user;
// SQL> grant create session to tms_user;
// SQL> grant alter any table to tms_user ;

SQL> grant all privileges to tms_user ;
SQL> grant unlimited tablespace to tms_user ;

SQL> grant select on dba_users to tms_user ;
SQL> grant select on dba_segments to tms_user;

SQL> grant select on dba_data_files to tms_user ;
SQL> grant select on dba_directories to tms_user ;

SQL> GRANT SELECT ON sys.dba_constraints TO tms_user ;

------------------------------------------------------
-- Drop users 
------------------------------------------------------

SQL> drop user tms_user cascade;

------------------------------------------------------
-- Dump 
------------------------------------------------------
> server

cmd> impdp \"sys/sys123 as sysdba\" directory = dmp_dir schemas = tms_user, trec_trec dumpfile = newdsesms_29_Nov_2022.DMP

------------------------------------------------------
-- Check User using sqlplus
------------------------------------------------------

cmd> sqlplus/nolog
SQL> conn tms_user as sysdba
Enter password: tms_user
Connected.

------------------------------------------------------
-- Check User Using SqlDeveloper
------------------------------------------------------

Connection Name: tms_user
User Name: tms_user
Password : tms_user
Connection Type: Basic
Role: Default

Host Name: 172.31.62.20
Port: 1521
Sid: orcl

select username, account_status from dba_users WHERE username = 'tms_user';
select distinct tablespace_name from dba_segments where owner='tms_user';
select 'GRANT SELECT ON Abteilung TO ' || username || ';' FROM all_users WHERE username LIKE '%DSE%';


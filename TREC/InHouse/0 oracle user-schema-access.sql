

--------------------------------------------------------
-- Create users
--------------------------------------------------------

> sqlplus/nolog
> conn sys as sysdba
> orcl 
> CREATE USER trec_dsesms IDENTIFIED BY trec_dsesms;
// trec_dsesms is the name of the user you are creating and trec_dsesms is the password that you want to assign to the user.
// Assign the sysdba privilege to the new Oracle user:
// grant sysdba to trec_dsesms;

> CREATE USER trec_hrm IDENTIFIED BY trec_hrm;
> CREATE USER trec_trec IDENTIFIED BY trec_trec;
> CREATE USER tms_user IDENTIFIED BY tms_user;


// SQL> grant CREATE TABLE TO trec_dsesms;
// SQL> grant create session to trec_dsesms;
// SQL> grant alter any table to trec_dsesms, trec_hrm, trec_trec;

SQL> grant all privileges to trec_dsesms, trec_hrm, trec_trec, tms_user;
SQL> grant unlimited tablespace to trec_dsesms, trec_hrm, trec_trec, tms_user;

SQL> grant select on dba_users to trec_dsesms, trec_hrm, trec_trec , tms_user;
SQL> grant select on dba_segments to trec_dsesms, trec_hrm, trec_trec, tms_user;


SQL> grant select on dba_data_files to trec_dsesms, trec_hrm, trec_trec, tms_user;
SQL> grant select on dba_directories to trec_dsesms, trec_hrm, trec_trec, tms_user;

GRANT SELECT ON sys.dba_constraints TO trec_dsesms, trec_hrm, trec_trec, tms_user;


grant all privileges to  tms_user;
grant unlimited tablespace to tms_user;

grant select on dba_users to tms_user;
grant select on dba_segments to tms_user;

grant select on dba_data_files to tms_user;
grant select on dba_directories to tms_user;

GRANT SELECT ON sys.dba_constraints TO tms_user;

--------------------------------------------------------
-- Drop users
--------------------------------------------------------

SQL>  drop user trec_dsesms cascade;
SQL>  drop user trec_hrm cascade;
SQL>  drop user trec_trec cascade;

------------------------------------------------------
-- Dump 
------------------------------------------------------
> server

impdp \"sys/sys123 as sysdba\" directory = dmp_dir schemas = trec_dsesms, trec_hrm, trec_trec dumpfile = newdsesms_29_Nov_2022.DMP

------------------------------------------------------
-- Check User using sqlplus
------------------------------------------------------

CMD> sqlplus/nolog
SQL> conn trec_dsesms as sysdba
Enter password: trec_dsesms
Connected.


CMD> sqlplus/nolog
SQL> conn trec_hrm as sysdba
Enter password: trec_hrm
Connected.


CMD> sqlplus/nolog
SQL> conn trec_trec as sysdba
Enter password: trec_trec
Connected.

------------------------------------------------------
-- Check User Using SqlDeveloper
------------------------------------------------------

Connection Name: trec_dsesms
User Name: trec_dsesms
Password : trec_dsesms
Connection Type: Basic
Role: Default

Host Name: 172.31.62.20
Port: 1521
Sid: orcl


select username, account_status from dba_users WHERE username = 'trec_dsesms';
select distinct tablespace_name from dba_segments where owner='trec_dsesms';
select 'GRANT SELECT ON Abteilung TO ' || username || ';' FROM all_users WHERE username LIKE '%DSE%';

--------------------------------------------------------
-- GENERATE DDL Script of DSESMS
--------------------------------------------------------

TABLESPACE "USERS" replace with  TABLESPACE "TREC_DSESMS"
TABLESPACE "DSESMS01" replace with  TABLESPACE "TREC_DSESMS"

"DSESMS". replace with  "TREC_DSESMS".

--------------------------------------------------------
-- Delete Data from DSESMS
--------------------------------------------------------

select * from TBLAUDITDETAIL;
select * from TBLAUDITLOGINFO;
select * from TBLAUDITLOGINFO_HISTORY;
select * from TBLAUDITDETAIL_LOB;
select * from TBLAUDITFORGOTPASSWORD;
select * from TBLAUDITMASTER;


delete from TBLAUDITDETAIL;
delete from TBLAUDITLOGINFO;
delete from TBLAUDITLOGINFO_HISTORY;
delete from TBLAUDITDETAIL_LOB;
delete from TBLAUDITFORGOTPASSWORD;
delete from TBLAUDITMASTER;

commit;

--------------------------------------------------------
-- GENERATE Insert Script of DSESMS
--------------------------------------------------------

DSESMS. replace with  TREC_DSESMS.

------------------------------------------------------
-- Check User Using SqlDeveloper
------------------------------------------------------

Connection Name: trec_hrm
User Name: trec_hrm
Password : trec_hrm
Connection Type: Basic
Role: Default

Host Name: 172.31.62.20
Port: 1521
Sid: orcl


--------------------------------------------------------
-- GENERATE DDL Script of HRM
--------------------------------------------------------

TABLESPACE "USERS" replace with  TABLESPACE "TREC_HRM"
TABLESPACE "HRM01" replace with  TABLESPACE "TREC_HRM"

"HRM" replace with  "TREC_HRM"


--------------------------------------------------------
-- Delete Data
--------------------------------------------------------

select *  from CIR_MESSAGE_TO;
select *  from CIR_ATTACHED_INFO;
select *  from CIR_MESSAGE_INFO;


delete CIR_MESSAGE_TO;
delete CIR_ATTACHED_INFO;
delete CIR_MESSAGE_INFO;
commit;

select * from all_constraints where constraint_name ='FK_T_C_F_C_M_I_I_C_M_I';

select * from TREC.CIR_MESSAGE_TREC_TO;
select * from TREC.TREC_CIRCULAR_FEEDBACK;

delete TREC.CIR_MESSAGE_TREC_TO;
delete TREC.TREC_CIRCULAR_FEEDBACK;

commit;

--------------------------------------------------------
-- GENERATE Insert Script of HRM
--------------------------------------------------------

HRM. replace with  TREC_HRM.


------------------------------------------------------
-- Check User Using SqlDeveloper
------------------------------------------------------

Connection Name: trec_trec
User Name: trec_trec
Password : trec_trec
Connection Type: Basic
Role: Default

Host Name: 172.31.62.20
Port: 1521
Sid: orcl


SQL> grant references on trec_dsesms.TBLUSERINFO to trec_trec;
SQL> grant references on trec_hrm.CIR_MESSAGE_INFO to trec_trec;

--------------------------------------------------------
-- GENERATE DDL Script of TREC
--------------------------------------------------------

TABLESPACE "TREC_01" replace with  TABLESPACE "TREC_TREC"


REFERENCES "DSESMS" replace with  TABLESPACE "TREC_DSESMS"
REFERENCES "HRM" replace with  TABLESPACE "TREC_HRM"


"TREC". replace with  "TREC_TREC". 

--------------------------------------------------------
-- GENERATE Insert Script of DSESMS
--------------------------------------------------------

TREC. replace with  TREC_TREC. 



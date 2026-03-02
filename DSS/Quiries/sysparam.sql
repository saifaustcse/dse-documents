
select * from sysparam;
SELECT * FROM TBLUSERINFO;

-- alter table TBLUSERINFO add (IS_OTP_ENABLE CHAR(1) default 'N');
-- update TBLUSERINFO set IS_OTP_ENABLE='Y'  where  USER_CAT_ID=2;
-- alter table TBLUSERINFO add (IS_PROFILE_LOCK CHAR(1) default 'N');
-- alter table TBLUSERINFO add (PROFILE_LOCK_UNTILL DATE default NULL);
-- commit;


INSERT INTO sysparam (ID, PARAMNAME, DESCRIPTION, PARAMVALUE, PARAMNOTE, ADMINFLAG, ISDELETED)
VALUES (7, 'IS_OTP_ENABLE_FOR_TREC_USERS', 'OTP Enable or Disable for trec users', '0', '0 means NO and 1 means YES', 'true', 'N');

INSERT INTO sysparam (ID, PARAMNAME, DESCRIPTION, PARAMVALUE, PARAMNOTE, ADMINFLAG, ISDELETED)
VALUES (8, 'IS_OTP_ENABLE_FOR_DSE_USERS', 'OTP Enable or Disable for dse users', '0', '0 means NO and 1 means YES', 'true', 'N');

INSERT INTO sysparam (ID, PARAMNAME, DESCRIPTION, PARAMVALUE, PARAMNOTE, ADMINFLAG, ISDELETED)
VALUES (9, 'IS_PROFILE_LOCK_ENABLE', 'Profile lock or unlock of all users', '0', '0 means NO and 1 means YES', 'true', 'N');

INSERT INTO sysparam (ID, PARAMNAME, DESCRIPTION, PARAMVALUE, PARAMNOTE, ADMINFLAG, ISDELETED)
VALUES (10, 'COUNT_DEADLINE_FOR_RBCA_REPORT_SUBMISSION', 'Count days from the First Day of the month for RBCA report submission', '15', 'After the days deadline will be exceeded', 'true', 'N');


--update sysparam set PARAMVALUE=1 where PARAMNAME='IS_OTP_ENABLE_FOR_TREC_USERS';
--update sysparam set PARAMVALUE=1 where PARAMNAME='IS_PROFILE_LOCK_ENABLE';

commit;


ALTER TABLE sysparam MODIFY ( id NOT NULL);
commit;

ALTER TABLE sysparam drop CONSTRAINT primary_key cascade;
ALTER TABLE sysparam ADD CONSTRAINT PK_SYSPARAM_ID PRIMARY KEY (ID);
commit;


ALTER TABLE sysparam drop CONSTRAINT unique_key cascade;
ALTER TABLE sysparam ADD CONSTRAINT UK_SYSPARAM_PARAMNAME UNIQUE  (PARAMNAME);

commit;

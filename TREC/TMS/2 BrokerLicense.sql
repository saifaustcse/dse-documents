--------------------------------------------------------------------------------

delete from BROKER;
commit;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'BROKER'
    AND constraint_type IN ('P', 'U')
);

delete from BROKER_STATUS;
delete from BROKER_RENEW;
delete from BROKER;
commit;

-- Drop the foreign key constraints for each table and key
ALTER TABLE BROKER_REMINDER DROP CONSTRAINT FK_BROKER_REMINDER_BROKER_ID;

-- ADD the foreign key constraints for each table and key
ALTER TABLE BROKER_REMINDER ADD CONSTRAINT FK_BROKER_REMINDER_BROKER_ID
FOREIGN KEY (BROKER_ID) REFERENCES BROKER (BROKER_ID);

--------------------------------------------------------------------------------
TREC_TREC.BROKER
--------------------------------------------------------------------------------

CREATE TABLE TREC_TREC.BROKER
(
    BROKER_ID NUMBER(5,0) NOT NULL,         -- auto increment id 
    BACKUP_ID VARCHAR2(50 CHAR),
    TREC_ID NUMBER(5,0) NOT NULL,           -- TREC_REG_BACKUP.APPDATE
    BSEC_REG_NO VARCHAR2(50 CHAR),          -- TREC_REG_BACKUP.SECREGNO
    BSEC_REG_ISSUANCE_DATE DATE,            -- TREC_REG_BACKUP.REGDATE 
    LICESE_TYPE VARCHAR2(50 CHAR),          -- “Original”, "Re-issued”, or “Duplicate”. 
    LICESE_PATH VARCHAR2(255 CHAR),

    REMARKS VARCHAR2(500 CHAR),             -- TREC_REG_BACKUP.REGREMARKS 
    
    ADDED_AT DATE DEFAULT sysdate NOT NULL,
    ADDED_BY VARCHAR2(50) NOT NULL,
    UPDATED_AT DATE,
    UPDATED_BY VARCHAR2(50),

    CONSTRAINT PK_BROKER_ID PRIMARY KEY (BROKER_ID),
    CONSTRAINT FK_BROKER_TREC FOREIGN KEY (TREC_ID) REFERENCES TREC_TREC.TREC (TREC_ID)
);

------------------------------------------------------
  BROKER_STATUS
------------------------------------------------------

CREATE TABLE BROKER_STATUS(
    BROKER_STATUS_ID NUMBER(10,0) NOT NULL,
	BROKER_ID NUMBER(5,0) NOT NULL,
    STATUS VARCHAR2(50) NOT NULL,
    EFFECTIVE_DATE DATE,
    END_DATE DATE,
	REMARKS VARCHAR2(255),		

    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    ADDED_AT DATE DEFAULT sysdate NOT NULL,
    ADDED_BY VARCHAR2(50) NOT NULL,
    UPDATED_AT DATE,
    UPDATED_BY VARCHAR2(50),

    CONSTRAINT PK_BROKER_STATUS_ID PRIMARY KEY (BROKER_STATUS_ID),
    CONSTRAINT FK_BROKER_STATUS_BROKER_ID FOREIGN KEY (BROKER_ID) REFERENCES BROKER(BROKER_ID)
);

------------------------------------------------------
 BROKER_RENEW
------------------------------------------------------

CREATE TABLE  BROKER_RENEW(
    BROKER_RENEW_ID number(10) NOT NULL,
    BROKER_ID NUMBER(5,0) NOT NULL,
    RENEW_DATE DATE,                        -- TREC_REG_BACKUP.RENEWDATE 
    EXPIRY_DATE DATE,                       -- TREC_REG_BACKUP.EXPDATE 
	REMARKS VARCHAR2(500 CHAR),

    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    ADDED_AT DATE DEFAULT sysdate NOT NULL,
    ADDED_BY VARCHAR2(50) NOT NULL,
    UPDATED_AT DATE,
    UPDATED_BY VARCHAR2(50),
	
    constraint PK_BROKER_RENEW_ID PRIMARY key (BROKER_RENEW_ID),
    constraint FK_BROKER_RENEW_BROKER_ID foreign key (BROKER_ID) references BROKER(BROKER_ID)
);

------------------------------------------------------
 VW_BROKER
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TREC_TREC"."VW_BROKER" 
("TREC_ID", "TREC_NO", "TREC_CODE", "TREC_NAME", 
 "BROKER_ID",  "BACKUP_ID", "BSEC_REG_NO", "BSEC_REG_ISSUANCE_DATE", "LICESE_TYPE", "LICESE_PATH", "REMARKS", "ADDED_AT", "ADDED_BY", 
 "BROKER_STATUS_ID", "STATUS", "STATUS_EFFECTIVE_DATE", "STATUS_END_DATE", "IS_ACTIVE",
 "BROKER_RENEW_ID", "RENEW_DATE", "EXPIRY_DATE"
 ) AS 
 
SELECT
    t.TREC_ID,
    t.TREC_NO,
    t.CODE as TREC_CODE,
    t.NAME as TREC_NAME,

    bk.BROKER_ID,
    bk.BACKUP_ID,
    bk.BSEC_REG_NO,
    bk.BSEC_REG_ISSUANCE_DATE,
    bk.LICESE_TYPE,
    bk.LICESE_PATH,
    bk.REMARKS,
    bk.ADDED_AT,
    bk.ADDED_BY,

    st.BROKER_STATUS_ID,
    st.STATUS,
    st.EFFECTIVE_DATE as STATUS_EFFECTIVE_DATE,
    st.END_DATE as STATUS_END_DATE,
    CASE WHEN st.STATUS IN ('CANCELLED') THEN 0 ELSE 1 END AS IS_ACTIVE,

    ln.BROKER_RENEW_ID,
    ln.RENEW_DATE,
    ln.EXPIRY_DATE
    
FROM  BROKER bk
INNER JOIN BROKER_STATUS st ON bk.BROKER_ID = st.BROKER_ID and st.IS_ACTIVE=1
INNER JOIN BROKER_RENEW ln ON bk.BROKER_ID = ln.BROKER_ID and ln.IS_ACTIVE=1
INNER JOIN TREC t ON bk.TREC_ID = t.TREC_ID
ORDER BY bk.BROKER_ID;

select * from VW_BROKER;

------------------------------------------------------
 VW_BROKER_STATUS
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TREC_TREC"."VW_BROKER_STATUS" 
("TREC_ID", "TREC_NO", "TREC_CODE", "TREC_NAME", 
 "BROKER_ID",  "BACKUP_ID",  "BSEC_REG_NO", "BSEC_REG_ISSUANCE_DATE", "LICESE_TYPE", "LICESE_PATH", 
 "BROKER_STATUS_ID", "STATUS", "STATUS_EFFECTIVE_DATE", "STATUS_END_DATE", "REMARKS", "IS_ACTIVE", "ADDED_AT", "ADDED_BY",
 "BROKER_RENEW_ID", "RENEW_DATE", "EXPIRY_DATE"
 ) AS 
 
SELECT
    t.TREC_ID,
    t.TREC_NO,
    t.CODE as TREC_CODE,
    t.NAME as TREC_NAME,

    bk.BROKER_ID,
    bk.BACKUP_ID,
    bk.BSEC_REG_NO,
    bk.BSEC_REG_ISSUANCE_DATE,
    bk.LICESE_TYPE,
    bk.LICESE_PATH,

    st.BROKER_STATUS_ID,
    st.STATUS,
    st.EFFECTIVE_DATE as STATUS_EFFECTIVE_DATE,
    st.END_DATE as STATUS_END_DATE,
    st.REMARKS,
    st.IS_ACTIVE,
    st.ADDED_AT,
    st.ADDED_BY,
    
    ln.BROKER_RENEW_ID,
    ln.RENEW_DATE,
    ln.EXPIRY_DATE

FROM  BROKER bk
INNER JOIN BROKER_STATUS st ON bk.BROKER_ID = st.BROKER_ID 
INNER JOIN BROKER_RENEW ln ON bk.BROKER_ID = ln.BROKER_ID and ln.IS_ACTIVE=1
INNER JOIN TREC t ON bk.TREC_ID = t.TREC_ID
ORDER BY bk.BROKER_ID;


select * from VW_BROKER_STATUS;
select count (BROKER_ID) from BROKER; -- 12476
select count (BROKER_ID) from BROKER_STATUS_HIST; -- 9
select count(*) from VW_BROKER_STATUS; -- 12485
select * from VW_BROKER_STATUS where BROKER_ID=7;

select count (*), status from VW_BROKER_STATUS  group by status;
select count (*),  status from VW_BROKER_STATUS where EFFECTIVE_DATE >= '01-JAN-2022'  group by status;
select count (*) from VW_BROKER_STATUS where status ='SUSPENDED' and EFFECTIVE_DATE >= '01-JAN-2022';
select * from VW_BROKER_STATUS where status ='ACTIVE' and EFFECTIVE_DATE >= '01-JAN-2022';


------------------------------------------------------
 VW_BROKER_RENEW
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TREC_TREC"."VW_BROKER_RENEW" 
("TREC_ID", "TREC_NO", "TREC_CODE", "TREC_NAME", 
 "BROKER_ID",  "BACKUP_ID", "BSEC_REG_NO", "BSEC_REG_ISSUANCE_DATE", "LICESE_TYPE", "LICESE_PATH",
 "BROKER_STATUS_ID", "STATUS", "STATUS_EFFECTIVE_DATE", "STATUS_END_DATE", 
 "BROKER_RENEW_ID", "RENEW_DATE", "EXPIRY_DATE", "IS_ACTIVE", "REMARKS", "ADDED_AT", "ADDED_BY"
 ) AS 
 
SELECT
    t.TREC_ID,
    t.TREC_NO,
    t.CODE as TREC_CODE,
    t.NAME as TREC_NAME,

    bk.BROKER_ID,
    bk.BACKUP_ID,
    bk.BSEC_REG_NO,
    bk.BSEC_REG_ISSUANCE_DATE,
    bk.LICESE_TYPE,
    bk.LICESE_PATH,

    st.BROKER_STATUS_ID,
    st.STATUS,
    st.EFFECTIVE_DATE as STATUS_EFFECTIVE_DATE,
    st.END_DATE as STATUS_END_DATE,
    
    ln.BROKER_RENEW_ID,
    ln.RENEW_DATE,
    ln.EXPIRY_DATE,
    ln.IS_ACTIVE,
    ln.REMARKS,
    ln.ADDED_AT,
    ln.ADDED_BY

FROM  BROKER bk
INNER JOIN BROKER_RENEW ln ON bk.BROKER_ID = ln.BROKER_ID 
INNER JOIN BROKER_STATUS st ON bk.BROKER_ID = st.BROKER_ID and st.IS_ACTIVE=1
INNER JOIN TREC t ON bk.TREC_ID = t.TREC_ID
ORDER BY bk.BROKER_ID;

select * from VW_BROKER_RENEW;

------------------------------------------------------

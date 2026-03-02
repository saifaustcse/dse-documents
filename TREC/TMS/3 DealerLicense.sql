--------------------------------------------------------------------------------

delete from DEALER;
commit;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'DEALER'
    AND constraint_type IN ('P', 'U')
);

delete from DEALER_STATUS;
delete from DEALER_RENEW;
delete from DEALER;
commit;

-- Drop the foreign key constraints for each table and key
ALTER TABLE DEALER_REMINDER DROP CONSTRAINT FK_DEALER_REMINDER_DEALER_ID;

-- ADD the foreign key constraints for each table and key
ALTER TABLE DEALER_REMINDER ADD CONSTRAINT FK_DEALER_REMINDER_DEALER_ID
FOREIGN KEY (DEALER_ID) REFERENCES DEALER (DEALER_ID);

--------------------------------------------------------------------------------
TREC_TREC.DEALER
--------------------------------------------------------------------------------

CREATE TABLE TREC_TREC.DEALER
(
    DEALER_ID NUMBER(5,0) NOT NULL,         -- auto increment id 
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

    CONSTRAINT PK_DEALER_ID PRIMARY KEY (DEALER_ID),
    CONSTRAINT FK_DEALER_TREC FOREIGN KEY (TREC_ID) REFERENCES TREC_TREC.TREC (TREC_ID)
);

------------------------------------------------------
  DEALER_STATUS
------------------------------------------------------

CREATE TABLE DEALER_STATUS(
    DEALER_STATUS_ID NUMBER(10,0) NOT NULL,
	DEALER_ID NUMBER(5,0) NOT NULL,
    STATUS VARCHAR2(50) NOT NULL,
    EFFECTIVE_DATE DATE,
    END_DATE DATE,
	REMARKS VARCHAR2(255),		

    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    ADDED_AT DATE DEFAULT sysdate NOT NULL,
    ADDED_BY VARCHAR2(50) NOT NULL,
    UPDATED_AT DATE,
    UPDATED_BY VARCHAR2(50),

    CONSTRAINT PK_DEALER_STATUS_ID PRIMARY KEY (DEALER_STATUS_ID),
    CONSTRAINT FK_DEALER_STATUS_DEALER_ID FOREIGN KEY (DEALER_ID) REFERENCES DEALER(DEALER_ID)
);

------------------------------------------------------
 DEALER_RENEW
------------------------------------------------------

CREATE TABLE  DEALER_RENEW(
    DEALER_RENEW_ID number(10) NOT NULL,
    DEALER_ID NUMBER(5,0) NOT NULL,
    RENEW_DATE DATE,                        -- TREC_REG_BACKUP.RENEWDATE 
    EXPIRY_DATE DATE,                       -- TREC_REG_BACKUP.EXPDATE 
	REMARKS VARCHAR2(500 CHAR),

    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    ADDED_AT DATE DEFAULT sysdate NOT NULL,
    ADDED_BY VARCHAR2(50) NOT NULL,
    UPDATED_AT DATE,
    UPDATED_BY VARCHAR2(50),
	
    constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
 VW_DEALER
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TREC_TREC"."VW_DEALER" 
("TREC_ID", "TREC_NO", "TREC_CODE", "TREC_NAME", 
 "DEALER_ID",  "BACKUP_ID", "BSEC_REG_NO", "BSEC_REG_ISSUANCE_DATE", "LICESE_TYPE", "LICESE_PATH", "REMARKS", "ADDED_AT", "ADDED_BY", 
 "DEALER_STATUS_ID", "STATUS", "STATUS_EFFECTIVE_DATE", "STATUS_END_DATE", "IS_ACTIVE",
 "DEALER_RENEW_ID", "RENEW_DATE", "EXPIRY_DATE"
 ) AS 
 
SELECT
    t.TREC_ID,
    t.TREC_NO,
    t.CODE as TREC_CODE,
    t.NAME as TREC_NAME,

    bk.DEALER_ID,
    bk.BACKUP_ID,
    bk.BSEC_REG_NO,
    bk.BSEC_REG_ISSUANCE_DATE,
    bk.LICESE_TYPE,
    bk.LICESE_PATH,
    bk.REMARKS,
    bk.ADDED_AT,
    bk.ADDED_BY,

    st.DEALER_STATUS_ID,
    st.STATUS,
    st.EFFECTIVE_DATE as STATUS_EFFECTIVE_DATE,
    st.END_DATE as STATUS_END_DATE,
    CASE WHEN st.STATUS IN ('CANCELLED') THEN 0 ELSE 1 END AS IS_ACTIVE,

    ln.DEALER_RENEW_ID,
    ln.RENEW_DATE,
    ln.EXPIRY_DATE
    
FROM  DEALER bk
INNER JOIN DEALER_STATUS st ON bk.DEALER_ID = st.DEALER_ID and st.IS_ACTIVE=1
INNER JOIN DEALER_RENEW ln ON bk.DEALER_ID = ln.DEALER_ID and ln.IS_ACTIVE=1
INNER JOIN TREC t ON bk.TREC_ID = t.TREC_ID
ORDER BY bk.DEALER_ID;

select * from VW_DEALER;

------------------------------------------------------
 VW_DEALER_STATUS
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TREC_TREC"."VW_DEALER_STATUS" 
("TREC_ID", "TREC_NO", "TREC_CODE", "TREC_NAME", 
 "DEALER_ID",  "BACKUP_ID",  "BSEC_REG_NO", "BSEC_REG_ISSUANCE_DATE", "LICESE_TYPE", "LICESE_PATH", 
 "DEALER_STATUS_ID", "STATUS", "STATUS_EFFECTIVE_DATE", "STATUS_END_DATE", "REMARKS", "IS_ACTIVE", "ADDED_AT", "ADDED_BY",
 "DEALER_RENEW_ID", "RENEW_DATE", "EXPIRY_DATE"
 ) AS 
 
SELECT
    t.TREC_ID,
    t.TREC_NO,
    t.CODE as TREC_CODE,
    t.NAME as TREC_NAME,

    bk.DEALER_ID,
    bk.BACKUP_ID,
    bk.BSEC_REG_NO,
    bk.BSEC_REG_ISSUANCE_DATE,
    bk.LICESE_TYPE,
    bk.LICESE_PATH,

    st.DEALER_STATUS_ID,
    st.STATUS,
    st.EFFECTIVE_DATE as STATUS_EFFECTIVE_DATE,
    st.END_DATE as STATUS_END_DATE,
    st.REMARKS,
    st.IS_ACTIVE,
    st.ADDED_AT,
    st.ADDED_BY,
    
    ln.DEALER_RENEW_ID,
    ln.RENEW_DATE,
    ln.EXPIRY_DATE

FROM  DEALER bk
INNER JOIN DEALER_STATUS st ON bk.DEALER_ID = st.DEALER_ID 
INNER JOIN DEALER_RENEW ln ON bk.DEALER_ID = ln.DEALER_ID and ln.IS_ACTIVE=1
INNER JOIN TREC t ON bk.TREC_ID = t.TREC_ID
ORDER BY bk.DEALER_ID;


select * from VW_DEALER_STATUS;
select count (DEALER_ID) from DEALER; -- 12476
select count (DEALER_ID) from DEALER_STATUS_HIST; -- 9
select count(*) from VW_DEALER_STATUS; -- 12485
select * from VW_DEALER_STATUS where DEALER_ID=7;

select count (*), status from VW_DEALER_STATUS  group by status;
select count (*),  status from VW_DEALER_STATUS where EFFECTIVE_DATE >= '01-JAN-2022'  group by status;
select count (*) from VW_DEALER_STATUS where status ='SUSPENDED' and EFFECTIVE_DATE >= '01-JAN-2022';
select * from VW_DEALER_STATUS where status ='ACTIVE' and EFFECTIVE_DATE >= '01-JAN-2022';


------------------------------------------------------
 VW_DEALER_RENEW
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TREC_TREC"."VW_DEALER_RENEW" 
("TREC_ID", "TREC_NO", "TREC_CODE", "TREC_NAME", 
 "DEALER_ID",  "BACKUP_ID", "BSEC_REG_NO", "BSEC_REG_ISSUANCE_DATE", "LICESE_TYPE", "LICESE_PATH",
 "DEALER_STATUS_ID", "STATUS", "STATUS_EFFECTIVE_DATE", "STATUS_END_DATE", 
 "DEALER_RENEW_ID", "RENEW_DATE", "EXPIRY_DATE", "IS_ACTIVE", "REMARKS", "ADDED_AT", "ADDED_BY"
 ) AS 
 
SELECT
    t.TREC_ID,
    t.TREC_NO,
    t.CODE as TREC_CODE,
    t.NAME as TREC_NAME,

    bk.DEALER_ID,
    bk.BACKUP_ID,
    bk.BSEC_REG_NO,
    bk.BSEC_REG_ISSUANCE_DATE,
    bk.LICESE_TYPE,
    bk.LICESE_PATH,

    st.DEALER_STATUS_ID,
    st.STATUS,
    st.EFFECTIVE_DATE as STATUS_EFFECTIVE_DATE,
    st.END_DATE as STATUS_END_DATE,
    
    ln.DEALER_RENEW_ID,
    ln.RENEW_DATE,
    ln.EXPIRY_DATE,
    ln.IS_ACTIVE,
    ln.REMARKS,
    ln.ADDED_AT,
    ln.ADDED_BY

FROM  DEALER bk
INNER JOIN DEALER_RENEW ln ON bk.DEALER_ID = ln.DEALER_ID 
INNER JOIN DEALER_STATUS st ON bk.DEALER_ID = st.DEALER_ID and st.IS_ACTIVE=1
INNER JOIN TREC t ON bk.TREC_ID = t.TREC_ID
ORDER BY bk.DEALER_ID;

select * from VW_DEALER_RENEW;

------------------------------------------------------

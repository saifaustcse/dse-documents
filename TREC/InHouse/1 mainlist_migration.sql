SELECT ROW_NUMBER() OVER (Order by mem_no) AS id, * FROM [InHouse].[dbo].[mainlist] order by mem_no,xferno asc;
SELECT count(*)  FROM [InHouse].[dbo].mainlist ;-- 597

------------------------------------------------------------------
--delete from TREC_BACKUP;
commit;
select count(*) from TREC_BACKUP; -- 597

---------------------TREC_BACKUP----------------------------------

CREATE TABLE TREC_BACKUP ( 
ID NUMBER(10),
MEM_NO NUMBER(10),
XFERNO NUMBER(10),
BROKERID VARCHAR2(50),
SLOCATION VARCHAR2(255),
INST_TWS VARCHAR2(50),
NON_TRD_VR VARCHAR2(50),
LAN_WAN VARCHAR2(50),
BKR_ID VARCHAR2(50),
PHONE_PABX VARCHAR2(100),
SUSPEND VARCHAR2(50),
BRANCH VARCHAR2(50),
DSEAPVDATE VARCHAR2(50),
OWNER_CATE VARCHAR2(50),
MOBILE VARCHAR2(50),
E_MAIL VARCHAR2(150),
WEBSITE VARCHAR2(100),
PHOTO VARCHAR2(50),
SIGN VARCHAR2(255),
COM_NAME VARCHAR2(255),
OWNER VARCHAR2(255),
FAX VARCHAR2(50),
AUTHNO VARCHAR2(50),
SECURITY VARCHAR2(50),
MSABKUP VARCHAR2(50),
TWSINHEAD VARCHAR2(50),
PUPCAPITAL VARCHAR2(50),
DEALERSHIP VARCHAR2(50),
BRANCH_OFF nclob,
ADREMARKS nclob,
LOCATION VARCHAR2(255),
PHONE_OFF VARCHAR2(999),
PHONE_RES VARCHAR2(100),
REMARKS VARCHAR2(500),
FULLREMARK nclob,
SERVER_CONF VARCHAR2(500),
AUTHCAPITAL VARCHAR2(500),
NETCAPITALBALANCE VARCHAR2(50),
NETWORTH VARCHAR2(50),
NETPROFIT VARCHAR2(50),
COMOFF VARCHAR2(100),
COMOFFDESIGNATION VARCHAR2(50),
YEAREND VARCHAR2(50));


-------------------------------------------DELETE--------------------------------------------------------

delete from TREC;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'TREC'
    AND constraint_type IN ('P', 'U')
);

-------------------------------------------INSERT TREC--------------------------------------------------------

select count(*) from TREC_BACKUP where MEM_NO < 200000 order by MEM_NO; --312
select count(*) from TREC order by trec_no asc; --312

insert into TREC (TREC_ID, TREC_NO, CODE, NAME, SECURITY_DEPOSIT, WEBSITE, FULLREMARK, REMARKS, STATUS, CATEGORY , ADDED_BY )
select
    TO_NUMBER(MEM_NO) as TREC_ID, 
    TO_NUMBER(MEM_NO) as TREC_NO, 
    SUBSTR(BROKERID, 1, 3) As CODE,
    TRIM(COM_NAME) As NAME,
    TRIM(SECURITY) As SECURITY_DEPOSIT,
    TRIM(WEBSITE) as WEBSITE ,
    TRIM(FULLREMARK) as FULLREMARK,
    TRIM(REMARKS) as REMARKS,
    case suspend
    when 'Y' then 'SUSPENDED'
    when 'N' then 'ACTIVE'
    when 'NULL' then 'ACTIVE'
    end as STATUS , 
    'Other' as CATEGORY,
    496 as ADDED_BY
from TREC_BACKUP where TO_NUMBER(MEM_NO) < 200000  and TO_NUMBER(MEM_NO) NOT IN (select TREC_ID from TREC) order by ID ;
-- 312 rows inserted.
commit;

select * from TREC where STATUS='SUSPENDED'; -- 10
select * from TREC_BACKUP where SUSPEND ='Y' and MEM_NO< 600 order by MEM_NO;   -- 10
SELECT * FROM TREC where TREC_ID in (select MEM_NO from TREC_BACKUP where SUSPEND ='Y') order by trec_id;   -- 10

-------------------------------------------INSERT TREC_STATUS--------------------------------------------------------

--delete from TREC_STATUS;
select * from TREC_STATUS order by TREC_ID asc;

insert into TREC_STATUS (TREC_STATUS_ID, TREC_ID, STATUS, EFFECTIVE_DATE, ADDED_AT, ADDED_BY )
select ROWNUM, r.TREC_ID, r.STATUS, r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY from 
(
SELECT  
    a.TREC_ID, 
    a.STATUS,
    CASE WHEN b.REGDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE,
    a.ADDED_AT,
    a.ADDED_BY
FROM TREC a LEFT JOIN TREC_REG_BACKUP b ON a.TREC_ID = b.MEM_NO 
order by a.TREC_ID
) r;
-- 312 rows inserted.
commit;

select * from TREC_STATUS where EFFECTIVE_DATE is null;
update TREC_STATUS  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 4 rows updated
commit;

-------------------------------------------INSERT TREC_CODE--------------------------------------------------------

--delete from TREC_CODE;
select * from TREC_CODE order by TREC_ID asc;

insert into TREC_CODE (TREC_CODE_ID, TREC_ID, CODE, EFFECTIVE_DATE, ADDED_AT, ADDED_BY )
select ROWNUM, r.TREC_ID, r.CODE, r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY from 
(
SELECT  
    a.TREC_ID, 
    a.CODE,
    CASE WHEN b.REGDATE = 'NULL' THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE,
    a.ADDED_AT,
    a.ADDED_BY
FROM TREC a LEFT JOIN TREC_REG_BACKUP b ON a.TREC_ID = b.MEM_NO 
order by a.TREC_ID
) r;
-- 312 rows inserted.
commit;

select * from TREC_CODE where EFFECTIVE_DATE is null;
update TREC_CODE  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 4 rows updated
commit;

-------------------------------------------INSERT TREC_NAME--------------------------------------------------------

--delete from TREC_NAME;
select * from TREC_NAME order by TREC_ID asc;

insert into TREC_NAME (TREC_NAME_ID, TREC_ID, NAME, EFFECTIVE_DATE, ADDED_AT, ADDED_BY )
select ROWNUM, r.TREC_ID, r.NAME, r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY from 
(
SELECT  
    a.TREC_ID, 
    a.NAME,
    CASE WHEN b.REGDATE = 'NULL' THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE,
    a.ADDED_AT,
    a.ADDED_BY
FROM TREC a LEFT JOIN TREC_REG_BACKUP b ON a.TREC_ID = b.MEM_NO 
order by a.TREC_ID
) r;
-- 312 rows inserted.
commit;

select * from TREC_NAME where EFFECTIVE_DATE is null;
update TREC_NAME  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 4 rows updated
commit;

-------------------------------------------INSERT OFFICE--------------------------------------------------------

--delete from OFFICE;
select * from OFFICE order by TREC_ID asc;
select * from trec where trec_id not in (select trec_id from office); -- 3

insert into OFFICE (OFFICE_ID, TREC_ID, OFFICE_NO, BSEC_APPROVAL_DATE, ADDED_BY)
select ROWNUM as OFFICE_ID, r.TREC_ID, r.OFFICE_NO, r.BROKER_REGDATE, 496 as ADDED_BY
from (
select
  TO_NUMBER(b.MEM_NO) as TREC_ID, 
  --1 as OFFICE_NO,
  0 as OFFICE_NO,
  CASE WHEN b.REGDATE = 'NULL' THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE
from TREC_REG_BACKUP b
where TO_NUMBER(b.MEM_NO) < 200000
order by b.MEM_NO asc
) r;

 --309 rows inserted.
commit;

-------------------------------------------INSERT OFFICE_STATUS--------------------------------------------------------

--delete from OFFICE_STATUS;
select * from OFFICE_STATUS order by OFFICE_ID asc;

insert into OFFICE_STATUS (OFFICE_STATUS_ID, OFFICE_ID, STATUS, EFFECTIVE_DATE, ADDED_AT, ADDED_BY)
select ROWNUM as OFFICE_STATUS_ID, r.OFFICE_ID, 'ACTIVE', r.EFFECTIVE_DATE, r.ADDED_AT, r.ADDED_BY 
from (
select
    o.OFFICE_ID, 
    o.BSEC_APPROVAL_DATE as EFFECTIVE_DATE,
    o.ADDED_AT,
    o.ADDED_BY
from OFFICE o
order by o.TREC_ID asc
) r;

 --309 rows inserted.
commit;

select * from OFFICE_STATUS where EFFECTIVE_DATE is null;
update OFFICE_STATUS  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 2 rows updated
commit;

-------------------------------------------INSERT OFFICE_TYPE--------------------------------------------------------

--delete from OFFICE_TYPE;
select * from OFFICE_TYPE order by OFFICE_ID asc;

insert into OFFICE_TYPE (OFFICE_TYPE_ID, OFFICE_ID, TYPE, EFFECTIVE_DATE, ADDED_AT, ADDED_BY)
select ROWNUM as OFFICE_TYPE_ID, r.OFFICE_ID, 'HEAD', r.EFFECTIVE_DATE, r.ADDED_AT, r.ADDED_BY 
from (
select
    o.OFFICE_ID, 
    o.BSEC_APPROVAL_DATE as EFFECTIVE_DATE,
    o.ADDED_AT,
    o.ADDED_BY
from OFFICE o
order by o.TREC_ID asc
) r;

 --309 rows inserted.
commit;

select * from OFFICE_TYPE where EFFECTIVE_DATE is null;
update OFFICE_TYPE  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 1 rows updated
commit;

-------------------------------------------INSERT OFFICE_ADDRESS--------------------------------------------------------

--delete from OFFICE_ADDRESS;
select * from OFFICE_ADDRESS order by OFFICE_ID asc;

insert into OFFICE_ADDRESS (OFFICE_ADDRESS_ID, OFFICE_ID, LOCATION, AREA, OPERATION_START_DATE, ADDED_BY  )
select ROWNUM as OFFICE_ADDRESS_ID, r.OFFICE_ID, r.LOCATION, r.AREA, r.EFFECTIVE_DATE,  496 as ADDED_BY  
from (
select
    o.OFFICE_ID, 
    o.BSEC_APPROVAL_DATE as EFFECTIVE_DATE,
    o.ADDED_AT,
    o.ADDED_BY,
    --1 as OFFICE_NO,
    0 as OFFICE_NO,
    trim(b.location) as LOCATION,
    trim(b.slocation) as AREA
from OFFICE o
JOIN TREC_BACKUP b ON o.TREC_ID = b.MEM_NO 
order by o.OFFICE_ID asc
) r;

 --309 rows inserted.
commit;

select * from OFFICE_ADDRESS where OPERATION_START_DATE is null;
update OFFICE_ADDRESS  set OPERATION_START_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where OPERATION_START_DATE is null;
-- 1 rows updated
commit;

-------------------------------------------INSERT PERSONNEL--------------------------------------------------------

select * from TREC_BACKUP where OWNER is null;
update TREC_BACKUP set OWNER ='.' where OWNER is null;
-- 47 rows updated
commit;

--delete from PERSONNEL;
select * from PERSONNEL order by trec_id asc;

insert into PERSONNEL (PERSONNEL_ID, TREC_ID, NAME, DESIGNATION, IMAGE_PATH, SIGNATURE_PATH, OFFICIAL_EMAIL, PERSONAL_CONTACT_NO, OFFICIAL_CONTACT_NO,FAX, TEMP_DATA, STATUS, ADDED_BY )
select ROWNUM as PERSONNEL_ID,  l.TREC_ID, NVL(l.OWNER, 'Not Found'), l.OWNER_CATE,  l.PHOTO, l.SIGN, l.E_MAIL, l.MOBILE, l.PHONE_OFF, l.FAX , l.TEMP_DATA , l.STATUS , 496 from
(
select 
    TO_NUMBER(ID), 
    TO_NUMBER(MEM_NO) as  TREC_ID, 
    OWNER,
    OWNER_CATE, 
    PHOTO, 
    SIGN, 
    E_MAIL, 
    MOBILE, 
    PHONE_OFF, 
    FAX, 
    'TREC_HLDR_REPRESENT' as TEMP_DATA, 
    'ACTIVE' as STATUS  
from TREC_BACKUP 
where MEM_NO IN(select TO_CHAR(trec_no) from TREC)
and MEM_NO <333
order by ID
) l;

 --309 rows inserted
commit;

-------------------------------------------INSERT TREC_HLDR_REPRESENT--------------------------------------------------------

--delete from TREC_HLDR_REPRESENT;
select * from TREC_HLDR_REPRESENT order by trec_id asc;

insert into TREC_HLDR_REPRESENT (TREC_HLDR_REPRESENT_ID, TREC_ID, PERSONNEL_ID, EFFECTIVE_DATE, ADDED_AT,ADDED_BY )
select ROWNUM, r.TREC_ID, r.PERSONNEL_ID, r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY from 
(
select  
    pi.TREC_ID, 
    pi.PERSONNEL_ID,
    pi.ADDED_AT,
    pi.ADDED_BY,
    CASE WHEN b.REGDATE = 'NULL' THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE
from PERSONNEL  pi 
LEFT JOIN TREC_REG_BACKUP b ON pi.TREC_ID = b.MEM_NO 
where pi.TEMP_DATA='TREC_HLDR_REPRESENT'
) r;

--309 rows inserted.
commit;

select * from TREC_HLDR_REPRESENT where EFFECTIVE_DATE is null;
update TREC_HLDR_REPRESENT  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 1 rows updated
commit;

-------------------------------------------INSERT PERSONNEL--------------------------------------------------------

select * from TREC_BACKUP where COMOFF is null;
update TREC_BACKUP set COMOFF ='.' where COMOFF is null;
-- 75 rows updated.
commit;

select * from PERSONNEL order by trec_id asc;
--delete from PERSONNEL pi where pi.TEMP_DATA='TREC_COMPLIANCE_AUTH';

insert into PERSONNEL (PERSONNEL_ID, TREC_ID, NAME, DESIGNATION, TEMP_DATA, STATUS, ADDED_BY, ADDED_AT )
select (ROWNUM+ (select max(PERSONNEL_ID) from PERSONNEL)) as  PERSONNEL_ID,  l.TREC_ID, NVL(l.COMOFF, 'Not Found'), l.COMOFFDESIGNATION, l.TEMP_DATA, l.STATUS , 496, SYSDATE from
(
select 
    TO_NUMBER(ID), 
    TO_NUMBER(MEM_NO) as TREC_ID, 
    COMOFF, 
    COMOFFDESIGNATION, 
    'TREC_COMPLIANCE_AUTH' as TEMP_DATA, 
    'ACTIVE' as STATUS  from TREC_BACKUP 
where  MEM_NO  IN(select TO_CHAR(trec_no) from TREC) 
and MEM_NO <333
order by ID
) l;

--309 rows inserted.
commit;

-------------------------------------------INSERT TREC_COMPLIANCE_AUTH--------------------------------------------------------

--delete from TREC_COMPLIANCE_AUTH;
select * from TREC_COMPLIANCE_AUTH order by trec_id asc;

insert into TREC_COMPLIANCE_AUTH (TREC_COMP_AUTH_ID, TREC_ID, PERSONNEL_ID, EFFECTIVE_DATE, ADDED_AT, ADDED_BY )
select ROWNUM, r.TREC_ID, r.PERSONNEL_ID, r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY
from (
select  
    pi.TREC_ID,
    pi.PERSONNEL_ID,
    pi.ADDED_AT,
    pi.ADDED_BY,
    CASE WHEN b.REGDATE = 'NULL' THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE
from PERSONNEL  pi 
LEFT JOIN TREC_REG_BACKUP b ON pi.TREC_ID = b.MEM_NO 
where pi.TEMP_DATA='TREC_COMPLIANCE_AUTH'
) r;

--309 rows inserted.
commit;

select * from TREC_COMPLIANCE_AUTH where EFFECTIVE_DATE is null;
update TREC_COMPLIANCE_AUTH  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 1 rows updated
commit;

-------------------------------------------INSERT TREC_AUTHORISED_CAPITAL--------------------------------------------------------

--delete from TREC_AUTHORISED_CAPITAL;
select * from TREC_AUTHORISED_CAPITAL order by trec_id asc;

SELECT ID, MEM_NO, AUTHCAPITAL FROM TREC_BACKUP WHERE  NOT REGEXP_LIKE(AUTHCAPITAL, '^-?\d+(\.\d+)?$');
update  TREC_BACKUP set AUTHCAPITAL = 0 where NOT REGEXP_LIKE(AUTHCAPITAL, '^-?\d+(\.\d+)?$');
-- 217 rows updated.
commit;

INSERT INTO TREC_AUTHORISED_CAPITAL (AUTHORISED_CAP_ID, TREC_ID, AUTHORISED_CAPITAL, IS_ACTIVE, ADDED_BY, ADDED_AT)
SELECT
    ROWNUM AS AUTHORISED_CAP_ID,
    l.TREC_ID,
    CASE
        WHEN l.AUTHCAPITAL IS NOT NULL THEN TO_NUMBER(l.AUTHCAPITAL)
        ELSE 0
    END AS AUTHORISED_CAPITAL,
    1 AS IS_ACTIVE,
    496 AS ADDED_BY,
    SYSDATE AS ADDED_AT
FROM (
    SELECT TO_NUMBER(ID) AS ID, 
    TO_NUMBER(MEM_NO) AS TREC_ID,
    AUTHCAPITAL
    FROM TREC_BACKUP
    WHERE MEM_NO IN (SELECT TO_CHAR(trec_no) FROM TREC)
    and MEM_NO <333
    ORDER BY ID
) l;

--309 rows inserted.
commit;

-------------------------------------------INSERT TREC_PAIDUP_CAPITAL--------------------------------------------------------

--delete from TREC_PAIDUP_CAPITAL;
select * from TREC_PAIDUP_CAPITAL order by trec_id asc;

SELECT ID, MEM_NO, PUPCAPITAL FROM TREC_BACKUP WHERE  NOT REGEXP_LIKE(PUPCAPITAL, '^-?\d+(\.\d+)?$');
update  TREC_BACKUP set PUPCAPITAL = 0 where NOT REGEXP_LIKE(PUPCAPITAL, '^-?\d+(\.\d+)?$');

-- 136 rows updated.
commit;


INSERT INTO TREC_PAIDUP_CAPITAL (PAIDUP_CAP_ID, TREC_ID, PAID_UP_CAPITAL, IS_ACTIVE, ADDED_BY, ADDED_AT)
SELECT
    ROWNUM AS PAIDUP_CAPITAL_ID,
    l.TREC_ID,
    CASE
        WHEN l.PUPCAPITAL IS NOT NULL THEN TO_NUMBER(l.PUPCAPITAL)
        ELSE 0
    END AS PAID_UP_CAPITAL,
    1 AS IS_ACTIVE,
    496 AS ADDED_BY,
    SYSDATE AS ADDED_AT
FROM (
    SELECT TO_NUMBER(ID) AS ID, 
    TO_NUMBER(MEM_NO) AS TREC_ID,
    PUPCAPITAL
    FROM TREC_BACKUP
    WHERE MEM_NO IN (SELECT TO_CHAR(trec_no) FROM TREC)
    and MEM_NO <333
    ORDER BY ID
) l;

--309 rows inserted
commit;


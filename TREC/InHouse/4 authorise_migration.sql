

SELECT ROW_NUMBER() OVER (Order by mem_no) AS id, * FROM [InHouse].[dbo].[authorise] order by mem_no, xferno asc;
SELECT count(*)  FROM [InHouse].[dbo].[authorise] ;-- 12876

------------------------------------------------------------------
--delete from AUTH_REP_BACKUP;
commit;
select count(*) from AUTH_REP_BACKUP; -- 12876

--------------------------AUTH_REP_BACKUP---------------------------------------

CREATE TABLE AUTH_REP_BACKUP ( 
ID NUMBER(10),
MEM_NO VARCHAR2(10),
XFERNO VARCHAR2(10),
AUTHNAME VARCHAR2(255),
AUTHNO VARCHAR2(50),
AUTHID VARCHAR2(50),
SECREGNO VARCHAR2(50),
SECLICENCE VARCHAR2(30),
DSEAPVDATE VARCHAR2(50),
REGDATE VARCHAR2(50),
EXPDATE VARCHAR2(50),
RENEWDATE VARCHAR2(50),
REMINDDATE VARCHAR2(50),
APPDATE VARCHAR2(50),
STATUS VARCHAR2(10),
ACTIONDATE VARCHAR2(50),
PHOTO VARCHAR2(50),
REMARK VARCHAR2(500),
IMGINREPORT VARCHAR2(4),
FATHERSNAME VARCHAR2(50),
MOTHERSNAME VARCHAR2(50),
PERMANENTADDRESS VARCHAR2(10),
PRESENTADDRESS VARCHAR2(10),
NID VARCHAR2(50),
MOBILE VARCHAR2(50),
TCNO VARCHAR2(50),
TCISSUEDATE VARCHAR2(50),
TCRENEWDATE VARCHAR2(50));


-------------------------------PERSONNEL--------------------------------------------

CREATE TABLE PERSONNEL (
    PERSONNEL_ID          NUMBER(10) NOT NULL,
    TREC_ID                    NUMBER(5) NOT NULL,      -- AUTH_REP_BACKUP.MEM_NO
    BACKUP_ID                  VARCHAR2(50 CHAR),
    NAME                       VARCHAR2(255),           -- AUTH_REP_BACKUP.AUTHNAME
    SEX                        VARCHAR2(50 CHAR),
    DATE_OF_BIRTH              DATE,
    NAME_OF_FATHER             VARCHAR2(255 CHAR),       -- AUTH_REP_BACKUP.FATHERSNAME
    NAME_OF_MOTHER             VARCHAR2(255 CHAR),       -- AUTH_REP_BACKUP.MOTHERSNAME
    NAME_OF_SPOUSE             VARCHAR2(255 CHAR),
    MAX_EDU_QUALIFICATION      VARCHAR2(255 CHAR),
    PRESENT_ADDRESS            VARCHAR2(255 CHAR),       -- AUTH_REP_BACKUP.PRESENTADDRESS
    PERMANENT_ADDRESS          VARCHAR2(255 CHAR),       -- AUTH_REP_BACKUP.PRESENTADDRESS
    NID                        VARCHAR2(50 CHAR),        -- AUTH_REP_BACKUP.NID
    ETIN                       VARCHAR2(50 CHAR),
    DESIGNATION                VARCHAR2(255 CHAR),
    DATE_OF_JOINING            DATE,
    DATE_OF_EMPLOYMENT_END     DATE,
    OFFICIAL_CONTACT_NO        VARCHAR2(800),
    PERSONAL_CONTACT_NO        VARCHAR2(255),            -- AUTH_REP_BACKUP.MOBILE
    OFFICIAL_EMAIL             VARCHAR2(255 CHAR),
    PERSONAL_EMAIL             VARCHAR2(50 CHAR),
    ALTERNATIVE_EMAIL          VARCHAR2(50 CHAR),
    FAX                        VARCHAR2(50),
    RESIDENCE_STATUS           VARCHAR2(50 CHAR),
    PHOTO                      VARCHAR2(255),
    SIGNATURE                  VARCHAR2(255),
    REMARKS                    VARCHAR2(255 CHAR),         -- AUTH_REP_BACKUP.REMARK 
    STATUS                     VARCHAR2(40 CHAR) NOT NULL, -- AUTH_REP_BACKUP.STATUS  
    CREATED_BY                 VARCHAR2(50) NOT NULL,
    UPDATED_BY                 VARCHAR2(50),
    CREATED_DATE               DATE NOT NULL,
	UPDATED_DATE               DATE,
    IS_ACTIVE                  NUMBER(1) NOT NULL,
    
    CONSTRAINT PK_PERSONNEL PRIMARY KEY (PERSONNEL_ID),
    CONSTRAINT FK_PERSONNEL_TREC_ID FOREIGN KEY (TREC_ID) REFERENCES TREC(TREC_ID)
);


-------------------------------------------DELETE--------------------------------------------------------

select count (*) from AUTH_REP_BACKUP; -- 12827
select count (*) from PERSONNEL; -- 2183
select count (*) from AUTH_REP; -- 12827

delete from AUTH_REP;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'AUTH_REP'
    AND constraint_type IN ('P', 'U')
);

commit;


-------------------------------------------CLEAN--------------------------------------------------------

select  count (*) from AUTH_REP_BACKUP ; -- 12827
select * from AUTH_REP_BACKUP WHERE MEM_NO NOT IN(select TO_CHAR(trec_no) from TREC); --0

SELECT * FROM AUTH_REP_BACKUP WHERE NOT REGEXP_LIKE(MEM_NO, '^[0-9]+$'); -- 0
delete FROM AUTH_REP_BACKUP WHERE NOT REGEXP_LIKE(MEM_NO, '^[0-9]+$'); --0

SELECT * FROM AUTH_REP_BACKUP where  APPDATE is  null or  REGDATE is  null or EXPDATE is  null; -- 0
delete from  AUTH_REP_BACKUP where  APPDATE is  null or  REGDATE is  null or EXPDATE is  null;
commit;

select  STATUS, COUNT(*) from AUTH_REP_BACKUP group by STATUS;
select STATUS from AUTH_REP_BACKUP where trim(STATUS) IS NULL ;
select STATUS from AUTH_REP_BACKUP where STATUS='NULL';

update AUTH_REP_BACKUP set STATUS = TRIM(STATUS); -- 12,854 rows updated.
commit;

ALTER TABLE AUTH_REP_BACKUP ADD updated_status VARCHAR2(50);  
ALTER TABLE AUTH_REP_BACKUP ADD IS_ACTIVE number(1) DEFAULT (1) NOT NULL;


update AUTH_REP_BACKUP set updated_status='ACTIVE', IS_ACTIVE = 1 where trim(STATUS) IS NULL ; -- 1,102 rows updated.
update AUTH_REP_BACKUP set updated_status='ACTIVE', IS_ACTIVE = 1 where STATUS='NULL'; -- 4,180 rows updated
update AUTH_REP_BACKUP set updated_status='SUSPENDED',IS_ACTIVE = 1  where STATUS ='S'; -- S == Suspended -- 85 rows updated.
update AUTH_REP_BACKUP set updated_status='RESUMED', IS_ACTIVE = 1  where STATUS ='R'; -- R == Resumed -- 976 rows updated.
update AUTH_REP_BACKUP set updated_status='INACTIVE', IS_ACTIVE = 1  where STATUS ='I'; -- I == Inactive == Before wihdrawn = Physically dead -- 77 rows updated.
update AUTH_REP_BACKUP set updated_status='WITHDRAWN', IS_ACTIVE = 0 where STATUS ='W'; -- W == Withdrawn --6,434 rows updated.
commit;

select COUNT(*) from AUTH_REP_BACKUP where updated_status = 'WITHDRAWN' order by MEM_NO, XFERNO; -- 6434

select arb.ID, tb.MEM_NO, tb.XFERNO, arb.* from TREC_BACKUP tb
inner join AUTH_REP_BACKUP arb on tb.MEM_NO = arb.MEM_NO
and tb.XFERNO <> arb.XFERNO
order by tb.MEM_NO,arb.ID;


UPDATE AUTH_REP_BACKUP set updated_status = 'WITHDRAWN' , IS_ACTIVE = 0 where ID IN ( 
select arb.ID from TREC_BACKUP tb
inner join AUTH_REP_BACKUP arb on tb.MEM_NO = arb.MEM_NO
and tb.XFERNO <> arb.XFERNO
); -- 569 rows updated.

commit;

-------------------------------------------INSERT PERSONNEL--------------------------------------------------------

select count(*) from PERSONNEL ;
select max(PERSONNEL_ID) from PERSONNEL;
select count(*) from AUTH_REP_BACKUP  where AUTHNAME is null;

update AUTH_REP_BACKUP set AUTHNAME ='.' where AUTHNAME is null;
-- 5 rows updated.
commit;

--ALTER TABLE PERSONNEL ADD BACKUP_ID VARCHAR2(40);  

insert into PERSONNEL (PERSONNEL_ID, TREC_ID, NAME, DESIGNATION, IMAGE_PATH, TEMP_DATA, BACKUP_ID, STATUS, IS_ACTIVE, ADDED_BY )
select (ROWNUM+ (select max(PERSONNEL_ID) from PERSONNEL)) as PERSONNEL_ID, a.TREC_ID, a.AUTHNAME, 'Authorize Representative' as REMARKS,  a.PHOTO, a.TEMP_DATA, a.BACKUP_ID, a.UPDATED_STATUS, a.IS_ACTIVE, 496 as ADDED_BY from
(
select  TO_NUMBER(MEM_NO) as TREC_ID, AUTHNAME, PHOTO, 'AUTH_REP' as TEMP_DATA,  ID as  BACKUP_ID, UPDATED_STATUS, IS_ACTIVE from AUTH_REP_BACKUP 
where TO_NUMBER(MEM_NO) IN (select TREC_ID from TREC)
order by TO_NUMBER(MEM_NO)
) a;

-- 12,854 rows inserted.
commit;


select * from PERSONNEL where TEMP_DATA = 'AUTH_REP' order by PERSONNEL_ID asc;
select count (*) from PERSONNEL where TEMP_DATA = 'AUTH_REP' ;
--delete from PERSONNEL where TEMP_DATA = 'AUTH_REP';

UPDATE PERSONNEL set  RESIDENCE_STATUS = 'Native';
-- 15,037 rows updated

update PERSONNEL set STATUS='ACTIVE' where STATUS='SUSPENDED'; -- 58 rows updated.
update PERSONNEL set STATUS='ACTIVE' where STATUS='RESUMED'; -- 969 rows updated
update PERSONNEL set STATUS='INACTIVE' where STATUS='WITHDRAWN'; -- 6,841 rows updated.
commit;

select count(*), STATUS from PERSONNEL group by STATUS;

-------------------------------------------INSERT AUTH_REP--------------------------------------------------------

select count(*) from AUTH_REP_BACKUP  where SECREGNO is null;

update AUTH_REP_BACKUP set SECREGNO ='.' where SECREGNO is null;
-- 5 rows updated.
commit;

insert into AUTH_REP (AUTH_REP_ID, BACKUP_ID, INHOUSE_AUTHID, INHOUSE_AUTHNO, TREC_ID, PERSONNEL_ID,  DSE_APPROVED_DATE, BSEC_REG_NO, BSEC_REG_ISSUANCE_DATE, REMARKS, ADDED_BY)
select  ROWNUM as AUTH_REP_ID, p.BACKUP_ID, p.INHOUSE_AUTHID, INHOUSE_AUTHNO, p.TREC_ID, p.PERSONNEL_ID, p.DSE_APPROVED_DATE,p.BSEC_REG_NO, p.BSEC_REG_ISSUANCE_DATE, p.REMARK, '496' as ADDED_BY  
from (
select 
arp.id as BACKUP_ID,
arp.AUTHID as INHOUSE_AUTHID,
arp.AUTHNO as INHOUSE_AUTHNO,
pi.TREC_ID,
pi.PERSONNEL_ID, 
--to_date(arp.APPDATE,'MM/DD/YYYY') as APPLICATION_DATE_TO_DSE, 
to_date(arp.DSEAPVDATE,'MM/DD/YYYY') as DSE_APPROVED_DATE, 
--to_date(arp.APPDATE,'mm/dd/yyyy') as APPLICATION_DATE_TO_BSEC, 
arp.SECREGNO as BSEC_REG_NO, 
to_date(arp.REGDATE,'MM/DD/YYYY') as BSEC_REG_ISSUANCE_DATE, 
--CASE WHEN arp.RENEWDATE IS NOT NULL AND REGEXP_LIKE(arp.RENEWDATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(arp.RENEWDATE, 'MM/DD/YYYY') ELSE NULL END AS RENEW_DATE, 
--to_date(arp.EXPDATE,'MM/DD/YYYY') as EXPIRY_DATE,
arp.REMARK
--arp.UPDATED_STATUS,
--arp.IS_ACTIVE,
--CASE WHEN arp.ACTIONDATE IS NOT NULL AND REGEXP_LIKE(arp.ACTIONDATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(arp.ACTIONDATE, 'MM/DD/YYYY') ELSE SYSDATE END AS STATUS_EFFECTIVE_DATE
from AUTH_REP_BACKUP arp 
inner join PERSONNEL  pi
on  arp.id = pi.BACKUP_ID
order by pi.TREC_ID
) p ;
-- 12,854 rows inserted.

commit;

-------------------------------------------AUTH_REP_STATUS-------------------------------------------------------

select * from AUTH_REP_STATUS order by AUTH_REP_ID asc;

insert into AUTH_REP_STATUS (AUTH_REP_STATUS_ID, AUTH_REP_ID, STATUS, EFFECTIVE_DATE, ADDED_AT, ADDED_BY )
select ROWNUM, r.AUTH_REP_ID, r.UPDATED_STATUS,EFFECTIVE_DATE, r.ADDED_AT, r.ADDED_BY from 
(
select  
ar.AUTH_REP_ID, 
ar.ADDED_AT,
ar.ADDED_BY,
b.UPDATED_STATUS,
CASE WHEN b.ACTIONDATE IS NOT NULL AND REGEXP_LIKE(b.ACTIONDATE, '^\d{2}/\d{2}/\d{4}$') 
     THEN TO_DATE(b.ACTIONDATE, 'MM/DD/YYYY') 
     ELSE to_date(b.REGDATE,'MM/DD/YYYY') END AS EFFECTIVE_DATE
from AUTH_REP  ar  inner join AUTH_REP_BACKUP b  on ar.BACKUP_ID = b.ID
) r;

-- 12,854 rows inserted.
commit;

select * from AUTH_REP_STATUS where EFFECTIVE_DATE is null;

-------------------------------------------AUTH_REP_RENEW-------------------------------------------------------

select * from AUTH_REP_RENEW order by AUTH_REP_ID asc;

insert into AUTH_REP_RENEW (AUTH_REP_RENEW_ID, AUTH_REP_ID, RENEW_DATE, EXPIRY_DATE, REMARKS, ADDED_BY )
select ROWNUM, r.AUTH_REP_ID, r.RENEW_DATE, R.EXPIRY_DATE, 'MIGRATION', 496 as ADDED_BY from 
(
select  
ar.AUTH_REP_ID, 
CASE WHEN b.RENEWDATE IS NOT NULL AND REGEXP_LIKE(b.RENEWDATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(b.RENEWDATE, 'MM/DD/YYYY') ELSE NULL END AS RENEW_DATE, 
to_date(b.EXPDATE,'MM/DD/YYYY') as EXPIRY_DATE
from AUTH_REP  ar  inner join AUTH_REP_BACKUP b on ar.BACKUP_ID = b.ID
) r;

-- 12,854 rows inserted.
commit;

select * from AUTH_REP_RENEW where RENEW_DATE is null;
update AUTH_REP_RENEW  set RENEW_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where RENEW_DATE is null; --3 rows updated.
select * from AUTH_REP_RENEW where EXPIRY_DATE is null;

-------------------------------------------IMAGE-------------------------------------------------------

--IMAGE_PATH -> C:\EDRS\athphoto\30700002.jpg
--IMAGE_PATH -> C:\EDRS\memphoto\30700002.jpg
--SIGNATURE_PATH -> C:\EDRS\memsign\30700002.jpg

--Replace -> 'C': to ''
--Replace ->  '\' to '/'

UPDATE PERSONNEL
SET IMAGE_PATH = REPLACE(IMAGE_PATH, 'C:\EDRS\athphoto', 'TMS_FILES_PHOTOS\PersonnelPhoto')
WHERE IMAGE_PATH LIKE 'C:%'; -- 12,093 rows updated.

UPDATE PERSONNEL
SET IMAGE_PATH = REPLACE(IMAGE_PATH, 'c:\EDRS\athphoto', 'TMS_FILES_PHOTOS\PersonnelPhoto')
WHERE IMAGE_PATH LIKE 'c:%'; -- 297 rows updated.

UPDATE PERSONNEL
SET IMAGE_PATH = REPLACE(IMAGE_PATH, 'C:\EDRS\memphoto', 'TMS_FILES_PHOTOS\PersonnelPhoto')
WHERE IMAGE_PATH LIKE 'C:%'; -- 6 rows updated.

UPDATE PERSONNEL
SET IMAGE_PATH = REPLACE(IMAGE_PATH, 'c:\EDRS\memphoto', 'TMS_FILES_PHOTOS\PersonnelPhoto')
WHERE IMAGE_PATH LIKE 'c:%'; -- 297 rows updated.

UPDATE PERSONNEL
SET IMAGE_PATH = REPLACE(IMAGE_PATH, '\', '/')
WHERE IMAGE_PATH LIKE '\%'; -- 0 rows updated.
commit;


UPDATE PERSONNEL
SET SIGNATURE_PATH = REPLACE(SIGNATURE_PATH, 'C:\EDRS\memsign', 'TMS_FILES_PHOTOS\PersonnelSign')
WHERE SIGNATURE_PATH LIKE 'C:%'; -- 18 rows updated.

UPDATE PERSONNEL
SET SIGNATURE_PATH = REPLACE(SIGNATURE_PATH, 'c:\EDRS\memsign', 'TMS_FILES_PHOTOS\PersonnelSign')
WHERE SIGNATURE_PATH LIKE 'c:%'; -- 286 rows updated.

UPDATE PERSONNEL
SET SIGNATURE_PATH = REPLACE(SIGNATURE_PATH, '\', '/')
WHERE SIGNATURE_PATH LIKE '\%'; -- 0 rows updated.

commit;

select * from PERSONNEL where SIGNATURE_PATH is not null;

-------------------------------------------DATA ANALYSIS--------------------------------------------------------

select COUNT(*) from AUTH_REP order by AUTH_REP_ID; -- 12827
select COUNT(*), BSEC_REG_NO from AUTH_REP group by BSEC_REG_NO having COUNT(*)>2 ;
select * from AUTH_REP where BSEC_REG_NO='SEC/AR/DSE/2008/895';

-------------------------------------------DATA ANALYSIS--------------------------------------------------------

select * from AUTH_REP_BACKUP where PHOTO IS NOT NULL AND PHOTO !='NULL' and trim(PHOTO) IS NOT NULL; 
select * from AUTH_REP_BACKUP where IMGINREPORT IS NOT NULL AND IMGINREPORT !='NULL' and trim(IMGINREPORT) IS NOT NULL; 

select * from AUTH_REP_BACKUP where NID IS NOT NULL AND NID !='NULL' and trim(NID) IS NOT NULL; --0
select * from AUTH_REP_BACKUP where MOBILE IS NOT NULL AND MOBILE !='NULL' and trim(MOBILE) IS NOT NULL; --0

select * from AUTH_REP_BACKUP where TCNO IS NOT NULL AND TCNO !='NULL' and trim(TCNO) IS NOT NULL; --0
select * from AUTH_REP_BACKUP where TCISSUEDATE IS NOT NULL AND TCISSUEDATE !='NULL' and trim(TCISSUEDATE) IS NOT NULL; 
select * from AUTH_REP_BACKUP where TCRENEWDATE IS NOT NULL AND TCRENEWDATE !='NULL' and trim(TCRENEWDATE) IS NOT NULL; 

----------------------------------------------------------
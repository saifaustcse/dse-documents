SELECT ROW_NUMBER() OVER (Order by mem_no) AS id, * FROM [InHouse].[dbo].[memreg] order by mem_no, xferno asc;
SELECT count(*)  FROM [InHouse].[dbo].memreg ; -- 597

------------------------------------------------------------------
--delete from TREC_REG_BACKUP;
commit;
select count(*) from TREC_REG_BACKUP; -- 597

----------------------TREC_REG_BACKUP ---------------------------------

CREATE TABLE TREC_REG_BACKUP ( 
id NUMBER(3),
MEM_NO NUMBER(10),
XFERNO NUMBER(10),
REGDATE VARCHAR2(10),
RENEWDATE VARCHAR2(10),
SECLICENCE VARCHAR2(13),
SECDEP_REN VARCHAR2(17),
SECREGNO VARCHAR2(39),
EXPDATE VARCHAR2(10),
APPDATE VARCHAR2(10),
REMINDDATE VARCHAR2(10),
REGTYPE VARCHAR2(4),
REGREMARKS VARCHAR2(500)
);

-------------------------------------------DELETE--------------------------------------------------------

delete from BROKER;
delete from DEALER_RENEW;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'BROKER'
    AND constraint_type IN ('P', 'U')
);


-------------------------------------------CLEAN--------------------------------------------------------

select count (*) from TREC_REG_BACKUP; -- 597
select * from TREC_REG_BACKUP WHERE MEM_NO NOT IN(select TO_CHAR(trec_no) from TREC); --288

SELECT * FROM TREC_REG_BACKUP WHERE NOT REGEXP_LIKE(MEM_NO, '^[0-9]+$'); -- 0
delete FROM TREC_REG_BACKUP WHERE NOT REGEXP_LIKE(MEM_NO, '^[0-9]+$'); -- 0


ALTER TABLE TREC_REG_BACKUP ADD IS_DEALER number(1) DEFAULT (0) NOT NULL;

SELECT * FROM TREC_REG_BACKUP WHERE TO_NUMBER(MEM_NO) > 200000; --288
update TREC_REG_BACKUP set IS_DEALER =  1 WHERE TO_NUMBER(MEM_NO) > 200000; --288 rows updated. 

commit;

-------------------------------------------INSERT BROKER--------------------------------------------------------

select * from BROKER order by trec_id asc;

insert into BROKER (BROKER_ID, BACKUP_ID, TREC_ID, BSEC_REG_NO, BSEC_REG_ISSUANCE_DATE, REMARKS,  ADDED_BY )
select ROWNUM, r.BACKUP_ID, r.TREC_ID, r.SECREGNO,  r.BROKER_REGDATE,  r.REGREMARKS, 496 as ADDED_BY from 
(
select
ID as BACKUP_ID, 
TO_NUMBER(MEM_NO) as TREC_ID, 
SECREGNO,
CASE WHEN REGDATE = 'NULL' THEN NULL ELSE TO_DATE(REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE, 
REGREMARKS
from TREC_REG_BACKUP where TO_NUMBER(MEM_NO) IN (select TREC_ID from TREC) 
and SECREGNO IS NOT NULL and SECREGNO<>'NULL' order by ID
)r;

--  303 rows inserted.
commit;

select TREC_ID, count(TREC_ID) from BROKER group by TREC_ID having count(TREC_ID)>1;
select * from BROKER where BSEC_REG_ISSUANCE_DATE is null;

-------------------------------------------INSERT BROKER_RENEW--------------------------------------------------------

select * from BROKER_RENEW order by BROKER_ID asc;

insert into BROKER_RENEW (BROKER_RENEW_ID, BROKER_ID, RENEW_DATE, EXPIRY_DATE, ADDED_AT, ADDED_BY)
select ROWNUM, r.BROKER_ID, r.BROKER_RENEWDATE, r.BROKER_EXPDATE, r.ADDED_AT, r.ADDED_BY from 
(
select  
a.BROKER_ID, 
a.ADDED_AT,
a.ADDED_BY,
CASE WHEN b.RENEWDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.RENEWDATE,'MM/DD/YYYY') END as BROKER_RENEWDATE, 
CASE WHEN b.EXPDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.EXPDATE,'MM/DD/YYYY') END as BROKER_EXPDATE
from BROKER a  inner join TREC_REG_BACKUP b on a.BACKUP_ID = b.ID order by a.BROKER_ID
) r;

--  303 rows inserted.
commit;

select * from BROKER_RENEW where RENEW_DATE is null;
select * from BROKER_RENEW where EXPIRY_DATE is null;

-------------------------------------------INSERT BROKER_STATUS--------------------------------------------------------

select * from BROKER_STATUS order by BROKER_ID asc;

insert into BROKER_STATUS (BROKER_STATUS_ID, BROKER_ID, STATUS, EFFECTIVE_DATE, ADDED_AT, ADDED_BY)
select ROWNUM, r.BROKER_ID, 'ACTIVE', r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY from 
(
SELECT  
    a.BROKER_ID, 
    a.ADDED_AT,
    a.ADDED_BY,
    CASE WHEN b.REGDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE
FROM 
    BROKER a INNER JOIN TREC_REG_BACKUP b ON a.BACKUP_ID = b.ID order by a.BROKER_ID
) r;

--  303 rows inserted.
commit;

select * from BROKER_STATUS where EFFECTIVE_DATE is null;

UPDATE BROKER_STATUS bs
SET bs.STATUS = (
    select t.STATUS from BROKER b
    inner join TREC t on  b.TREC_ID = t.TREC_ID
    inner join TREC_STATUS ts on ts.TREC_ID = t.TREC_ID
    where bs.BROKER_ID = b.BROKER_ID
);
-- 303 rows updated.
commit;

---------------------------------------------INSERT DEALER------------------------------------------------------------

select * from DEALER order by TREC_ID asc;

insert into DEALER(DEALER_ID, BACKUP_ID, TREC_ID, BSEC_REG_NO, BSEC_REG_ISSUANCE_DATE, REMARKS, ADDED_BY)
select ROWNUM, r.BACKUP_ID, r.TREC_ID, r.SECREGNO,  r.BROKER_REGDATE, r.REGREMARKS, 496 as ADDED_BY from 
(
select
ID as BACKUP_ID, 
TO_NUMBER(MEM_NO)-200000 as TREC_ID, 
SECREGNO,
CASE WHEN REGDATE = 'NULL'  THEN NULL ELSE TO_DATE(REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE, 
CASE WHEN RENEWDATE = 'NULL'  THEN NULL ELSE TO_DATE(RENEWDATE,'MM/DD/YYYY') END as BROKER_RENEWDATE, 
CASE WHEN EXPDATE = 'NULL'  THEN NULL ELSE TO_DATE(EXPDATE,'MM/DD/YYYY') END as BROKER_EXPDATE, 
REGREMARKS
from TREC_REG_BACKUP where IS_DEALER=1 and TO_NUMBER(MEM_NO)-200000 IN (select TREC_ID from TREC) 
--and SECREGNO IS NOT NULL and SECREGNO<>'NULL' 
order by TREC_ID
) r;

--  288 rows inserted.
commit;

select * from DEALER where BSEC_REG_ISSUANCE_DATE is null;
update DEALER  set BSEC_REG_ISSUANCE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where BSEC_REG_ISSUANCE_DATE is null;


select * from BROKER where TREC_ID=161;
delete from BROKER_RENEW where BROKER_ID=157;
delete from BROKER_STATUS where BROKER_ID=157;
delete from BROKER where BROKER_ID=157;
commit;

---------------------------------------------INSERT DEALER_RENEW------------------------------------------------------------

select * from DEALER_RENEW order by DEALER_ID asc;

insert into DEALER_RENEW (DEALER_RENEW_ID, DEALER_ID, RENEW_DATE, EXPIRY_DATE,  ADDED_AT, ADDED_BY)
select ROWNUM, r.DEALER_ID, r.DEALER_RENEWDATE, r.DEALER_EXPDATE, r.ADDED_AT, r.ADDED_BY from 
(
select  
    a.DEALER_ID, 
    a.ADDED_AT,
    a.ADDED_BY,
    CASE WHEN b.RENEWDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.RENEWDATE,'MM/DD/YYYY') END as DEALER_RENEWDATE, 
    CASE WHEN b.EXPDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.EXPDATE,'MM/DD/YYYY') END as DEALER_EXPDATE
from DEALER a  inner join TREC_REG_BACKUP b on a.BACKUP_ID = b.ID order by a.DEALER_ID
) r;

--  288 rows inserted.
commit;

select * from DEALER_RENEW where RENEW_DATE is null;
select * from DEALER_RENEW where EXPIRY_DATE is null;
update DEALER_RENEW  set RENEW_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where RENEW_DATE is null;
update DEALER_RENEW  set EXPIRY_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EXPIRY_DATE is null;
-------------------------------------------INSERT DEALER_STATUS--------------------------------------------------------

select * from DEALER_STATUS order by DEALER_ID asc;

insert into DEALER_STATUS (DEALER_STATUS_ID, DEALER_ID, STATUS, EFFECTIVE_DATE, ADDED_AT, ADDED_BY)
select ROWNUM, r.DEALER_ID, 'ACTIVE', r.BROKER_REGDATE, r.ADDED_AT, r.ADDED_BY from 
(
SELECT  
    a.DEALER_ID, 
    a.ADDED_AT,
    a.ADDED_BY,
    CASE WHEN b.REGDATE = 'NULL' THEN NULL ELSE TO_DATE(b.REGDATE,'MM/DD/YYYY') END as BROKER_REGDATE
from DEALER a  inner join TREC_REG_BACKUP b on a.BACKUP_ID = b.ID order by a.DEALER_ID
) r;

--  288 rows inserted.
commit;
select * from DEALER_STATUS where EFFECTIVE_DATE is null;
update DEALER_STATUS  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;

select TREC_ID, count(TREC_ID) from DEALER  group by TREC_ID having count(TREC_ID)>1;

select * from DEALER where TREC_ID=1;
delete from DEALER_RENEW where DEALER_ID=2;
delete from DEALER_STATUS where DEALER_ID=2;
delete from DEALER where DEALER_ID=2;

select * from DEALER where TREC_ID=209;
delete from DEALER_RENEW where DEALER_ID=197;
delete from DEALER_STATUS where DEALER_ID=197;
delete from DEALER where DEALER_ID=197;

select * from DEALER where TREC_ID=286;
delete from DEALER_RENEW where DEALER_ID=270;
delete from DEALER_STATUS where DEALER_ID=270;
delete from DEALER where DEALER_ID=270;

commit;

select MEM_NO from TREC_BACKUP where SUSPEND ='Y' and  DEALERSHIP ='D' order by MEM_NO; 
select * from DEALER where TREC_ID=63;
select * from DEALER where TREC_ID=118;
select * from DEALER where TREC_ID=164;
update DEALER_STATUS set STATUS='SUSPENDED' where DEALER_ID=63;
update DEALER_STATUS set STATUS='SUSPENDED' where DEALER_ID=114;
--update DEALER_STATUS set STATUS='SUSPENDED' where DEALER_ID=157;
commit;

--------------------------------------------------FIX MISS MATCH TREC ----------------------------------------------------

SELECT count(*) FROM TREC; -- 312
SELECT count(*), STATUS FROM TREC group by STATUS; -- 301	ACTIVE, 11	SUSPENDED

select Count(*) from TREC_BACKUP where MEM_NO < 600 ; -- 312
select Count(*), SUSPEND from TREC_BACKUP where MEM_NO < 600 group by SUSPEND; -- TOTAL =  Y = 11, N =298, NULL = 3

-- Total TREC 309
-- Active 298
-- Suspended 11

--------------------------------------------------FIX MISS MATCH BROKER ----------------------------------------------------

SELECT count(*) FROM BROKER; -- 302
SELECT count(*), STATUS FROM BROKER group by STATUS; -- 302	ACTIVE

select count(*) from TREC_BACKUP where MEM_NO< 600 AND BKR_ID ='HB'; -- 303
select Count(*), SUSPEND from TREC_BACKUP where MEM_NO < 600 and BKR_ID ='HB'  group by SUSPEND; --  Y = 10, N =293

-- Total BROKER 300
-- Active 290
-- Suspended 10

SELECT *
FROM BROKER
WHERE (TREC_ID ) NOT IN (
    SELECT MEM_NO
    FROM TREC_BACKUP
    WHERE MEM_NO< 600
    --AND BKR_ID ='HB' 
); 
-- 0

SELECT *
FROM TREC_BACKUP
WHERE (MEM_NO ) NOT IN (
    SELECT TREC_ID
    FROM BROKER
)
AND MEM_NO< 600
AND BKR_ID ='HB';
-- 3 

--------------------------------------------------FIX MISS MATCH DEALER----------------------------------------------------

SELECT count(*) FROM DEALER; -- 280
select TREC_ID, count(TREC_ID) from DEALER  group by TREC_ID having count(TREC_ID)>1; -- 0 

SELECT count(*), DEALERSHIP FROM TREC_BACKUP group by DEALERSHIP; -- 282
select Count(*), SUSPEND from TREC_BACKUP where DEALERSHIP ='D' group by SUSPEND; --  Y = 3, N =267, NULL = 12


SELECT *
FROM DEALER
WHERE (TREC_ID + 200000) NOT IN (
    SELECT MEM_NO
    FROM TREC_BACKUP
    WHERE DEALERSHIP = 'D' 
    AND BKR_ID ='HB' 
); 
--12

SELECT *
FROM TREC_BACKUP
WHERE (MEM_NO ) NOT IN (
    SELECT (TREC_ID + 200000)
    FROM DEALER
)
AND  DEALERSHIP = 'D';
--3

select Count(*), SUSPEND from TREC_BACKUP where DEALERSHIP ='D'  AND BKR_ID ='HB'  group by SUSPEND; --  Y = 3, N =266

-- Having Broker ID:
-- Total Dealer 
-- Active 269
-- Suspended 

select count(*), STATUS from workstation where TWS_CATERGORY='D'
and TREC_ID+200000 in (select tb.MEM_NO from TREC_BACKUP tb where tb.DEALERSHIP ='D'  AND tb.BKR_ID ='HB')
group by STATUS; 
-- ACTIVE 269, DEACTIVATED_BY_DSE 91

---------------------------------------------------------------------------------------------------------------




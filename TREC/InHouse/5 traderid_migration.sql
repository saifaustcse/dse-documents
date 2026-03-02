
SELECT ROW_NUMBER() OVER (Order by mem_no) AS id, * FROM [InHouse].[dbo].[traderid] order by mem_no,xferno asc;
SELECT count(*)  FROM [InHouse].[dbo].[traderid] ;-- 6862

------------------------------------------------------------------
--delete from WORKSTATION_BACKUP;
commit;
select count(*) from WORKSTATION_BACKUP; -- 6862

----------------------WORKSTATION_BACKUP -------------------

CREATE TABLE WORKSTATION_BACKUP ( 
ID NUMBER(10),
MEM_NO NUMBER(10),
XFERNO NUMBER(10),
TDRNO NUMBER(10),
UCODE VARCHAR2(10),
TDRID VARCHAR2(10),
ID_TYPE VARCHAR2(1),
ID_CATEGORYTYPE VARCHAR2(4),
STATUS VARCHAR2(2),
CRT_DATE VARCHAR2(10),
EXP_DATE VARCHAR2(10),
ACTIONDATE VARCHAR2(10),
REMARKS VARCHAR2(255));

-------------------------------------------DELETE--------------------------------------------------------

select count (*) from WORKSTATION_BACKUP; -- 6851
select * from WORKSTATION; -- 0

delete from WORKSTATION;
delete from WORKSTATION_OFFICE;
delete from AUTH_REP_WORKSTATION;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'WORKSTATION'
    AND constraint_type IN ('P', 'U')
);

commit;


-------------------------------------------CLEAN--------------------------------------------------------

ALTER TABLE WORKSTATION DROP COLUMN STATUS;

select count(*) from WORKSTATION_BACKUP; -- 6851

select count(*) from WORKSTATION_BACKUP WHERE MEM_NO NOT IN(select TO_CHAR(trec_no) from TREC); --369

SELECT * FROM WORKSTATION_BACKUP WHERE NOT REGEXP_LIKE(MEM_NO, '^[0-9]+$'); -- 0
delete FROM WORKSTATION_BACKUP WHERE NOT REGEXP_LIKE(MEM_NO, '^[0-9]+$'); -- 0

commit;

select  STATUS, COUNT(*) from WORKSTATION_BACKUP group by STATUS;
update WORKSTATION_BACKUP set STATUS = TRIM(STATUS);
-- 6,862 rows updated.
commit;

ALTER TABLE WORKSTATION_BACKUP ADD updated_status VARCHAR2(50);  
ALTER TABLE WORKSTATION_BACKUP DROP COLUMN IS_ACTIVE;
         
update WORKSTATION_BACKUP set updated_status='ACTIVE' where STATUS IS NULL ; -- 1 rows updated.
update WORKSTATION_BACKUP set updated_status='ACTIVE'  where STATUS='N' ;   -- N = Nothing  -- 5,418 rows updated.
update WORKSTATION_BACKUP set updated_status='SELF_SUSPENDED' where STATUS ='SS' ; -- SS == Self suspended -- 563 rows updated.
update WORKSTATION_BACKUP set updated_status='SUSPENDED_BY_DSE' where STATUS ='SD' ; -- SD == Self Deactivated -- 3 rows updated.
update WORKSTATION_BACKUP set updated_status='DEACTIVATED_BY_DSE'  where STATUS ='D' ;  -- D == Deactivated By DSE -- 877 rows updated.
commit;

select count(*), ID_TYPE from WORKSTATION_BACKUP  group by ID_TYPE;
update WORKSTATION_BACKUP set ID_TYPE = TRIM(ID_TYPE); -- 6,862 rows updated.
-- (null) == 
-- J      == Junior
-- T      == ??
-- S      == Senior
commit;

select count(*), ID_CATEGORYTYPE from WORKSTATION_BACKUP  group by ID_CATEGORYTYPE;
update WORKSTATION_BACKUP set ID_CATEGORYTYPE = TRIM(ID_CATEGORYTYPE); -- 6,862 rows updated.
--  I    == ITreder internet or mobile
--- D    == Dealer
--  T    == Treader
-- NULL  == 
commit;

select COUNT(*) from WORKSTATION_BACKUP where updated_status = 'DEACTIVATED_BY_DSE' order by MEM_NO, XFERNO; -- 877  --> 1218

select wb.ID, tb.MEM_NO, tb.XFERNO, wb.* from TREC_BACKUP tb
inner join WORKSTATION_BACKUP wb on tb.MEM_NO = wb.MEM_NO
and tb.XFERNO <> wb.XFERNO
order by tb.MEM_NO,wb.ID;
-- 659 rows 

UPDATE WORKSTATION_BACKUP set updated_status = 'DEACTIVATED_BY_DSE' where ID IN ( 
    select wb.ID from TREC_BACKUP tb
    inner join WORKSTATION_BACKUP wb on tb.MEM_NO = wb.MEM_NO
    and tb.XFERNO <> wb.XFERNO
);
-- 659 rows updated.
commit;

-------------------------------------------INSERT TRADER--------------------------------------------------------

select count(*) from WORKSTATION_BACKUP ; --  6851
select count(*)  from WORKSTATION ; -- 0

insert into WORKSTATION (WORKSTATION_ID, BACKUP_ID, TREC_ID, TWS_NAME, TWS_CATERGORY, TDRNO, UCODE, ID_TYPE, EXP_DATE, REMARKS,  ADDED_AT, ADDED_BY)
select ID, 
id as BACKUP_ID,
TO_NUMBER(MEM_NO) AS TREC_ID, 
TDRID as TWS_NAME, 
ID_CATEGORYTYPE as TWS_CATERGORY,
TDRNO,
UCODE, 
ID_TYPE, 
CASE WHEN EXP_DATE IS NOT NULL AND REGEXP_LIKE(EXP_DATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(EXP_DATE, 'MM/DD/YYYY') ELSE NULL END AS EXP_DATE, 
REMARKS,  
CASE WHEN CRT_DATE IS NOT NULL AND REGEXP_LIKE(CRT_DATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(CRT_DATE, 'MM/DD/YYYY') ELSE NULL END AS CRT_DATE, 
496
from WORKSTATION_BACKUP where TO_NUMBER(MEM_NO) IN (select TREC_ID from TREC) order by ID asc;
--6,493 rows inserted.

commit;

-------------------------------------------INSERT DEALER --------------------------------------------------------

select count(*) from WORKSTATION_BACKUP ; --  6851
select count(*)  from WORKSTATION ; -- 6482 -- > 6851

insert into WORKSTATION (WORKSTATION_ID, BACKUP_ID, TREC_ID, TWS_NAME, TWS_CATERGORY, TDRNO, UCODE, ID_TYPE, EXP_DATE, REMARKS, ADDED_AT, ADDED_BY)
select ID, 
id as BACKUP_ID,
TO_NUMBER(MEM_NO)-200000 AS TREC_ID, 
TDRID as TWS_NAME, 
ID_CATEGORYTYPE as TWS_CATERGORY,
TDRNO,
UCODE, 
ID_TYPE, 
CASE WHEN EXP_DATE IS NOT NULL AND REGEXP_LIKE(EXP_DATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(EXP_DATE, 'MM/DD/YYYY') ELSE NULL END AS EXP_DATE, 
REMARKS,  
CASE WHEN CRT_DATE IS NOT NULL AND REGEXP_LIKE(CRT_DATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(CRT_DATE, 'MM/DD/YYYY') ELSE NULL END AS CRT_DATE, 
496
from WORKSTATION_BACKUP 
where
TO_NUMBER(MEM_NO) >= 200000 order by ID asc;

--369 rows inserted.
commit;

-------------------------------------------INSERT WORKSTATION_STATUS --------------------------------------------------------

select * from WORKSTATION_STATUS order by WORKSTATION_ID asc;

insert into WORKSTATION_STATUS (WORKSTATION_STATUS_ID, WORKSTATION_ID, STATUS, EFFECTIVE_DATE, ADDED_AT, ADDED_BY )
select ROWNUM, r.WORKSTATION_ID, r.UPDATED_STATUS, STATUS_EFFECTIVE_DATE, r.ADDED_AT, r.ADDED_BY from 
(
select  
w.WORKSTATION_ID, 
w.ADDED_AT,
w.ADDED_BY,
b.UPDATED_STATUS,
CASE WHEN b.ACTIONDATE = 'NULL'  THEN NULL ELSE TO_DATE(b.ACTIONDATE,'MM/DD/YYYY') END as STATUS_EFFECTIVE_DATE
from WORKSTATION  w  inner join WORKSTATION_BACKUP b  on w.BACKUP_ID = b.ID
) r;

-- 6,862 rows inserted

select * from WORKSTATION_STATUS where EFFECTIVE_DATE is null;
update WORKSTATION_STATUS  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 3,574 rows updated.
commit;

--------------------------------------------------FIX ID_TYPE and TWS_CATERGORY ----------------------------------------------------

select  count( workstation_id), TWS_CATERGORY from WORKSTATION group by TWS_CATERGORY;
select  count( workstation_id), ID_TYPE from WORKSTATION group by ID_TYPE;

update WORKSTATION set ID_TYPE = 'T' where ID_TYPE is null; -- 221 rows updated.
update WORKSTATION set TWS_CATERGORY = 'T' where TWS_CATERGORY is null; -- 10 rows updated.
update WORKSTATION set TWS_CATERGORY = 'T' where TWS_CATERGORY = 'NULL'; -- 4 rows updated.
commit;

--------------------------------------------------FIX MISS MATCH WORKSTATION ----------------------------------------------------

select count(*), STATUS from workstation w
inner join WORKSTATION_STATUS ws on w.WORKSTATION_ID = ws.WORKSTATION_ID
where w.TWS_CATERGORY='T'  group by ws.STATUS; -- ACTIVE 4730, SELF_SUSPENDED 499,  SUSPENDED_BY_DSE 1,  DEACTIVATED_BY_DSE 1125

select count(*), STATUS from workstation w
inner join WORKSTATION_STATUS ws on w.WORKSTATION_ID = ws.WORKSTATION_ID
where w.TWS_CATERGORY='I'  group by ws.STATUS; -- ACTIVE 78, SELF_SUSPENDED 41

select count(*), STATUS from workstation w
inner join WORKSTATION_STATUS ws on w.WORKSTATION_ID = ws.WORKSTATION_ID
where w.TWS_CATERGORY='D'  group by ws.STATUS; -- ACTIVE 284, DEACTIVATED_BY_DSE 93

select count(*) from DEALER; -- 282
select * from vw_workstation where TWS_CATERGORY='D'  AND IS_active=1 and TREC_ID in ( select TREC_ID from VW_DEALER where VW_DEALER.STATUS='SUSPENDED' ); -- 4
select * from VW_DEALER where TREC_ID   not in ( select TREC_ID from vw_workstation where TWS_CATERGORY='D'  AND IS_active=1);

select TREC_ID, count(TREC_ID) from WORKSTATION
where TWS_CATERGORY='D'
--and IS_ACTIVE=1
group by TREC_ID
having count(TREC_ID)>1;
-- 92

select TWS_NAME, count(WORKSTATION_ID) from WORKSTATION  group by TWS_NAME having count(TWS_NAME)>1;
-- 595

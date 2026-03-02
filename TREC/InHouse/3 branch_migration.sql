SELECT ROW_NUMBER() OVER (Order by mem_no) AS id, * FROM [InHouse].[dbo].[branch] order by mem_no,xferno asc;
SELECT count(*)  FROM [InHouse].[dbo].[branch] ; -- 1713

------------------------------------------------------------------
--delete from OFFICE_BACKUP;
commit;
select count(*) from OFFICE_BACKUP; -- 1713

---------------------OFFICE_BACKUP----------------------------------

CREATE TABLE OFFICE_BACKUP 
(
ID NUMBER(10),
MEM_NO NUMBER(10),
XFERNO NUMBER(10),
BRNCHNO NUMBER(10),
BRNCHAREA VARCHAR2(50),
TWSINBRNCH NUMBER(5),
CONTYPE VARCHAR2(50),
VENDOR VARCHAR2(255),
STATUS VARCHAR2(10),
ACTIONDATE VARCHAR2(10),
BRNCHIP VARCHAR2(30),
GATEWAY VARCHAR2(30),
CONTACTNO VARCHAR2(100),
INCHARGE VARCHAR2(255),
MSA VARCHAR2(10),
BRNCHLOC VARCHAR2(999),
NOOFAR NUMBER(10),
COMPOFCR VARCHAR2(100),
BRNCHTYPE VARCHAR2(1),
REMARK VARCHAR2(999),
BRLOC VARCHAR2(999),
NOOFITRADER VARCHAR2(10)
);

-------------------------------------------DELETE--------------------------------------------------------

delete from OFFICE;
delete from OFFICE_INCHARGE;
delete from OFFICE_COMPL_OFFICER;

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'OFFICE'
    AND constraint_type IN ('P', 'U')
);


-------------------------------------------CLEAN--------------------------------------------------------

select  count (*) from OFFICE_BACKUP ; -- 1709
select * from OFFICE_BACKUP WHERE MEM_NO NOT IN(select TO_CHAR(trec_no) from TREC); -- 0

--update OFFICE_BACKUP set BRNCHNO = BRNCHNO + 1;
--commit;

select status, count (*) from OFFICE_BACKUP group by status;
select STATUS from OFFICE_BACKUP where trim(STATUS) IS NULL ;
select STATUS from OFFICE_BACKUP where STATUS='NULL';

update OFFICE_BACKUP set STATUS = TRIM(STATUS); -- 1,712 rows updated.
commit;

desc OFFICE_BACKUP;

ALTER TABLE OFFICE_BACKUP ADD updated_status VARCHAR2(50);  
ALTER TABLE OFFICE_BACKUP DROP COLUMN IS_ACTIVE;

update OFFICE_BACKUP set updated_status='ACTIVE' where trim(STATUS) IS NULL ; -- 364 rows updated.
update OFFICE_BACKUP set updated_status='ACTIVE' where STATUS='NULL'; -- 822 rows updated.
update OFFICE_BACKUP set updated_status='SUSPENDED'  where STATUS ='S'; -- S == Suspended -- 1 rows updated.
update OFFICE_BACKUP set updated_status='RESUMED' where STATUS ='R'; -- R == Resumed -- 2 rows updated.
update OFFICE_BACKUP set updated_status='WITHDRAWN' where STATUS ='W'; -- W == Withdrawn -- 523 rows updated.

commit;

select COUNT(*) from OFFICE_BACKUP where updated_status = 'WITHDRAWN' order by MEM_NO, XFERNO; 


select ob.* from TREC_BACKUP tb
inner join OFFICE_BACKUP ob on tb.MEM_NO = ob.MEM_NO
and tb.XFERNO <> ob.XFERNO
order by tb.MEM_NO;


UPDATE OFFICE_BACKUP set updated_status = 'WITHDRAWN' where ID IN ( 
select ob.ID from TREC_BACKUP tb
inner join OFFICE_BACKUP ob on tb.MEM_NO = ob.MEM_NO
and tb.XFERNO <> ob.XFERNO
); -- 52 rows updated.

commit;

-------------------------------------------INSERT OFFICE--------------------------------------------------------

select * from office order by trec_id asc;
select count(*) from office;

select * from office o 
inner join OFFICE_TYPE  ot on o.OFFICE_ID = ot.OFFICE_ID 
where ot.type <> 'HEAD' order by o.office_id;

insert into OFFICE (OFFICE_ID, BACKUP_ID, TREC_ID, OFFICE_NO,OFFICE_CONTACT_NO, REMARKS, ADDED_BY)
select (ROWNUM+ (select max(OFFICE_ID) from OFFICE)) as OFFICE_ID, r.BACKUP_ID, r.TREC_ID, r.OFFICE_NO, r.CONTACTNO, r.REMARKS, 496
from (
select
TO_NUMBER(ID) as BACKUP_ID,
TO_NUMBER(MEM_NO) as TREC_ID, 
TO_NUMBER(BRNCHNO) as OFFICE_NO, 
TRIM(CONTACTNO) As CONTACTNO,
TRIM(REMARK) As REMARKS
from OFFICE_BACKUP where TO_NUMBER(MEM_NO) < 333 order by ID
)r; 

-- 1,712 rows inserted.
commit;

-------------------------------------------INSERT OFFICE_STATUS--------------------------------------------------------

--delete from OFFICE_STATUS;
select * from OFFICE_STATUS order by OFFICE_ID asc;

insert into OFFICE_STATUS (OFFICE_STATUS_ID, OFFICE_ID, STATUS, EFFECTIVE_DATE, ADDED_BY, ADDED_AT)
select (ROWNUM+ (select max(OFFICE_STATUS_ID) from OFFICE_STATUS)) as OFFICE_STATUS_ID,  r.OFFICE_ID, r.STATUS, r.EFFECTIVE_DATE, r.ADDED_BY, r.ADDED_AT from 
(
SELECT  
    a.OFFICE_ID, 
    a.ADDED_BY,
    a.ADDED_AT,
    TRIM(b.UPDATED_STATUS) As STATUS,
    CASE 
        WHEN b.ACTIONDATE IS NOT NULL AND REGEXP_LIKE(b.ACTIONDATE, '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(b.ACTIONDATE, 'MM/DD/YYYY') 
        ELSE TO_DATE('01/01/1900','MM/DD/YYYY') END AS EFFECTIVE_DATE
FROM OFFICE a INNER JOIN OFFICE_BACKUP b ON a.BACKUP_ID = b.ID 
INNER JOIN TREC_REG_BACKUP c on a.TREC_ID = TO_NUMBER(c.MEM_NO) 
order by a.OFFICE_ID
) r;

-- 1,712 rows inserted.
commit;

select * from OFFICE_STATUS where EFFECTIVE_DATE is null;

-------------------------------------------INSERT OFFICE_TYPE--------------------------------------------------------

select * from office_type;
--delete from OFFICE_TYPE;

INSERT INTO OFFICE_TYPE (OFFICE_TYPE_ID, OFFICE_ID, TYPE, ADDED_BY, ADDED_AT)
SELECT (ROWNUM + (SELECT MAX(OFFICE_TYPE_ID) FROM OFFICE_TYPE)) AS OFFICE_TYPE_ID, r.OFFICE_ID, r.OFF_TYPE, r.ADDED_BY, r.ADDED_AT
FROM 
(
SELECT  
    a.OFFICE_ID, 
    a.ADDED_BY,
    a.ADDED_AT,
    CASE
        WHEN TRIM(b.BRNCHTYPE) IN ('B', '') THEN 'BRANCH'
        WHEN TRIM(b.BRNCHTYPE) = 'E' THEN 'EXTENSION'
        ELSE 'BRANCH' END AS OFF_TYPE
FROM OFFICE a INNER JOIN OFFICE_BACKUP b ON a.BACKUP_ID = b.ID
ORDER BY a.OFFICE_ID
) r;

-- 1,712 rows inserted
commit;

select * from OFFICE_TYPE where EFFECTIVE_DATE is null;
update OFFICE_TYPE  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 1,712 rows updated.
commit;

-------------------------------------------INSERT OFFICE_ADDRESS--------------------------------------------------------

select * from OFFICE_ADDRESS order by OFFICE_ID asc;
--delete from OFFICE_ADDRESS;

insert into OFFICE_ADDRESS (OFFICE_ADDRESS_ID, OFFICE_ID, LOCATION, AREA, ADDED_BY, ADDED_AT)
select (ROWNUM + (SELECT MAX(OFFICE_ADDRESS_ID) FROM OFFICE_ADDRESS)) AS OFFICE_ADDRESS_ID, r.OFFICE_ID, r.LOCATION, r.AREA, r.ADDED_BY, r.ADDED_AT from 
(
SELECT  
    a.OFFICE_ID, 
    a.ADDED_BY,
    a.ADDED_AT,
    --TRIM(BRLOC) As BRLOC,
    TRIM(BRNCHLOC) As LOCATION,
    TRIM(BRNCHAREA) As AREA
FROM OFFICE a INNER JOIN OFFICE_BACKUP b ON a.BACKUP_ID = b.ID  order by a.OFFICE_ID
) r;

-- 1,712 rows inserted.
commit;

select * from OFFICE_ADDRESS where OPERATION_START_DATE is null;
update OFFICE_ADDRESS  set OPERATION_START_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where OPERATION_START_DATE is null;
-- 1,712 rows updated
commit;

select * from OFFICE_ADDRESS where area='NULL';
SELECT * FROM OFFICE_BACKUP where trim(VENDOR) is null;
update OFFICE_ADDRESS set area = null  where area='NULL'; 
-- 133 rows updated.
commit;
-------------------------------------------INSERT OFFICE_NETWORK--------------------------------------------------------

select * from OFFICE_NETWORK order by OFFICE_ID asc;
--delete from OFFICE_NETWORK;

insert into OFFICE_NETWORK (OFFICE_NETWORK_ID, OFFICE_ID, BRNCHIP, GATEWAY, MSA, ADDED_BY, ADDED_AT)
select ROWNUM, r.OFFICE_ID, r.BRNCHIP,  r.GATEWAY, r.MSA, r.ADDED_BY, r.ADDED_AT from 
(
SELECT  
    a.OFFICE_ID,
    a.ADDED_BY,
    a.ADDED_AT,
    TRIM(CONTYPE) As CONTYPE,
    TRIM(BRNCHIP) As BRNCHIP,
    TRIM(GATEWAY) As GATEWAY,
    TRIM(MSA) As MSA
FROM OFFICE a INNER JOIN OFFICE_BACKUP b ON a.BACKUP_ID = b.ID order by a.OFFICE_ID
) r;

-- 1,712 rows inserted.
commit;

select * from OFFICE_NETWORK where EFFECTIVE_DATE is null;
update OFFICE_NETWORK  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- 1,712 rows updated.
commit;

-------------------------------------------INSERT PERSONNEL--------------------------------------------------------

insert into PERSONNEL (PERSONNEL_ID, TREC_ID, NAME, DESIGNATION, TEMP_DATA, STATUS, ADDED_BY, ADDED_AT)
select (ROWNUM+ (select max(PERSONNEL_ID) from PERSONNEL)) as PERSONNEL_ID,  l.TREC_ID, l.NAME,  l.DESIGNATION,  l.TEMP_DATA , l.STATUS ,  l.ADDED_BY, l.ADDED_AT from
(
select  
    o.OFFICE_ID as  TEMP_DATA, -- will be used for insert in office
    o.TREC_ID,
    o.ADDED_BY,
    o.ADDED_AT,
    trim(b.INCHARGE) as NAME, 
    'Office Inchagre' as DESIGNATION , 
    'ACTIVE' as STATUS
from OFFICE o
inner join OFFICE_BACKUP b
on o.BACKUP_ID = b.ID
where  trim(b.INCHARGE) is not null order by o.OFFICE_ID
) l;

--783 rows inserted.
commit;

select * from PERSONNEL where DESIGNATION ='Office Inchagre';

-------------------------------------------INSERT OFFICE_INCHARGE--------------------------------------------------------

SELECT * FROM OFFICE_INCHARGE;

insert into OFFICE_INCHARGE (OFFICE_INCHARGE_ID,  OFFICE_ID, PERSONNEL_ID, EFFECTIVE_DATE, REMARKS, ADDED_BY, ADDED_AT)
select ROWNUM as OFFICE_INCHARGE_ID, r.OFFICE_ID, r.PERSONNEL_ID, r.EFFECTIVE_DATE, 'Office Inchagre' as REMARKS, r.ADDED_BY, r.ADDED_AT from
(
select 
    pi.TEMP_DATA as OFFICE_ID, 
    pi.PERSONNEL_ID, 
    TO_DATE('01/01/1900','MM/DD/YYYY') as EFFECTIVE_DATE,
    pi.ADDED_BY,
    pi.ADDED_AT 
from PERSONNEL  pi where pi.DESIGNATION='Office Inchagre' 
ORDER by pi.TREC_ID
) r;
--783 rows inserted.

UPDATE OFFICE_INCHARGE set IS_ACTIVE=0 where OFFICE_ID in 
(
 SELECT OFFICE_ID from OFFICE a inner join OFFICE_BACKUP b  on a.BACKUP_ID = b.ID where updated_status='WITHDRAWN'
);

-- 116 rows updated
commit;

select office_id, count(IS_ACTIVE) from OFFICE_INCHARGE  group by office_id, IS_ACTIVE having count(IS_ACTIVE) >1;

-------------------------------------------INSERT PERSONNEL_INFO--------------------------------------------------------

insert into PERSONNEL (PERSONNEL_ID, TREC_ID, NAME, DESIGNATION, TEMP_DATA, STATUS, ADDED_BY, ADDED_AT)
select (ROWNUM+ (select max(PERSONNEL_ID) from PERSONNEL)) as PERSONNEL_ID,  l.TREC_ID, l.NAME,  l.DESIGNATION,  l.TEMP_DATA , l.STATUS ,  l.ADDED_BY, l.ADDED_AT from
(
select  
    o.OFFICE_ID as  TEMP_DATA, -- will be used for insert in office
    o.TREC_ID,
    o.ADDED_BY,
    o.ADDED_AT,
    trim(b.COMPOFCR) as NAME, 
    'Branch Compliance Officer' as DESIGNATION , 
    'ACTIVE' as STATUS
from OFFICE o
inner join OFFICE_BACKUP b
on o.BACKUP_ID = b.ID
where trim(b.COMPOFCR) is not null order by o.OFFICE_ID
) l; 

--782 rows inserted.

commit;

select * from PERSONNEL where DESIGNATION ='Branch Compliance Officer';

-------------------------------------------INSERT BRNCH_COMPL_OFFICER--------------------------------------------------------

insert into OFFICE_COMPL_OFFICER (OFFICE_COMPL_OFFICER_ID, OFFICE_ID, PERSONNEL_ID, EFFECTIVE_DATE, REMARKS,  ADDED_BY, ADDED_AT)
select ROWNUM as OFFICE_COMPL_OFFICER_ID, r.OFFICE_ID, r.PERSONNEL_ID, r.EFFECTIVE_DATE, 'Branch Compliance Officer' as REMARKS, r.ADDED_BY, r.ADDED_AT from
(
select 
    pi.TREC_ID, pi.TEMP_DATA as OFFICE_ID, 
    pi.PERSONNEL_ID, 
    TO_DATE('01/01/1900','MM/DD/YYYY') as EFFECTIVE_DATE,
    pi.ADDED_BY, 
    pi.ADDED_AT 
from PERSONNEL pi where pi.DESIGNATION='Branch Compliance Officer' 
ORDER by pi.TREC_ID
) r;

--782 rows inserted.

UPDATE OFFICE_COMPL_OFFICER set IS_ACTIVE=0 where OFFICE_ID in 
(
 SELECT OFFICE_ID from OFFICE a inner join OFFICE_BACKUP b  on a.BACKUP_ID = b.ID where updated_status='WITHDRAWN'
);

-- 115 rows updated.
commit;

--------------------------------------------------NET_VENDOR----------------------------------------------------

select * from OFFICE_BACKUP ;
select count(*), VENDOR  from OFFICE_BACKUP group by VENDOR order by VENDOR;

update OFFICE_BACKUP set VENDOR=trim(VENDOR); -- 1,712 rows updated.
update OFFICE_BACKUP set VENDOR='Undefined'  where VENDOR is null; --654 rows updated.
UPDATE OFFICE_BACKUP SET VENDOR = 'Undefined' WHERE trim(VENDOR) IS NULL ; -- 0 rows updated
update OFFICE_BACKUP set VENDOR = 'Link3 Technologies Ltd' where VENDOR = 'Link3 Technologies Ltd.'; --179 rows updated.
commit;

SELECT * FROM OFFICE_BACKUP where trim(VENDOR) is null;

-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values (1 , 'Undefined', 'Imported', 1); --645
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Self', 'Imported', 1);--473
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'DNS', 'Imported', 1); --3
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'DSE', 'Imported', 1); --6
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'DSE(DDN)', 'Imported', 1); --10
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Dhaka Com', 'Imported', 1); --205
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Link3 Technologies Ltd', 'Imported', 1); --179
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Metro Net', 'Imported', 1); --5
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Ranks ITT', 'Imported', 1); --60
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Royal Green Online Ltd', 'Imported', 1); --24
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'Telnet', 'Imported', 1); --29
-- insert into NET_VENDOR(NET_VENDOR_ID, VENDOR_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_VENDOR_ID)+1 from NET_VENDOR), 'X-Net', 'Imported', 1);--64

select * from NET_VENDOR;
select count(*) from OFFICE; -- 2012
select count(*)  from OFFICE_NETWORK ; -- 1703

select n.NET_VENDOR_ID
FROM OFFICE o
JOIN OFFICE_BACKUP ob ON o.BACKUP_ID = ob.ID
JOIN NET_VENDOR n ON ob.VENDOR = n.VENDOR_NAME;

UPDATE OFFICE_NETWORK oon
SET oon.NET_VENDOR_ID = (
    select n.NET_VENDOR_ID
    FROM OFFICE o
    JOIN OFFICE_BACKUP ob ON o.BACKUP_ID = ob.ID
    JOIN NET_VENDOR n ON ob.VENDOR = n.VENDOR_NAME
    WHERE oon.OFFICE_ID = o.OFFICE_ID
);
-- 1,712 rows updated.

select * from OFFICE_NETWORK where NET_VENDOR_ID is null;
update OFFICE_NETWORK set NET_VENDOR_ID=1 where NET_VENDOR_ID is null;  
-- 654 rows updated.
commit;

select count(*), NET_VENDOR_ID 
from OFFICE o 
join OFFICE_NETWORK oon 
on o.OFFICE_ID = oon.OFFICE_ID
group by oon.NET_VENDOR_ID order by oon.NET_VENDOR_ID;

-----------------------------------------------NET_CONNECTION_TYPE-------------------------------------------------------

select * from OFFICE_BACKUP ;
select count(*), CONTYPE  from OFFICE_BACKUP group by CONTYPE order by CONTYPE;

update OFFICE_BACKUP set CONTYPE=trim(CONTYPE); -- 1,712 rows updated
commit;

-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values (1 , 'Undefinded', 'Imported', 1); -- 681
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'DSL/ADSL (Bridge)', 'Imported', 1); --1
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'DSL/ADSL (Routed)', 'Imported', 1); --2
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'Dialup', 'Imported', 1); --1
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'Expanded LAN', 'Imported', 1); --266
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'Fiber Optic (Bridge)', 'Imported', 1);--78
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'Fiber Optic (Routed)', 'Imported', 1);--560
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'LAN', 'Imported', 1);--3
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'Radio Link (Bridged)', 'Imported', 1);--10
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'Radio Link (Routed)', 'Imported', 1);--80
-- insert into NET_CONNECTION_TYPE(NET_CONNECTION_TYPE_ID, CONNECTION_NAME, REMARKS, IS_ACTIVE) values ((select MAX(NET_CONNECTION_TYPE_ID)+1 from NET_CONNECTION_TYPE), 'WAN', 'Imported', 1);--21

select * from NET_CONNECTION_TYPE;

select n.NET_CONNECTION_TYPE_ID
FROM OFFICE o
JOIN OFFICE_BACKUP ob ON o.BACKUP_ID = ob.ID
JOIN NET_CONNECTION_TYPE n ON ob.CONTYPE = n.CONNECTION_NAME;

UPDATE OFFICE_NETWORK oon
SET oon.NET_CONNECTION_TYPE_ID = (
    select n.NET_CONNECTION_TYPE_ID
    FROM OFFICE o
    JOIN OFFICE_BACKUP ob ON o.BACKUP_ID = ob.ID
    JOIN NET_CONNECTION_TYPE n ON ob.CONTYPE = n.CONNECTION_NAME
    WHERE oon.OFFICE_ID = o.OFFICE_ID
);
    
-- 1,712 rows updated.
commit;

update OFFICE_NETWORK set NET_CONNECTION_TYPE_ID=1 where NET_CONNECTION_TYPE_ID is null;                           
-- 690 rows updated.
commit;

select count(*), NET_CONNECTION_TYPE_ID 
from OFFICE o 
join OFFICE_NETWORK oon 
on o.OFFICE_ID = oon.OFFICE_ID
group by oon.NET_CONNECTION_TYPE_ID order by oon.NET_CONNECTION_TYPE_ID;

------------------------------------------------------------------------------------------------------

--delete from DIGITAL_BOOTH_BACKUP;
commit;
select count(*) from DIGITAL_BOOTH_BACKUP; -- 257

-----------------------------------------OFFICE_BACKUP--------------------------------------------------

CREATE TABLE DIGITAL_BOOTH_BACKUP 
(
ID NUMBER(5),
TREC_ID NUMBER(5,0) NOT NULL, 
TREC_NAME VARCHAR2(50), 
BSEC_APPROVAL_DATE VARCHAR2(50), 
LOCATION VARCHAR2(255 CHAR)      -- OFFICE_ADDRESS.LOCATION 
);



-------------------------------------------CLEAN--------------------------------------------------------

select  count (*) from DIGITAL_BOOTH_BACKUP ; -- 258
select * from DIGITAL_BOOTH_BACKUP WHERE TREC_ID NOT IN(select TREC_ID from TREC); -- 0

--update DIGITAL_BOOTH_BACKUP set BRNCHNO = BRNCHNO + 1;
--commit;
ALTER TABLE OFFICE ADD DBOOTH_BACKUP_ID NUMBER(5,0);

update DIGITAL_BOOTH_BACKUP set TREC_ID = TRIM(TREC_ID), TREC_NAME = TRIM(TREC_NAME), BSEC_APPROVAL_DATE = TRIM(BSEC_APPROVAL_DATE), LOCATION = TRIM(LOCATION);
-- 258 rows updated.
commit;

SELECT TO_DATE(BSEC_APPROVAL_DATE, 'MM/DD/YYYY') AS formatted_date  FROM DIGITAL_BOOTH_BACKUP;
select BSEC_APPROVAL_DATE from DIGITAL_BOOTH_BACKUP where BSEC_APPROVAL_DATE is null;

-------------------------------------------INSERT OFFICE--------------------------------------------------------

select count(*) from office; -- 2022 -- 2280

SELECT *  FROM office WHERE to_date(ADDED_AT,'DD-MM-YYYY') = TO_DATE('02-JUN-24','DD-MM-YYYY');
--delete from office where to_date(ADDED_AT,'DD-MM-YYYY') = TO_DATE('02-JUN-24','DD-MM-YYYY');

select * from office o 
inner join OFFICE_TYPE  ot on o.OFFICE_ID = ot.OFFICE_ID 
where ot.type = 'DIGITAL BOOTH' order by o.office_id;

------------------------------------------------------------------------------------------------------------
DECLARE
  v_office_id NUMBER;
  v_office_no NUMBER;
BEGIN
  FOR r IN (
    SELECT ID, TREC_ID, BSEC_APPROVAL_DATE, LOCATION
    FROM DIGITAL_BOOTH_BACKUP
    ORDER BY TREC_ID
  ) LOOP
    -- Get the next OFFICE_ID
    SELECT NVL(MAX(OFFICE_ID), 0) + 1 INTO v_office_id FROM OFFICE;
    
    -- Get the next OFFICE_NO for the specific TREC_ID
    SELECT NVL(MAX(OFFICE_NO), 0) + 1 INTO v_office_no FROM OFFICE WHERE TREC_ID = r.TREC_ID;
    
    -- Insert into OFFICE table
    INSERT INTO OFFICE (OFFICE_ID, DBOOTH_BACKUP_ID, TREC_ID, OFFICE_NO, BSEC_APPROVAL_DATE, ADDED_BY)
    VALUES (v_office_id, r.ID, r.TREC_ID, v_office_no,  TO_DATE(r.BSEC_APPROVAL_DATE, 'MM/DD/YYYY'), 496);
    
    -- Increment OFFICE_NO for the next iteration
    -- v_office_no := v_office_no + 1;
  END LOOP;
END;
/
-- anonymous block completed
commit;

-------------------------------------------INSERT OFFICE_STATUS--------------------------------------------------------

select * from OFFICE_STATUS order by OFFICE_ID asc;

insert into OFFICE_STATUS (OFFICE_STATUS_ID, OFFICE_ID, STATUS, EFFECTIVE_DATE, ADDED_BY, ADDED_AT)
select (ROWNUM+ (select max(OFFICE_STATUS_ID) from OFFICE_STATUS)) as OFFICE_STATUS_ID,  r.OFFICE_ID, r.STATUS, r.EFFECTIVE_DATE, r.ADDED_BY, r.ADDED_AT from 
(
SELECT  
    a.OFFICE_ID, 
    a.ADDED_BY,
    a.ADDED_AT,
    a.BSEC_APPROVAL_DATE as EFFECTIVE_DATE,
    'ACTIVE' AS STATUS
FROM OFFICE a
where a.OFFICE_ID not IN ( SELECT OFFICE_ID from OFFICE_STATUS)
order by a.OFFICE_ID
) r;
-- 258 rows inserted
commit;

select * from OFFICE_STATUS where EFFECTIVE_DATE is null;
--update OFFICE_STATUS  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;

-------------------------------------------INSERT OFFICE_TYPE--------------------------------------------------------

select * from office_type;
--delete from OFFICE_TYPE;

INSERT INTO OFFICE_TYPE (OFFICE_TYPE_ID, OFFICE_ID, TYPE, EFFECTIVE_DATE, ADDED_BY, ADDED_AT)
SELECT (ROWNUM + (SELECT MAX(OFFICE_TYPE_ID) FROM OFFICE_TYPE)) AS OFFICE_TYPE_ID, r.OFFICE_ID, r.OFF_TYPE, r.EFFECTIVE_DATE, r.ADDED_BY, r.ADDED_AT
FROM 
(
SELECT  
    a.OFFICE_ID, 
    a.ADDED_BY,
    a.ADDED_AT,
    a.BSEC_APPROVAL_DATE as EFFECTIVE_DATE,
    'DIGITAL BOOTH' AS OFF_TYPE
    FROM OFFICE a
    where a.OFFICE_ID not IN ( SELECT OFFICE_ID from OFFICE_TYPE)
    order by a.OFFICE_ID
) r;
-- 258 rows inserted
commit;

select * from OFFICE_TYPE where EFFECTIVE_DATE is null;
--update OFFICE_TYPE  set EFFECTIVE_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where EFFECTIVE_DATE is null;
-- -- 258 rows inserted
commit;

-------------------------------------------INSERT OFFICE_ADDRESS--------------------------------------------------------


select * from OFFICE_ADDRESS order by OFFICE_ID asc;
--delete from OFFICE_ADDRESS;

insert into OFFICE_ADDRESS (OFFICE_ADDRESS_ID, OFFICE_ID, LOCATION, ADDED_BY, ADDED_AT)
select (ROWNUM + (SELECT MAX(OFFICE_ADDRESS_ID) FROM OFFICE_ADDRESS)) AS OFFICE_ADDRESS_ID, r.OFFICE_ID, r.LOCATION, r.ADDED_BY, r.ADDED_AT from 
(
SELECT  
    a.OFFICE_ID, 
    a.ADDED_BY,
    a.ADDED_AT,
    --TRIM(BRLOC) As BRLOC,
    a.BSEC_APPROVAL_DATE as EFFECTIVE_DATE,
    b.LOCATION
FROM OFFICE a INNER JOIN DIGITAL_BOOTH_BACKUP b ON a.DBOOTH_BACKUP_ID = b.ID  order by a.OFFICE_ID
) r;

-- 258 rows inserted
commit;

select * from OFFICE_ADDRESS where OPERATION_START_DATE is null;
update OFFICE_ADDRESS  set OPERATION_START_DATE = TO_DATE('01/01/1900','MM/DD/YYYY') where OPERATION_START_DATE is null;
-- 258 rows updated.
commit;
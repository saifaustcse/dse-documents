
------------------------------------------------------------------
-- drop table AUTH_REP_CONTACT_BACKUP;
-- delete from AUTH_REP_CONTACT_BACKUP;
commit;

---------------------AUTH_REP_CONTACT_BACKUP---------------------------------------

CREATE TABLE AUTH_REP_CONTACT_BACKUP 
( 
--TREC_NAME VARCHAR2(150),
TREC_NO NUMBER(10),
AR_NAME VARCHAR2(250),
BSEC_REG_NO VARCHAR2(100),
MOBILE VARCHAR2(100),
EMAIL VARCHAR2(100),
PERSONNEL_ID NUMBER(10,0) NULL
);

----------------------------------------------------------------------------------

select count(*) from AUTH_REP_CONTACT_BACKUP; -- 5880
select count(*) from AUTH_REP ; -- 12995 
select 12995-5880 from dual; --7115

select count(distinct BSEC_REG_NO) from AUTH_REP_CONTACT_BACKUP; -- 5879
select count(distinct BSEC_REG_NO) from AUTH_REP ; -- 10200 
select 10200-5879 from dual; --4321


select count(*) from VW_AUTH_REP where status='ACTIVE' or  status='RESUMED'  order by TREC_ID, BSEC_REG_NO; -- 5871
select count(*) from AUTH_REP_CONTACT_BACKUP order by TREC_NO, BSEC_REG_NO ; -- 5880

select TREC_NO, PERSONNEL_NAME, BSEC_REG_NO, PERSONAL_CONTACT_NO, PERSONAL_EMAIL 
from VW_AUTH_REP where status='ACTIVE' or status='RESUMED' order by TREC_ID, BSEC_REG_NO; -- 5871

select * from AUTH_REP_CONTACT_BACKUP order by TREC_NO, BSEC_REG_NO ; -- 5880

----------------------------------------------------------------------------------

select count(*) from AUTH_REP_CONTACT_BACKUP where BSEC_REG_NO not in ( select BSEC_REG_NO from AUTH_REP); --4
select count(distinct BSEC_REG_NO) from AUTH_REP_CONTACT_BACKUP where BSEC_REG_NO not in ( select BSEC_REG_NO from AUTH_REP);  --4
select * from AUTH_REP_CONTACT_BACKUP where BSEC_REG_NO not in ( select BSEC_REG_NO from AUTH_REP); --4

select count(*) from AUTH_REP where BSEC_REG_NO not in ( select BSEC_REG_NO from AUTH_REP_CONTACT_BACKUP); -- 5150
select count(distinct BSEC_REG_NO) from AUTH_REP where BSEC_REG_NO not in ( select BSEC_REG_NO from AUTH_REP_CONTACT_BACKUP); -- 4325
select * from AUTH_REP where BSEC_REG_NO not in ( select BSEC_REG_NO from AUTH_REP_CONTACT_BACKUP); -- 5150

----------------------------------------------------------------------------------

update AUTH_REP_CONTACT_BACKUP 
set TREC_NO = TRIM(TREC_NO), AR_NAME = TRIM(AR_NAME),  BSEC_REG_NO = TRIM(BSEC_REG_NO), MOBILE = TRIM(MOBILE),  EMAIL = TRIM(EMAIL); 
-- 5,880 rows updated.

update AUTH_REP_CONTACT_BACKUP set BSEC_REG_NO = 'BSEC/AR/CSE/2013/1985' where  BSEC_REG_NO = 'BSEC//AR/CSE/2013/1985';
update AUTH_REP_CONTACT_BACKUP set BSEC_REG_NO = 'SEC/AR/DSE/2007/603' where  BSEC_REG_NO = 'SEC/AR/DSE//2007/603';
-- 1 rows updated
commit;

----------------------------------------------------------------------------------
select PERSONNEL_ID, count(PERSONNEL_ID) from AUTH_REP_CONTACT_BACKUP group by PERSONNEL_ID having count(PERSONNEL_ID)>1; -- 1

select count(*) from AUTH_REP_CONTACT_BACKUP where BSEC_REG_NO in ( select BSEC_REG_NO from AUTH_REP); --5876

select  count( distinct ar.BSEC_REG_NO)  from PERSONNEL p
inner join AUTH_REP ar on p.PERSONNEL_ID = ar.PERSONNEL_ID
inner join AUTH_REP_CONTACT_BACKUP arc
on ar.BSEC_REG_NO =  arc.BSEC_REG_NO; -- 5875

select  count(*)  from PERSONNEL p
inner join AUTH_REP ar on p.PERSONNEL_ID = ar.PERSONNEL_ID
inner join AUTH_REP_CONTACT_BACKUP arc
on ar.BSEC_REG_NO =  arc.BSEC_REG_NO; -- 7848

select * from PERSONNEL p
inner join AUTH_REP ar on p.PERSONNEL_ID = ar.PERSONNEL_ID
inner join AUTH_REP_CONTACT_BACKUP arc
on ar.BSEC_REG_NO =  arc.BSEC_REG_NO;-- 7848

----------------------------------------------------------------------------------

ALTER TABLE TREC_TREC.PERSONNEL
MODIFY (PERSONAL_EMAIL VARCHAR2(60));

----------------------------------------------------------------------------------

UPDATE AUTH_REP_CONTACT_BACKUP arcnew
SET arcnew.PERSONNEL_ID = (
    SELECT MAX(p.PERSONNEL_ID)
    FROM PERSONNEL p
    INNER JOIN AUTH_REP ar ON p.PERSONNEL_ID = ar.PERSONNEL_ID
    WHERE ar.BSEC_REG_NO = arcnew.BSEC_REG_NO
)
WHERE EXISTS (
    SELECT 1
    FROM PERSONNEL p
    INNER JOIN AUTH_REP ar ON p.PERSONNEL_ID = ar.PERSONNEL_ID
    WHERE ar.BSEC_REG_NO = arcnew.BSEC_REG_NO
);
-- 5,876 rows updated.


select count(*) from AUTH_REP_CONTACT_BACKUP; -- 5880
select * from AUTH_REP_CONTACT_BACKUP where PERSONNEL_ID is null; -- 4

select arb.TREC_NO,arb.BSEC_REG_NO, arb.AR_NAME, p.NAME, arb.EMAIL, p.PERSONAL_EMAIL, arb.MOBILE, p.PERSONAL_CONTACT_NO from AUTH_REP_CONTACT_BACKUP arb
inner join PERSONNEL p on arb.PERSONNEL_ID = p.PERSONNEL_ID
where trim(arb.AR_NAME) <> trim(p.NAME);


MERGE INTO PERSONNEL p
USING (
SELECT arb.PERSONNEL_ID,
MAX(arb.EMAIL) AS EMAIL,
MAX(arb.MOBILE) AS MOBILE
FROM AUTH_REP_CONTACT_BACKUP arb
GROUP BY arb.PERSONNEL_ID
) arb
ON (p.PERSONNEL_ID = arb.PERSONNEL_ID)
WHEN MATCHED THEN
UPDATE SET p.PERSONAL_EMAIL = arb.EMAIL,
p.PERSONAL_CONTACT_NO = arb.MOBILE;

-- 5,876 rows updated.

commit;

select arb.TREC_NO,arb.BSEC_REG_NO, arb.AR_NAME, p.NAME, arb.EMAIL, p.PERSONAL_EMAIL, arb.MOBILE, p.PERSONAL_CONTACT_NO from AUTH_REP_CONTACT_BACKUP arb
inner join PERSONNEL p on arb.PERSONNEL_ID = p.PERSONNEL_ID
where trim(arb.EMAIL) <> trim(p.PERSONAL_EMAIL);

select arb.TREC_NO,arb.BSEC_REG_NO, arb.AR_NAME, p.NAME, arb.EMAIL, p.PERSONAL_EMAIL, arb.MOBILE, p.PERSONAL_CONTACT_NO from AUTH_REP_CONTACT_BACKUP arb
inner join PERSONNEL p on arb.PERSONNEL_ID = p.PERSONNEL_ID
where trim(arb.MOBILE) <> trim(p.PERSONAL_CONTACT_NO);

----------------------------------------------------------------------------------
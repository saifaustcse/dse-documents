select * from PERSONNEL where PERSONNEL_ID = 6594; -- Mr. Md. Raihanul Huq
select * from AUTH_REP where PERSONNEL_ID=6594; --4409
select * from workstation_auth_rep where AUTH_REP_ID = 4409;
--select * from workstation where WORKSTATION_ID = 1031;

select * from PERSONNEL where PERSONNEL_ID = 6608; -- Mr. Atique Mahmud
select * from AUTH_REP where PERSONNEL_ID=6608; --4423
select * from workstation_auth_rep where AUTH_REP_ID = 4423;
--select * from workstation where WORKSTATION_ID = 1030;

select * from workstation_auth_rep  where workstation_auth_rep_id = 361;
--update workstation_auth_rep set AUTH_REP_ID=4423 where workstation_auth_rep_id = 361;
--commit;

select * from  workstation_auth_rep war 
inner join PERSONNEL p on p.PERSONNEL_ID = war.PERSONNEL_ID
inner join AUTH_REP ar on p.PERSONNEL_ID = ar.PERSONNEL_ID
where war.AUTH_REP_ID <> ar.AUTH_REP_ID; --78

----------------------------------------------------------

select NAME, IMAGE_PATH from personnel where PERSONNEL_ID = 15901;

select PERSONNEL_ID, TREC_ID, NAME, IMAGE_PATH, SIGNATURE_PATH from personnel where IMAGE_PATH like '%TMS_FILES_PHOTOS\PersonnelPhoto\159%';

select PERSONNEL_ID, TREC_ID, NAME, IMAGE_PATH from personnel where PERSONNEL_ID = 159;

--update personnel set IMAGE_PATH = null where PERSONNEL_ID=159;
commit;

----------------------------------------------------------

select * from AUTH_REP WHERE TREC_ID=30 and BSEC_REG_NO='BSEC/AR/DSE/2024/8871';
select * from AUTH_REP_STATUS where AUTH_REP_ID=12910;
select * from AUTH_REP_RENEW where AUTH_REP_ID=12910;
select * from WORKSTATION_AUTH_REP where AUTH_REP_ID=12910;

delete from AUTH_REP_RENEW where AUTH_REP_ID=12910;
delete from AUTH_REP_STATUS where AUTH_REP_ID=12910;
delete from AUTH_REP where AUTH_REP_ID=12910;
commit;

select * from AUTH_REP WHERE BSEC_REG_NO='BSEC/AR/DSE/2024/8886';
select * from AUTH_REP_RENEW where AUTH_REP_ID=12886;
UPDATE AUTH_REP_RENEW SET RENEW_DATE = NULL WHERE AUTH_REP_ID=12886;
commit;

----------------------------------------------------------

select * from WORKSTATION where trec_id=29 and TWS_NAME='FIRTRDR014';
select * from WORKSTATION where trec_id=29 and TWS_NAME='FIRTRDR013';

select * from WORKSTATION_STATUS where WORKSTATION_ID=823;
select * from WORKSTATION_OFFICE where WORKSTATION_ID=824;
update WORKSTATION_OFFICE set IS_ACTIVE=0 where WORKSTATION_OFFICE_ID=3149;
commit;

select * from WORKSTATION_STATUS where WORKSTATION_ID=823 and WORKSTATION_STATUS_ID=2027;
delete from WORKSTATION_STATUS where WORKSTATION_ID=823 and WORKSTATION_STATUS_ID=2027;
commit;

----------------------------------------------------------

select * from workstation where TREC_ID=205;
select * from WORKSTATION_STATUS  where TREC_ID=205;

select * from workstation w
inner join WORKSTATION_STATUS st
on w.workstation_id = st.workstation_id
where w.TREC_ID=205;


select * from WORKSTATION w
inner join WORKSTATION_STATUS ws 
on w.WORKSTATION_ID = ws.WORKSTATION_ID
and w.TREC_ID=89 and w.TWS_NAME like '%12%'


select * from WORKSTATION;
select * from WORKSTATION_AUTH_REP;
select * from WORKSTATION_OFFICE;

SELECT wo.WORKSTATION_ID, w.TREC_ID
FROM WORKSTATION_OFFICE wo
INNER join WORKSTATION w on wo.WORKSTATION_ID=w.WORKSTATION_ID
WHERE wo.IS_ACTIVE = 0
GROUP BY wo.WORKSTATION_ID, w.TREC_ID
HAVING COUNT(wo.WORKSTATION_ID) > 1
order by w.trec_id;

SELECT war.WORKSTATION_ID, w.TREC_ID
FROM WORKSTATION_AUTH_REP war
INNER join WORKSTATION w on war.WORKSTATION_ID=w.WORKSTATION_ID
WHERE war.IS_ACTIVE = 0
GROUP BY war.WORKSTATION_ID, w.TREC_ID
HAVING COUNT(war.WORKSTATION_ID) > 1
order by w.trec_id;


DELETE FROM WORKSTATION_OFFICE 
WHERE WORKSTATION_OFFICE_ID IN (
    SELECT wo.WORKSTATION_OFFICE_ID
    FROM WORKSTATION_OFFICE wo
    INNER JOIN WORKSTATION w ON w.WORKSTATION_ID = wo.WORKSTATION_ID
    WHERE wo.IS_ACTIVE = 0
    AND w.TREC_ID BETWEEN 76 AND 100
);
--61 rows deleted.

commit;


DELETE FROM WORKSTATION_AUTH_REP
WHERE WORKSTATION_AUTH_REP_ID IN (
    SELECT WORKSTATION_AUTH_REP_ID
    FROM WORKSTATION_AUTH_REP war
    INNER JOIN WORKSTATION w ON w.WORKSTATION_ID = war.WORKSTATION_ID
    WHERE war.IS_ACTIVE = 0
    AND w.TREC_ID BETWEEN 76 AND 100
);
--61 rows deleted.

commit;


-- DLR_TWS is active, but the license is not active List
select * from VW_WORKSTATION where TWS_CATERGORY='D' and IS_ACTIVE=1;
select * from VW_DEALER where STATUS='ACTIVE';

select * from VW_WORKSTATION where TWS_CATERGORY='D' and IS_ACTIVE=1
and TREC_ID not in (select TREC_ID from VW_DEALER where STATUS='ACTIVE');

----------------------------------------------------------

select * from WORKSTATION_AUTH_REP war
INNER join WORKSTATION w on w.WORKSTATION_ID = war.WORKSTATION_ID 
and w.TREC_ID=164 and w.TWS_NAME ='MFCDLR01'
and war.END_DATE is null
and war.IS_ACTIVE=0;

SELECT * 
FROM WORKSTATION_AUTH_REP war
WHERE EXISTS (
    SELECT 1
    FROM WORKSTATION w
    WHERE w.WORKSTATION_ID = war.WORKSTATION_ID
    AND w.TREC_ID = 164
    AND w.TWS_NAME = 'MFCITRDR02'
)
AND war.IS_ACTIVE = 0;

DELETE FROM WORKSTATION_AUTH_REP where WORKSTATION_AUTH_REP_ID=5214;

DELETE FROM WORKSTATION_AUTH_REP war
WHERE EXISTS (
    SELECT 1
    FROM WORKSTATION w
    WHERE w.WORKSTATION_ID = war.WORKSTATION_ID
    AND w.TREC_ID = 164
    AND w.TWS_NAME = 'MFCDLR01'
)
AND war.END_DATE IS NULL
AND war.IS_ACTIVE = 0;
commit;

----------------------------------------------------------

select DISTRICT, count(*) from VW_OFFICE where IS_ACTIVE=1
group by DISTRICT order by count(*) desc;

select TREC_ID, TREC_NAME, DISTRICT, count(*) from VW_OFFICE where IS_ACTIVE=1
group by DISTRICT, TREC_ID, TREC_NAME order by TREC_ID;

select * from VW_OFFICE where DISTRICT is null and IS_ACTIVE=1; --553
select * from VW_OFFICE where DISTRICT is not null and IS_ACTIVE=1; -- 1117


select * from WORKSTATION_AUTH_REP war
inner join WORKSTATION ar on ar.WORKSTATION_ID=war.WORKSTATION_ID
and ar.TREC_ID=237 order by ar.TWS_NAME;


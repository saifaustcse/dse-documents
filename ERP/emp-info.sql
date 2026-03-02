

select * from DSESMS.USER_PROFILE;
select * from DSESMS.TBLEMPINFO;

---------------------------------------Percentage -----------------------------------------------------

SELECT e.*, (((si.BASIC_SALARY - bc.BASIC_SALARY)/bc.BASIC_SALARY)*100) as percent
FROM EMP_SALARY_INFO_BACKUP bc
INNER JOIN EMP_SALARY_INFO si ON si.EMPID = bc.EMPID AND bc.SALAY_YEAR = 2022 
inner join EMPINFO e on e.EMPID = bc.EMPID
where (((si.GROSS_SALARY - bc.GROSS_SALARY)/bc.GROSS_SALARY)*100) <8.5;

---------------------------------------------------------------------------------------------------------

SELECT e.EMPID, e.FULLNAME, (((si.BASIC_SALARY - bc.BASIC_SALARY)/bc.BASIC_SALARY)*100) as percent
FROM EMP_SALARY_INFO_BACKUP bc
INNER JOIN EMP_SALARY_INFO si ON si.EMPID = bc.EMPID AND bc.END_DATE = '30-SEP-23'
inner join EMPINFO e on e.EMPID = bc.EMPID
where e.EMPID = 496
order by percent desc;

-----------------------------------------Gross ---------------------------------------------------------

select * from EMPINFO  e
INNER JOIN EMP_SALARY_INFO si ON si.EMPID = e.EMPID 
order by si.GROSS_SALARY desc;

-----------------------------------------Age ---------------------------------------------------------

SELECT e.*, TRUNC(MONTHS_BETWEEN(SYSDATE, DOB) / 12) AS age
FROM DSESMS.TBLEMPINFO e 
order by TRUNC(MONTHS_BETWEEN(SYSDATE, DOB) / 12) desc;

-----------------------------------------Service ---------------------------------------------------------

SELECT e.*, TRUNC(MONTHS_BETWEEN(SYSDATE, e.JOINDATE) / 12) AS service
FROM DSESMS.TBLEMPINFO e 
order by TRUNC(MONTHS_BETWEEN(SYSDATE, e.JOINDATE) / 12) desc;
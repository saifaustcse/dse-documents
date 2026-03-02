

---------------------------------------trec -----------------------------------------------------
select * from TREC.TREC order by TREC_NO desc;
select * from trec where TREC_NO = 51;
--update trec set NAME='Elegant Stock & Securities Ltd', CODE='ELE' where TREC_NO=51;
--update TREC.TREC set code ='PRC' where TREC_ID=6269;
--commit;

-----------------------------------------DEALER_LICENSE -------------------------------------------------------------------

select * from DEALER_LICENSE order by DEALER_LICENSE_ID desc ;
select count(*), TREC_ID from DEALER_LICENSE GROUP by TREC_ID HAVING count(*)>1;
select * from DEALER_LICENSE where TREC_ID = 6272 ;
select MAX(DEALER_LICENSE_ID)+1 from DEALER_LICENSE;
desc DEALER_LICENSE

insert into DEALER_LICENSE(DEALER_LICENSE_ID, TREC_ID, BSEC_REG_ISSUANCE_DATE, EXPIRY_DATE, BSEC_REG_NO, REMARKS,  STATUS) values ((select MAX(DEALER_LICENSE_ID)+1 from DEALER_LICENSE), 6272, '01-JUN-10', '01-JUN-25', 'REG.-3.1/DSE-272/2022/615', 'No Remarks', 'ACTIVE');
commit;

---------------------------------------MAKER and CHECKER-----------------------------------------------------

select * from trec 
where TREC_NO < 251
and TREC_NO not IN
(
  select ut.TREC_NO
  from USER_PROFILE up 
  inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
  inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
  where  tui.ISACTIVE='Y'
  and up.CREATION_DATE >= '01-MAR-23'
  AND (ut.USER_STATUS ='MAKER' OR ut.USER_STATUS ='CHECKER')
)
order by TREC_NO;

---------------------------------------MAKER and CHECKER-----------------------------------------------------

select TREC_NO, CODE, NAME, 'MAKER' from trec 
where TREC_NO < 251
and TREC_NO not IN
(
  select ut.TREC_NO
  from USER_PROFILE up 
  inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
  inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
  where  tui.ISACTIVE='Y'
  and ut.USER_STATUS ='MAKER'
  and up.CREATION_DATE >= '01-FEB-22'
)

UNION  
select TREC_NO, CODE, NAME, 'CHECKER' from trec 
where TREC_NO < 251
and TREC_NO not IN
(
  select ut.TREC_NO
  from USER_PROFILE up 
  inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
  inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
  where  tui.ISACTIVE='Y'
  and ut.USER_STATUS ='CHECKER'
  and up.CREATION_DATE >= '01-FEB-22'
)
order by TREC_NO;
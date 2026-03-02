


---------------------------------------DELETE TREC USER-----------------------------------------------------

delete from USER_PROFILE_MAPPING where LOGINID > 600;
delete from USER_PROFILE where USER_PROFILE_ID NOT in (select USER_PROFILE_ID from USER_PROFILE_MAPPING);
delete from USER_EMP_INFO where LOGINID NOT in (select LOGINID from USER_PROFILE_MAPPING);
delete from TBLAUDITLOGINFO where USERID NOT in (select LOGINID from USER_PROFILE_MAPPING);
delete from USER_TREC where LOGINID NOT in (select LOGINID from USER_PROFILE_MAPPING);
delete from TBLUSERINFO where LOGINID NOT in (select LOGINID from USER_PROFILE_MAPPING);
commit;

---------------------------------------USERS-----------------------------------------------------

select * from USER_PROFILE;
select * from TBLUSERINFO;
select * from USER_PROFILE_MAPPING;
select * from USER_TREC;

select * from TBLEMPINFO;
select * from USER_EMP_INFO;
select * from TBLUSERROLEINFO;

select * from USER_PROFILE_MAPPING  order by USER_PROF_MAP_ID desc;
--update USER_PROFILE_MAPPING set LOGINID=7668 where USER_PROF_MAP_ID =2418;

select * from TREC.TREC where TREC_NO=265
select * from USER_TREC where TREC_NO=265;
--update USER_TREC set LOGINID=7668 where USER_TREC_ID =1924;
--update USER_TREC set USER_STATUS='CHECKER' where USER_TREC_ID = 1922;
commit;

select * from  TBLUSERROLEINFO order by id desc; 
select * from  TBLUSERROLEINFO where LOGINID=2668;
--delete from  TBLUSERROLEINFO where LOGINID=2668;

----------------------------------------------USER_PROFILE------------------------------------------

select * from USER_PROFILE where USER_PROFILE_ID > 6001 and USER_PROFILE_ID < 8000  order by USER_PROFILE_ID desc ;
select * from USER_PROFILE where USER_PROFILE_ID=7292;
--update USER_PROFILE set FULLNAME='Shifat Ahmed' where USER_PROFILE_ID=7305;
--update USER_PROFILE set  EMAIL='riashadahnaf@gmail.com' where USER_PROFILE_ID=7292;
--update USER_PROFILE set FULLNAME='Sohel Khan', EMAIL='sohel.accounts@bnbsecuritiesltd.com' where USER_PROFILE_ID=7309;

----------------------------------------------TBLUSERINFO ------------------------------------------

select * from TBLUSERINFO where USER_ID ='tks.hasan';
select * from USER_PROFILE where  lower(FULLNAME) like '%saiful%';
select * from USER_PROFILE where USER_PROFILE_ID=496;
select * from TBLUSERINFO where LOGINID=496;
select * from TBLUSERINFO where lower(USER_ID) like '%saiful%';

-- update TBLUSERINFO set set ISACTIVE='Y', STATUS='OPEN', USERPASSWORD='MQ==', PASSWORD_CHANGE_DATE='01-JUL-25' where LOGINID=496; -- 1
-- update USER_PROFILE set STATUS='APPROVED' where USER_PROFILE_ID=496;

-- update TBLUSERINFO set LOGINID=7668 where USER_ID ='tks.hasan';
-- update TBLUSERINFO set user_id='sil.riashad' where LOGINID = 7293;
-- update TBLUSERINFO set ISACTIVE='N', STATUS='DELETED' where LOGINID=6818;

-- select * from TBLUSERINFO where LOGINID> 600;
-- update TBLUSERINFO set ISACTIVE='N', STATUS='DELETED' where LOGINID> 600;
-- update USER_PROFILE set STATUS='DELETED' where USER_PROFILE_ID> 600;

select * from TBLUSERINFO where LOGINID=419;
select * from USER_PROFILE where USER_PROFILE_ID=419;

update TBLUSERINFO set ISACTIVE='Y', STATUS='OPEN', PASSWORD_CHANGE_DATE='30-AUG-23', USERPASSWORD='MQ==' where LOGINID in 
(
58, 81, 91, 100, 111, 114, 133, 137, 138, 139, 144, 162, 360, 366, 419, 512, 524
);

update USER_PROFILE set STATUS='APPROVED' where USER_PROFILE_ID in 
(
58, 81, 91, 100, 111, 114, 133, 137, 138, 139, 144, 162, 360, 366, 419, 512, 524
)
commit;

update TBLUSERINFO set PASSWORD_CHANGE_DATE = TO_DATE('07/07/2022', 'MM/DD/YYYY');
update user_profile set EMAIL = 'nomail@dse.com.bd';
update tbluserinfo set USERPASSWORD = 'MQ==';
-- commit;

---------------------------------------All USERS-----------------------------------------------------

select up.USER_PROFILE_ID, tui.LOGINID, tui.USER_ID, tui.USER_CAT_ID, up.EMAIL, tui.USERPASSWORD, up.STATUS, tui.ISACTIVE
from USER_PROFILE up 
inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
where tui.ISACTIVE='Y'
order by up.USER_PROFILE_ID desc;

----------------------------------------TREC USERS--------------------------------------------------

select up.USER_PROFILE_ID,up.DESIGNATION, up.FULLNAME, up.GENDER, up.MOBILE, up.NID, up.EMAIL,  up.STATUS,
       tui.LOGINID, tui.USER_ID, tui.USER_CAT_ID, tui.CODE, tui.IS_OTP_ENABLE, tui.USERPASSWORD, tui.ISACTIVE,
       ut.USER_TREC_ID, ut.TREC_NO, ut.USER_STATUS
from USER_PROFILE up 
inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
where ut.TREC_NO=285
AND tui.ISACTIVE='Y'
order by ut.TREC_NO;

-----------------------------------------USER Exceptions-------------------------------------------------------------------

select * from user_exception order by 1;
insert into user_exception values (6, 496, 669, 'Y', 'ACTIVE');
commit;

-----------------------------------------USER_HOMEPAGE-------------------------------------------------------------------
insert into USER_HOMEPAGE(ID, LOGINID, LINK, ISDELETED, STATUS) values ((select MAX(ID)+1 from USER_HOMEPAGE) , 419, '/Trec/ADMIN/forms/dashboard/tadDashboard.aspx', 'N', 'Active');
commit;






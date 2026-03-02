

delete from TBLUSERROLEINFO ;
delete from ROLE_TYPE ;

delete from tbluserprivilege;
delete from tblroledetails ;

delete from TBLROLE ;
delete from tblmenu ;

delete from tblauditmaster;
delete from TBLAUDITDETAIL;

commit;

----------------------------------------------

select * from TBLROLE order by ROLEID;
select * from ROLE_TYPE order by ROLE_TYPE_ID;
select * from TBLUSERROLEINFO order by ID;

select * from tblmenu order by MENUID;
select * from tblroledetails order by ID;
select * from tbluserprivilege order by ID;
desc tblmenu;

SELECT 'INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES (''' || tr.ROLEID || ''', ''' || tr.ROLENAME || ''', ''' || tr.DESCRIPTION || ''');'
FROM TBLROLE tr
ORDER BY ROLEID;

SELECT 'INSERT INTO ROLE_TYPE (ROLE_TYPE_ID, ROLEID, USER_GROUP, USER_TYPE, ISDELETED, STATUS, ORGANIZATION) VALUES (''' || rt.ROLE_TYPE_ID || ''', ''' || rt.ROLEID || ''', ''' || rt.USER_GROUP || ''', ''' || rt.USER_TYPE || ''', ''' || rt.ISDELETED || ''', ''' || rt.STATUS || ''', ''' || rt.ORGANIZATION || ''');'
FROM ROLE_TYPE rt
ORDER BY ROLE_TYPE_ID;

desc TBLUSERROLEINFO;
SELECT 'INSERT INTO TBLUSERROLEINFO (ID, LOGINID, ROLEID) VALUES (' || uri.ID || ', ' || uri.LOGINID || ', ' || uri.ROLEID || ');'
FROM TBLUSERROLEINFO uri
INNER JOIN TBLUSERINFO ui ON uri.LOGINID = ui.LOGINID 
WHERE ui.ISACTIVE = 'Y' and ui.STATUS='OPEN'
ORDER BY uri.ID;

SELECT 'INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES (''' || tm.MENUID || ''', ''' || tm.MENUNAME || ''', ''' || tm.LINK || ''', ' || tm.PARENTID || ', ' || tm.MENUORDER || ');'
FROM tblmenu tm
ORDER BY MENUID;

SELECT 'INSERT INTO tblroledetails (ID, ROLEID, MENUID, SELECTSTATUS, INSERTSTATUS, UPDATESTATUS, DELETESTATUS) VALUES (' || trd.ID || ', ' || trd.ROLEID || ', ' || trd.MENUID || ', ' || trd.SELECTSTATUS || ', ' || trd.INSERTSTATUS || ', ' || trd.UPDATESTATUS || ', ' || trd.DELETESTATUS || ');'
FROM tblroledetails trd
ORDER BY ID;

SELECT 'INSERT INTO tbluserprivilege (ID, LOGINID, MENUID, SELECTSTATUS, INSERTSTATUS, UPDATESTATUS, DELETESTATUS) VALUES (' 
       || up.ID || ', ' || up.LOGINID || ', ' || up.MENUID || ', ' 
       || up.SELECTSTATUS || ', ' || up.INSERTSTATUS || ', ' || up.UPDATESTATUS || ', ' || up.DELETESTATUS || ');'
FROM tbluserprivilege up
ORDER BY ID;

-----------------------------------------------------------------------------------------------------------------------------

select 'insert into tbluserroleinfo(id,loginId,roleId) values ((select max(id)+1 from tbluserroleinfo),'||tui.LOGINID||',63 );' 
from USER_PROFILE up 
inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
where tui.ISACTIVE='Y'
and ut.USER_STATUS = 'MAKER'
order by ut.TREC_NO asc;

-----------------------------------------------------------------------

select * from tblmenu where lower(LINK) like '%/trec/%' order by LINK;
select * from tblmenu where  lower(LINK) like '%/trec/name_change%';

--select * from TBLROLE order by ROLENAME;
--select * from tbluserroleinfo order by LOGINID;
select * from tblroledetails order by ROLEID;
select * from tbluserprivilege order by LOGINID;
select * from tblauditmaster;
select * from TBLAUDITDETAIL;

delete from tblmenu where  lower(LINK) like '%/trec/name_change%';
--select * from all_constraints where constraint_name ='FK_MENUID_TBLMENU';

delete from tblroledetails 
where  MENUID in (
select MENUID from tblmenu where  lower(LINK) like '%/trec/name_change%'
);

delete from tbluserprivilege 
where  MENUID in (
select MENUID from tblmenu where  lower(LINK) like '%/trec/name_change%'
);

delete from tblauditmaster 
where  MENUID in (
select MENUID from tblmenu where  lower(LINK) like '%/trec/name_change%'
);

delete from TBLAUDITDETAIL
where AUDITID in (
      select ID from tblauditmaster
      where  MENUID in (
      select MENUID from tblmenu where  lower(LINK) like '%/trec/name_change%'
      )
);

---------------------------------------------------------------------------------------------------------------------------------------

select * from tblrole ORDER by ROLENAME;
select * from tblrole where roleid not in (select  ROLEID from tblroledetails);
select roleid from tblrole where roleid not in (select  ROLEID from tblroledetails);

--select * from TBLUSERROLEINFO where  ROLEID = 29;
delete from TBLUSERROLEINFO where roleid in (select roleid from tblrole where roleid not in (select  ROLEID from tblroledetails ));

--select * from TBLROLEDETAILS where  ROLEID = 29;
delete from TBLROLEDETAILS where roleid in (select roleid from tblrole where roleid not in (select  ROLEID from tblroledetails ));

--select * from tbluserprivilege   where  ROLEID = 29;
delete from tbluserprivilege   where  ROLEID  in (select roleid from tblrole where roleid not in (select  ROLEID from tblroledetails ));
commit;

---------------------------------------------------------------------------------------------------------------------------------------


SELECT * FROM TBLMENU order by link;
select * from TBLMENU  where MENUID not in ( select MENUID from tblroledetails);

delete from tblroledetails where MENUID in ( 315, 379, 536, 535, 193, 195, 184);
delete from tbluserprivilege where MENUID in ( 315, 379, 536, 535, 193, 195, 184);
delete from TBLMENU  where MENUID in ( 315, 379, 536, 535, 193, 195, 184);
commit;

select * from TBLMENU where link='#' and MENUID not in (select parentId from TBLMENU);
delete from TBLMENU where link='#' and MENUID not in (select parentId from TBLMENU);
delete from tblroledetails where MENUID in ( select MENUID from TBLMENU where link='#' and MENUID not in (select parentId from TBLMENU));
delete from tbluserprivilege where MENUID in ( select MENUID from TBLMENU where link='#' and MENUID not in (select parentId from TBLMENU));
delete from TBLMENU  where MENUID in ( 315, 379, 536, 535, 193, 195, 184);
commit;

--------------------------TREC MAKER CHECKER ---------------------------------

select distinct up.USER_PROFILE_ID
from USER_PROFILE up 
inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
inner join TBLUSERROLEINFO ri on ri.LOGINID = tui.LOGINID 
where tui.ISACTIVE='Y'
and tui.LOGINID between 6254 and 7000
and up.USER_PROFILE_ID not in (
select distinct up.USER_PROFILE_ID
from USER_PROFILE up 
inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
inner join TBLUSERROLEINFO ri on ri.LOGINID = tui.LOGINID 
where tui.ISACTIVE='Y'
AND tui.LOGINID between 6254 and 7000
AND ri.ROLEID=50)
order by up.USER_PROFILE_ID;

------------------------------------New ROLE assign to all trec checker or maker ---------------------------------------

select 'insert into tbluserroleinfo(id,loginId,roleId) values ((select max(id)+1 from tbluserroleinfo),'||tui.LOGINID||',63 );' 
from USER_PROFILE up 
inner join TBLUSERINFO tui on tui.LOGINID = up.USER_PROFILE_ID 
inner join USER_TREC ut on ut.LOGINID = up.USER_PROFILE_ID 
where tui.ISACTIVE='Y'
and ut.USER_STATUS = 'MAKER'
order by ut.TREC_NO asc;

insert into tbluserroleinfo(id,loginId,roleId) values ((select max(id)+1 from tbluserroleinfo),6955,63 );

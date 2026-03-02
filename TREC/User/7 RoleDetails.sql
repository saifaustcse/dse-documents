-- All Menus to Admin
SELECT 'INSERT INTO tblroledetails (ID, ROLEID, MENUID, SELECTSTATUS, INSERTSTATUS, UPDATESTATUS, DELETESTATUS) VALUES (' || tm.MENUID || ', ' || 1 || ', ' || tm.MENUID|| ', ' || 1|| ', ' || 1 || ', ' || 1 || ', ' || 1 || ');'
FROM tblmenu tm 
ORDER BY MENUID;

commit;
-- delete from ROLE_TYPE ; -- no data
-- delete from TBLUSERROLEINFO ; 
select distinct ROLEID from TBLUSERROLEINFO order by ROLEID;
-- 1,3,10,11,12

delete from tblroledetails ; -- will be reinserted using UI as menu is not same for the existing user-role-info 1,3,10,11,12
-- delete from tbluserprivilege; -- no data

delete from TBLAUDITDETAIL; 
-- delete from TBLAUDITDETAIL_LOB; -- no data
delete from tblauditmaster;


select * from tblmenu  order by 1; -- Match using diffchecker
delete from tblmenu ;
-- delete from TBLROLE ;

commit;

-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('1', 'Admin', 'Admin holds all access ');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('2', 'Support Admin', 'For user creation and support');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('3', 'Common User', 'For all commom menu access');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('4', 'Common Reports', 'For all commom reports access');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('5', 'Department Head', 'To perform deparmnet head activity');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('6', 'Division Head', 'To perform division head activity');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('7', 'HRM', 'Human Resource Management');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('8', 'Circular', 'To perform circular activity');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('9', 'Audit', 'Check Confidentical Activity');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('10', 'Application Support Department', 'For TREC Management System');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('11', 'Network Department', 'For TREC Management System');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('12', 'TREC Affairs Department', 'For TREC Management System');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('13', 'TREC Admin', 'For TREC holder companies');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('14', 'TREC Maker', 'For TREC holder companies');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('15', 'TREC Checker', 'For TREC holder companies');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('16', 'ATMS DSE Verifier', '');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('17', 'ATMS DSE Executor', '');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('18', 'ATMS Workflow Admin', '');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('19', 'ATMS Workflow Employee', '');
-- INSERT INTO TBLROLE (ROLEID, ROLENAME, DESCRIPTION) VALUES ('20', 'ATMS Workflow TREC', '');

commit;

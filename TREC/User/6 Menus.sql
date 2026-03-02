

--------------------------------------------- Parent Level 1 -----------------------------------------------------------

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('1', 'Home', '/User/BlankPage.aspx', 0, 0); -- blank
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('2', 'Dashboard', '/User/DashboardDse.aspx', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('3', 'TREC Dashboard', '/User/DashboardTrec.aspx', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('4', 'BSEC Dashboard', '/User/DashboardBSec.aspx', 0, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('5', 'Help', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('6', 'Admin', '#', 0, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('7', 'TREC Management', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('8', 'Broker Management', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('9', 'Dealer Management', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('10', 'TREC Personnel', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('11', 'Office Management', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('12', 'AR Management', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('13', 'Workstations', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('14', 'Director and Shareholders', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('15', 'TMS Reports', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('16', 'ATMS Module', '#', 0, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('17', 'ATMS Reports', '#', 0, 0);

--------------------------------------------- Parent Level 2 -----------------------------------------------------------

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('18', 'Menu', '#', 6, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('19', 'Role', '#', 6, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('20', 'Employee', '#', 6, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('21', 'Users', '#', 6, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('22', 'Params', '#', 6, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('23', 'Privileges', '#', 6, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('24', 'Audit', '#', 6, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('25', 'TREC List', '/TMS/Trec/TrecList.aspx', 7, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('26', 'TREC Capital', '/TMS/TrecCapital/List.aspx', 7, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('27', 'TREC Parent Company', '/TMS/TrecParentCompany/List.aspx', 7, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('28', 'TREC Auditor', '/TMS/TrecAuditor/List.aspx', 7, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('29', 'Dual TREC', '/TMS/DualTrec/List.aspx', 7, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('30', 'TREC Documents', '/TMS/TrecDocument/DocumentList.aspx', 7, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('31', 'TREC Network', '/TMS/TrecNetwork/List.aspx', 7, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('32', 'Broker License', '/TMS/Broker/BrokerList.aspx', 8, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('33', 'Broker Expiry Reminder', '/TMS/BrokerReminder/Reminders.aspx', 8, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('34', 'Dealer License', '/TMS/Dealer/DealerList.aspx', 9, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('35', 'Dealer Expiry Reminder', '/TMS/DealerReminder/Reminders.aspx', 9, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('36', 'Personnel List', '/TMS/Personnel/PersonnelList.aspx', 10, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('37', 'Compliance Authorities', '/TMS/TrecComplianceAuthority/List.aspx', 10, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('38', 'TREC Holder Representatives', '/TMS/TrecHolderRepresentative/List.aspx', 10, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('39', 'Power Of Attorneys', '/TMS/TrecPowerOfAttorney/List.aspx', 10, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('40', 'TREC CAMALCO', '/TMS/TrecCamalco/List.aspx', 10, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('41', 'TREC Office List', '/TMS/Office/Offices.aspx', 11, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('42', 'TREC Office Network', '/TMS/OfficeNetwork/OfficeList.aspx', 11, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('43', 'Authorized Representatives', '/TMS/AuthRep/AuthRepList.aspx', 12, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('44', 'AR Expiry Reminder', '/TMS/AuthRepReminder/Reminders.aspx', 12, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('45', 'Workstation List', '/TMS/Workstation/Workstations.aspx', 13, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('46', 'Information Entry', '/TMS/ShareHolder/ShareHolderList.aspx', 14, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('47', 'Director Information', '/TMS/ShareHolder/DirectorList.aspx', 14, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('48', 'Shareholder Information', '/TMS/ShareHolder/ShareEntryList.aspx', 14, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('49', 'Share Transfer Information', '/TMS/ShareHolder/ShareTransferList.aspx', 14, 0);


INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('50', 'TREC Reports', '#', 15, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('51', 'Broker Reports', '#', 15, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('52', 'Dealer Reports', '#', 15, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('53', 'Office Reports', '#', 15, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('54', 'AR Reports', '#', 15, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('55', 'Workstation Reports', '#', 15, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('56', 'Shareholder Reports', '#', 15, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('57', 'TREC Authorized Representatives', '/ATMS/Reports/AuthRepReports.aspx', 17, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('58', 'TREC Shareholder', '/ATMS/Reports/ShareHolderReport.aspx', 17, 0);

--------------------------------------------- Parent Level 3  -----------------------------------------------------------

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('59', 'Setup Menu', '/Admin/Menu/MenuSetup.aspx', 18, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('60', 'Setup Role', '/Admin/Menu/RoleSetup.aspx', 19, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('61', 'Setup Role Type', '/Admin/Menu/RoleTypeSetup.aspx', 19, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('62', 'Setup EmpInfo', '/Admin/SetupEmpInfo.aspx', 20, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('63', 'Employee Search', '/SearchAndReport/frmSearchEmployee.aspx', 20, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('64', 'Setup User Profile by Admin', '/Admin/SetupUserProfileByAdmin.aspx', 21, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('65', 'Setup User Profile by TREC Admin', '/Admin/SetupUserProfile.aspx', 21, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('66', 'Setup User by Admin', '/Admin/SetupUserByAdmin.aspx', 21, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('67', 'Setup User by TREC Admin', '/Admin/SetupUser.aspx', 21, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('68', 'Reset Password', '/Admin/ResetPassword.aspx', 21, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('69', 'Reset Email', '/Admin/ResetEmail.aspx', 21, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('70', 'Setup Sys Params', '/Admin/SetupParamForSystem.aspx', 22, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('71', 'Setup User Params', '/Admin/SetupParamForUser.aspx', 22, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('72', 'Role Based', '/Admin/Menu/PermissionRoleBased.aspx', 23, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('73', 'User Based', '/Admin/Menu/PermissionUserBased.aspx', 23, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('74', 'Audit Summary Report', '/Admin/AuditInfo.aspx', 24, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('75', 'Audit Detail Report', '/Admin/AuditDetailInfo.aspx', 24, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('76', 'TREC Search Report', '/TMS/Reports/TrecSearchReport.aspx', 50, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('77', 'TREC Status Change Report', '/TMS/Reports/TrecStatusChangeReport.aspx', 50, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('78', 'TREC Code Change Report', '/TMS/Reports/TrecCodeChangeReport.aspx', 50, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('79', 'TREC Name Change Report', '/TMS/Reports/TrecNameChangeReport.aspx', 50, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('80', 'Broker Search Report', '/TMS/Reports/BrokerSearchReport.aspx', 51, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('81', 'Broker Renew Report', '/TMS/Reports/BrokerRenewReport.aspx', 51, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('82', 'Broker Status Change Report ', '/TMS/Reports/BrokerStatusChangeReport.aspx', 51, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('83', 'Dealer Search Report', '/TMS/Reports/DealerSearchReport.aspx', 52, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('84', 'Dealer Renew Report', '/TMS/Reports/DealerRenewReport.aspx', 52, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('85', 'Dealer Status Change Report ', '/TMS/Reports/DealerStatusChangeReport.aspx', 52, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('86', 'Office Search Report', '/TMS/Reports/OfficeSearchReport.aspx', 53, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('87', 'Office Shift Report', '/TMS/Reports/OfficeShiftReport.aspx', 53, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('88', 'Office Status Change Report ', '/TMS/Reports/OfficeStatusChangeReport.aspx', 53, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('89', 'Office Type Change Report ', '/TMS/Reports/OfficeTypeChangeReport.aspx', 53, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('90', 'AR Search Report', '/TMS/Reports/AuthRepReports.aspx', 54, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('91', 'AR Renew Report', '/TMS/Reports/AuthRepRenewReport.aspx', 54, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('92', 'AR Status Change Report ', '/TMS/Reports/AuthRepStatusChangeReport.aspx', 54, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('93', 'Workstation Search Report', '/TMS/Reports/WorkstationSearchReport.aspx', 55, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('94', 'Workstation Status Change Report', '/TMS/Reports/WorkstationStatusChangeReport.aspx', 55, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('95', 'Workstation AR Change Report', '/TMS/Reports/WorkstationArChangeReport.aspx', 55, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('96', 'Workstation Office Change Report', '/TMS/Reports/WorkstationOfficeChangeReport.aspx', 55, 0);

INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('97', 'Shareholder Report', '/TMS/Reports/ShareHolderSearchReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('98', 'Shareholding Status Report', '/TMS/Reports/ShareHoldingStatusReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('99', 'Report by designation', '/TMS/Reports/ShareHolderInfobyDesignationReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('100', 'Present List of Director', '/TMS/Reports/PresentDirectorReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('101', 'Present List of Shareholder', '/TMS/Reports/PresentShareHolderReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('102', 'Present List of Shareholder Or Director', '/TMS/Reports/ShareHolderOrDirectorReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('103', 'Present List of Chairman Or MD', '/TMS/Reports/ChairmanOrMDReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('104', 'Shareholder Or Director Search', '/TMS/Reports/ShareholderDirectorSearchReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('105', 'Parent Company Report', '/TMS/Reports/TrecParentCompanyList.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('106', 'Share Transfer Report', '/TMS/Reports/ShareTransferReport.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('107', 'Director or Shareholder Report By Date Range', '/TMS/Reports/DirectorAndShareholderReports.aspx', 56, 0);
INSERT INTO tblmenu (MENUID, MENUNAME, LINK, PARENTID, MENUORDER) VALUES ('108', 'Search Person By Name', '/TMS/Reports/SearchPersonByName.aspx', 56, 0);

commit;
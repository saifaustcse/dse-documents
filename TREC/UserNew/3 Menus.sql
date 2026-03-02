

select * from MENU;
--------------------------------------------- Parent Level 1 -----------------------------------------------------------

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (1, 'DSE Home', '~/HomeDse.aspx', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (2, 'TREC Home', '~/HomeTrec.aspx', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (3, 'BSEC Home', '~/HomeBsec.aspx', NULL, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (5, 'Help', '#', NULL, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (6, 'Admin', '#', NULL, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (7, 'TREC Management', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (8, 'Broker Management', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (9, 'Dealer Management', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (10, 'TREC Personnel', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (11, 'Office Management', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (12, 'AR Management', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (13, 'Workstations', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (14, 'Director and Shareholders', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (15, 'TMS Reports', '#', NULL, 0, 1);

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (16, 'Online Applications', '#', NULL, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (17, 'ATMS Reports', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (18, 'TREC Admin', '#', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (19, 'BSEC Admin', '#', NULL, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (20, 'Online Applications', '~/Modules/ATMS/AppTrecDashboard.aspx', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (21, 'Online Applications Approval', '~/Modules/ATMS/AppDseDashboard.aspx', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (22, 'Online Applications Phase -2', '#', NULL, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (23, 'About Us', '~/About.aspx', NULL, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (24, 'Contact', '~/Contact.aspx', NULL, 0, 1);

--------------------------------------------- Parent Level 2 -----------------------------------------------------------

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (25, 'Privileges', '#', 6, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (26, 'Users', '#', 6, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (27, 'Audit', '#', 6, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (28, 'TREC List', '~/Modules/TMS/Trec/TrecList.aspx', 7, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (29, 'TREC Capital', '~/Modules/TMS/TrecCapital/List.aspx', 7, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (30, 'TREC Parent Company', '~/Modules/TMS/TrecParentCompany/List.aspx', 7, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (31, 'TREC Auditor', '~/Modules/TMS/TrecAuditor/List.aspx', 7, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (32, 'Dual TREC', '~/Modules/TMS/DualTrec/List.aspx', 7, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (33, 'TREC Documents', '~/Modules/TMS/TrecDocument/DocumentList.aspx', 7, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (34, 'TREC Network', '~/Modules/TMS/TrecNetwork/List.aspx', 7, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (35, 'Broker License', '~/Modules/TMS/Broker/BrokerList.aspx', 8, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (36, 'Broker Expiry Reminder', '~/Modules/TMS/BrokerReminder/Reminders.aspx', 8, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (37, 'Dealer License', '~/Modules/TMS/Dealer/DealerList.aspx', 9, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (38, 'Dealer Expiry Reminder', '~/Modules/TMS/DealerReminder/Reminders.aspx', 9, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (39, 'Personnel List', '~/Modules/TMS/Personnel/PersonnelList.aspx', 10, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (40, 'Compliance Authorities', '~/Modules/TMS/TrecComplianceAuthority/List.aspx', 10, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (41, 'TREC Holder Representatives', '~/Modules/TMS/TrecHolderRepresentative/List.aspx', 10, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (42, 'Power Of Attorneys', '~/Modules/TMS/TrecPowerOfAttorney/List.aspx', 10, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (43, 'TREC CAMALCO', '~/Modules/TMS/TrecCamalco/List.aspx', 10, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (44, 'TREC Office', '~/Modules/TMS/Office/Offices.aspx', 11, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (45, 'TREC Office Network', '~/Modules/TMS/OfficeNetwork/OfficeList.aspx', 11, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (46, 'Authorized Representatives', '~/Modules/TMS/AuthRep/AuthRepList.aspx', 12, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (47, 'AR Expiry Reminder', '~/Modules/TMS/AuthRepReminder/Reminders.aspx', 12, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (48, 'Workstation List', '~/Modules/TMS/Workstation/Workstations.aspx', 13, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (49, 'Information Entry', '~/Modules/TMS/ShareHolder/ShareHolderList.aspx', 14, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (50, 'Director Information', '~/Modules/TMS/ShareHolder/DirectorList.aspx', 14, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (51, 'Shareholder Information', '~/Modules/TMS/ShareHolder/ShareEntryList.aspx', 14, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (52, 'Share Transfer Information', '~/Modules/TMS/ShareHolder/ShareTransferList.aspx', 14, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (53, 'TREC Reports', '#', 15, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (54, 'Broker Reports', '#', 15, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (55, 'Dealer Reports', '#', 15, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (56, 'Office Reports', '#', 15, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (57, 'AR Reports', '#', 15, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (58, 'Workstation Reports', '#', 15, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (59, 'Shareholder Reports', '#', 15, 0, 1);

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (60, 'TWS Allocation', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (61, 'TWS Relocation', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (62, 'TWS Suspension', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (63, 'TWS Resumption', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (64, 'AR Appointment', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (65, 'AR Withdrawal', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (66, 'AR Replacement from TWS', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (67, 'Branch Manager Update', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (68, 'Branch Compliance Officer Update', '#', 16, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (69, 'App Types', '~/Modules/ATMS/AppType/List.aspx', 22, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (70, 'App Required Documents', '~/Modules/ATMS/AppRequiredDoc/List.aspx', 22, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (71, 'Broker', '#', 22, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (72, 'Dealer', '#', 22, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (73, 'AR', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (73, 'AR', '#', 16, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (73, 'AR', '#', 16, 0, 1);


INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (76, 'TREC Report', '~/Modules/ATMS/Reports/TrecReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (77, 'TREC Broker Report', '~/Modules/ATMS/Reports/BrokerReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (78, 'TREC Dealer Report', '~/Modules/ATMS/Reports/DealerReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (79, 'TREC Office Report', '~/Modules/ATMS/Reports/OfficeReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (80, 'TREC AR Report', '~/Modules/ATMS/Reports/AuthRepReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (81, 'TREC Personnel Report', '~/Modules/ATMS/Reports/TrecPersonnel.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (82, 'TREC Workstation Report', '~/Modules/ATMS/Reports/WorkstationReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (83, 'TREC Director Report', '~/Modules/ATMS/Reports/DirectorReport.aspx', 17, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (84, 'TREC Shareholder Report', '~/Modules/ATMS/Reports/ShareHolderReport.aspx', 17, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (85, 'Users', '~/Modules/User/UserProfileTrec/List.aspx', 18, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (86, 'Users Roles', '~/Modules/User/UserRolesTrec/List.aspx', 18, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (87, 'Users', '~/Modules/User/UserProfileBsec/List.aspx', 19, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (88, 'Users Roles', '~/Modules/User/UserRolesBsec/List.aspx', 19, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (89, 'Users', '~/Modules/User/UserInfo/List.aspx', 18, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (90, 'Users', '~/Modules/User/UserInfo/List.aspx', 18, 0, 1);

--------------------------------------------- Parent Level 3  -----------------------------------------------------------

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (91, 'Role', '~/Modules/Admin/Role/List.aspx', 25, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (92, 'Menu', '~/Modules/Admin/Menu/List.aspx', 25, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (93, 'Role Menus', '~/Modules/Admin/RoleMenu/List.aspx', 25, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (94, 'Setup Sys Params', '~/Modules/Admin/SysParam/List.aspx', 25, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (95, 'User Profile', '~/Modules/User/UserProfile/List.aspx', 26, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (96, 'User Info', '~/Modules/User/UserInfo/List.aspx', 26, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (97, 'User Roles', '~/Modules/User/UserRoles/List.aspx', 26, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (98, 'Change User Info', '~/Modules/User/UserInfoChange/List.aspx', 26,0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (99, 'Login History', '~/Modules/Audit/LoginHistory.aspx', 27, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (100, 'User Activity', '~/Modules/Audit/UserActivity.aspx', 27, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (101, 'TREC Search Report', '~/Modules/TMS/Reports/TrecSearchReport.aspx', 53, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (102, 'TREC Status Change Report', '~/Modules/TMS/Reports/TrecStatusChangeReport.aspx', 53, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (103, 'TREC Code Change Report', '~/Modules/TMS/Reports/TrecCodeChangeReport.aspx', 53, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (104, 'TREC Name Change Report', '~/Modules/TMS/Reports/TrecNameChangeReport.aspx', 53, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (105, 'Broker Search Report', '~/Modules/TMS/Reports/BrokerSearchReport.aspx', 54, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (106, 'Broker Renew Report', '~/Modules/TMS/Reports/BrokerRenewReport.aspx', 54, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (107, 'Broker Status Change Report ', '~/Modules/TMS/Reports/BrokerStatusChangeReport.aspx', 54, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (108, 'Dealer Search Report', '~/Modules/TMS/Reports/DealerSearchReport.aspx', 55, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (109, 'Dealer Renew Report', '~/Modules/TMS/Reports/DealerRenewReport.aspx', 55, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (110, 'Dealer Status Change Report ', '~/Modules/TMS/Reports/DealerStatusChangeReport.aspx', 55, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (111, 'Office Search Report', '~/Modules/TMS/Reports/OfficeSearchReport.aspx', 56, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (112, 'Office Shift Report', '~/Modules/TMS/Reports/OfficeShiftReport.aspx', 56, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (113, 'Office Status Change Report ', '~/Modules/TMS/Reports/OfficeStatusChangeReport.aspx', 56, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (114, 'Office Type Change Report ', '~/Modules/TMS/Reports/OfficeTypeChangeReport.aspx', 56, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (115, 'AR Search Report', '~/Modules/TMS/Reports/AuthRepReports.aspx', 57, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (116, 'AR Renew Report', '~/Modules/TMS/Reports/AuthRepRenewReport.aspx', 57, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (117, 'AR Status Change Report ', '~/Modules/TMS/Reports/AuthRepStatusChangeReport.aspx', 57, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (118, 'Workstation Search Report', '~/Modules/TMS/Reports/WorkstationSearchReport.aspx', 58, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (119, 'Workstation Status Change Report', '~/Modules/TMS/Reports/WorkstationStatusChangeReport.aspx', 58, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (120, 'Workstation AR Change Report', '~/Modules/TMS/Reports/WorkstationArChangeReport.aspx', 58, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (121, 'Workstation Office Change Report', '~/Modules/TMS/Reports/WorkstationOfficeChangeReport.aspx', 58, 0, 1);

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (122, 'Share Holder Report', '~/Modules/TMS/Reports/ShareHolderSearchReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (123, 'Share Holder Status Report', '~/Modules/TMS/Reports/ShareHoldingStatusReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (124, 'Shareholders by Designation', '~/Modules/TMS/Reports/ShareHolderInfobyDesignationReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (125, 'Present List of Director', '~/Modules/TMS/Reports/PresentDirectorReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (126, 'Present List of Shareholder', '~/Modules/TMS/Reports/PresentShareHolderReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (127, 'Present List of Shareholder Or Director', '~/Modules/TMS/Reports/ShareHolderOrDirectorReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (128, 'Present List of Chairman Or MD', '~/Modules/TMS/Reports/ChairmanOrMDReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (129, 'Shareholder Or Director Search', '~/Modules/TMS/Reports/ShareholderDirectorSearchReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (130, 'Parent Company Report', '~/Modules/TMS/Reports/TrecParentCompanyList.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (131, 'Share Transfer Report', '~/Modules/TMS/Reports/ShareTransferReport.aspx', 59, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (132, 'Director or Shareholder Report By Date Range', '~/Modules/TMS/Reports/DirectorAndShareholderReports.aspx', 59, 0, 1);
--INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (132, 'Search Person By Name', '~/Modules/TMS/Reports/SearchPersonByName.aspx', 59, 0, 1);
--INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (132, 'Search Person By Name', '~/Modules/TMS/Reports/SearchPersonByName.aspx', 59, 0, 1);
--INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (132, 'Search Person By Name', '~/Modules/TMS/Reports/SearchPersonByName.aspx', 59, 0, 1);
--INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (132, 'Search Person By Name', '~/Modules/TMS/Reports/SearchPersonByName.aspx', 59, 0, 1);

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (137, 'Applications', '~/Modules/ATMS/WorkstationAllocation/Applications.aspx', 60, 0, 1);
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (138, 'Approve', '~/Modules/ATMS/WorkstationAllocation/Approval.aspx', 60, 0, 1); -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (139, 'Applications', '~/Modules/ATMS/WorkstationRelocation/Applications.aspx', 61, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (140, 'Approve', '~/Modules/ATMS/WorkstationRelocation/Approval.aspx', 61, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (141, 'Applications', '~/Modules/ATMS/WorkstationSuspension/Applications.aspx', 62, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (142, 'Approve', '~/Modules/ATMS/WorkstationSuspension/Approval.aspx', 62, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (143, 'Applications', '~/Modules/ATMS/WorkstationResumption/Applications.aspx', 63, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (144, 'Approve', '~/Modules/ATMS/WorkstationResumption/Approval.aspx', 63, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (145, 'Applications', '~/Modules/ATMS/AuthRepAppointment/Applications.aspx', 64, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (146, 'Approve', '~/Modules/ATMS/AuthRepAppointment/Approval.aspx', 64, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (147, 'Applications', '~/Modules/ATMS/AuthRepWithdrawal/Applications.aspx', 65, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (148, 'Approve', '~/Modules/ATMS/AuthRepWithdrawal/Approval.aspx', 65, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (149, 'Applications', '~/Modules/ATMS/AuthRepReplacement/Applications.aspx', 66, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (150, 'Approve', '~/Modules/ATMS/AuthRepReplacement/Approval.aspx', 66, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (151, 'Applications', '~/Modules/ATMS/OfficeIncharge/Applications.aspx', 67, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (152, 'Approve', '~/Modules/ATMS/OfficeIncharge/Approval.aspx', 67, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (153, 'Applications', '~/Modules/ATMS/OfficeComplianceOfficer/Applications.aspx', 68, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (154, 'Approve', '~/Modules/ATMS/OfficeComplianceOfficer/Approval.aspx', 68, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (154, 'Applications', '~/Modules/ATMS/OfficeComplianceOfficer/Applications.aspx', 69, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (154, 'Approve', '~/Modules/ATMS/OfficeComplianceOfficer/Approval.aspx', 69, 0, 1);  -- for dse

-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (154, 'Applications', '~/Modules/ATMS/OfficeComplianceOfficer/Applications.aspx', 69, 0, 1);  -- for dse
-- INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (154, 'Approve', '~/Modules/ATMS/OfficeComplianceOfficer/Approval.aspx', 69, 0, 1);  -- for dse

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (159, 'Registration or Renewal', '~/Modules/ATMS/Broker/List.aspx', 71, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (160, 'Status', '~/Modules/ATMS/Broker/Status.aspx', 71, 0, 1); 
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (161, 'Verify', '~/Modules/ATMS/Broker/Verify.aspx', 71, 0, 1);    -- for dse
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (162, 'Approve', '~/Modules/ATMS/Broker/Approval.aspx', 71, 0, 1); -- for dse
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (163, 'Reports', '~/Modules/ATMS/Broker/Reports.aspx', 71, 0, 1); -- for dse

INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (164, 'Registration or Renewal', '~/Modules/ATMS/Dealer/List.aspx', 72, 0, 1);
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (165, 'Status', '~/Modules/ATMS/Dealer/Status.aspx', 72, 0, 1); 
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (166, 'Verify', '~/Modules/ATMS/Dealer/Verify.aspx', 72, 0, 1);    -- for dse
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (167, 'Approve', '~/Modules/ATMS/Dealer/Approval.aspx', 72, 0, 1); -- for dse
INSERT INTO MENU (MENU_ID, MENU_NAME, MENU_LINK, PARENT_ID, MENU_ORDER, ADDED_BY) VALUES (168, 'Reports', '~/Modules/ATMS/Dealer/Reports.aspx', 72, 0, 1); -- for dse

commit
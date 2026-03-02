
delete from WORKFLOW_CURRENT;
delete from WORKFLOW_HISTORIES;
delete from WORKFLOW_APPS_LIST;

----------------------------------


drop table WORKFLOW_CURRENT;
drop table WORKFLOW_HISTORIES;
drop table WORKFLOW_APPS_LIST;
drop table WORKFLOW_EDGE;
drop table WORKFLOW_NODE;
drop table WORKFLOW_TEAM_MEMBERS;
drop table WORKFLOW_TEAM;
drop table WORKFLOW_TEAM_ROLES;
drop table WORKFLOWS;


-- Final Tables Start Here --
CREATE TABLE WORKFLOWS(
    ID number(10) NOT NULL,
    TITLE varchar2(50) NOT NULL,
    DESCRIPTION varchar2(50) NOT NULL,
    TYPE varchar(50),
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOWS primary key (ID),
    constraint UNIQ_WORKFLOWS_TITLE UNIQUE (TITLE),
    constraint FK_WORKFLOWS_CREATED_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOWS_UPDATED_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);
CREATE TABLE WORKFLOW_TEAM_ROLES(
    ID number(10) NOT NULL,
    TITLE varchar2(50) NOT NULL,
    DESCRIPTION varchar2(50),
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_TEAM_ROLES primary key (ID),
    constraint UNIQ_WORKFLOW_TEAM_ROLES_TITLE UNIQUE (TITLE),
    constraint FK_WORKFLOW_TEAM_ROLES_CRTDBY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_TEAM_ROLES_UPDTDBY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)

);
CREATE TABLE WORKFLOW_TEAM(
    ID number(10) NOT NULL,
    NAME varchar2(50) NOT NULL,
    DESCRIPTION varchar2(50) NOT NULL,
    ROLE_ID number(10),
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_TEAM primary key (ID),
    constraint UNIQ_WORKFLOW_TEAM_NAME UNIQUE (NAME),
    constraint FK_WORKFLOW_TEAM_ROLE_ID foreign key (ROLE_ID) references WORKFLOW_TEAM_ROLES(ID),
    constraint FK_WORKFLOW_TEAM_CREATED_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_TEAM_UPDATED_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);
CREATE TABLE WORKFLOW_TEAM_MEMBERS (
    ID number(10) NOT NULL,
    TEAM_ID number(10) NOT NULL,
    USER_ID varchar2(200) NOT NULL,
    USER_NAME varchar2(200),
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_TEAM_MEMBERS primary key (ID),
    constraint FK_WORKFLOW_TEAM_MEMBERS_TMID foreign key (TEAM_ID) references WORKFLOW_TEAM(ID)  on  delete cascade,
    constraint FK_WORKFLOW_TEAM_MEMBERS_USRID foreign key (USER_ID) references DSESMS.TBLUSERINFO(USER_ID) on delete cascade
);
--Got rid of WF_ID i.e. id local to workflow, will use ID as GUID across all workflow graphs
--Workflow now represented by id
--Team Name also now accessed via ID
--Team Role removed completely as it is now accessed by joining WORKFLOW_NODES with
--WORKFLOW_TEAM with WORKFLOW_ROLES on WORKFLOW_NODES.TEAM_ID == WORKFLOW_TEAM.ID on
--WORKFLOW_TEAM.ROLE_ID == WORKFLOW_ROLES.ID
CREATE TABLE WORKFLOW_NODE (
    ID number(10) NOT NULL,
    WORKFLOW_ID number(10) NOT NULL,
    TEAM_ID number(10) NOT NULL,
    X number(32) NOT NULL,
    Y number(32) NOT NULL,
    IS_START number(1) NOT NULL,
    IS_END number(1) NOT NULL,
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_NODE primary key (ID),
    constraint FK_WORKFLOW_NODE_WORKFLOW_ID foreign key (WORKFLOW_ID) references WORKFLOWS(ID) on delete cascade,
    constraint FK_WORKFLOW_NODE_TEAM_ID foreign key (TEAM_ID) references WORKFLOW_TEAM(ID),
    constraint FK_WORKFLOW_NODE_CREATED_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_NODE_UPDATED_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)

);
--how to get user active apps with this new setup? first, search for all the team members of this workflow.
--then search this list again according to places where this user is. the set of returneed team ids is
--the number of gridviews we have to load
CREATE TABLE WORKFLOW_EDGE (
    ID number(10) NOT NULL,
    WORKFLOW_ID number(10) NOT NULL,
    SOURCE number(10) NOT NULL,
    TARGET number(10) NOT NULL,
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_EDGE primary key (ID),
    constraint FK_WORKFLOW_EDGE_WORKFLOW_ID foreign key (WORKFLOW_ID) references WORKFLOWS(ID) on delete cascade,
    constraint FK_WORKFLOW_EDGE_SOURCE foreign key (SOURCE) references WORKFLOW_NODE(ID) on delete cascade,
    constraint FK_WORKFLOW_EDGE_TARGET foreign key (TARGET) references WORKFLOW_NODE(ID) on delete cascade,
    constraint FK_WORKFLOW_EDGE_CREATED_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_EDGE_UPDATED_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);
CREATE TABLE WORKFLOW_APPS_LIST (
    ID number(10),
    ATMS_APP_ID number(10) NOT NULL,
    TREC_ID number(5) NOT NULL,
    WORKFLOW_ID number(10) NOT NULL,
    CUR_STATUS varchar2(50) NOT NULL,
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_APPS_LIST primary key (ID),
    constraint FK_WORKFLOW_APPS_LIST_TREC_ID foreign key (TREC_ID) references TREC(TREC_ID) on delete cascade,
    constraint FK_WORKFLOW_APPS_LIST_WKFLW_ID foreign key (WORKFLOW_ID) references WORKFLOWS(ID) on delete cascade,
    constraint FK_WORKFLOW_APPS_LIST_CRTD_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_APPS_LIST_UPDTD_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)

);

CREATE TABLE WORKFLOW_HISTORIES (
    ID number(10),
    APP_ID number(10) NOT NULL,
    SENT_TO number(10) NOT NULL,
    SENT_BY number(10) NOT NULL,
    MSG_TYPE varchar2(50) NOT NULL,
    MSG_DATA varchar2(3500),
    COMMENTS varchar2(1000),
    VALIDITY varchar2(50) NOT NULL,
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_HISTORIES primary key (ID),
    constraint FK_WORKFLOW_HISTORIES_APP_ID foreign key (APP_ID) references WORKFLOW_APPS_LIST(ID) on delete cascade,
    constraint FK_WORKFLOW_HISTORIES_SENT_TO foreign key (SENT_TO) references WORKFLOW_TEAM(ID),
    constraint FK_WORKFLOW_HISTORIES_SENT_BY foreign key (SENT_BY) references WORKFLOW_TEAM(ID),
    constraint FK_WORKFLOW_HISTORIES_CRTD_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_HISTORIES_UPDTD_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);

CREATE TABLE WORKFLOW_CURRENT (
    ID number(10),
    APP_ID number(10) NOT NULL,
    SENT_TO number(10) NOT NULL,
    SENT_BY number(10) NOT NULL,
    MSG_TYPE varchar2(50) NOT NULL,
    MSG_DATA varchar2(3500),
    COMMENTS varchar2(1000),
    VALIDITY varchar2(50) NOT NULL,
    PROCESSING_BY varchar2(200),
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_CURRENT primary key (ID),
    constraint FK_WORKFLOW_CURRENT_APP_ID foreign key (APP_ID) references WORKFLOW_APPS_LIST(ID) on delete cascade,
    constraint FK_WORKFLOW_CURRENT_SENT_TO foreign key (SENT_TO) references WORKFLOW_TEAM(ID),
    constraint FK_WORKFLOW_CURRENT_SENT_BY foreign key (SENT_BY) references WORKFLOW_TEAM(ID),
    constraint FK_WORKFLOW_CURRENT_CRTD_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_CURRENT_UPDTD_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_CURRENT_PRCSNG_BY foreign key (PROCESSING_BY) references DSESMS.TBLUSERINFO(USER_ID)
);


CREATE TABLE WORKFLOW_VERSION(
    ID number(10) NOT NULL,
    WORKFLOW_ID number(10) NOT NULL,
    VERSION number(10) NOT NULL,
    TYPE varchar(50),
    START_TIME timestamp,
    CREATE_TIME timestamp,
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    LAST_UPDATED timestamp,
    IS_ACTIVE number(1) NOT NULL,
    IS_DELETED number(1) NOT NULL,
    constraint PK_WORKFLOW_VERSION primary key (ID),
    constraint FK_WORKFLOW_VERSION_WF_ID foreign key (WORKFLOW_ID) references WORKFLOWS(ID) on delete cascade,
    constraint FK_WORKFLOW_VERSION_CREATED_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
    constraint FK_WORKFLOW_VERSION_UPDATED_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);


ALTER TABLE WORKFLOW_NODE ADD VERSION number(10);
ALTER TABLE WORKFLOW_EDGE ADD VERSION number(10);
ALTER TABLE WORKFLOW_APPS_LIST ADD VERSION number(10);

------------------- OLD TABLES ------------------------
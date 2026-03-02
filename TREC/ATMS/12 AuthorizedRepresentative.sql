
-----------------------------------------------
delete from AUTH_REP_EMP_END_APP;
delete from AUTH_REP_RNW_LCNS_APP;

delete from AUTH_REP_WORKSTATION_HIST;
delete from AUTH_REP_RMV_WS_APP;
delete from AUTH_REP_ADD_WS_APP;
drop table AUTH_REP_WORKSTATION;

delete from AUTH_REP;
delete from AUTH_REP_APP;
------------------------------------------------------
 AUTH_REP_APP
------------------------------------------------------

 CREATE TABLE AUTH_REP_APP(
    AUTH_REP_APP_ID number(10) NOT NULL,
    TREC_ID NUMBER(5,0) NOT NULL,
    PERSONNEL_INFO_ID NUMBER(10,0) NOT NULL,
    INTERVIEW_DATE DATE,
    APPOINTMENT_ISSUANCE_DATE DATE,
    DEED_RECEIVING_DATE DATE,
    APPLICATION_DATE_TO_BSEC DATE,
    BSEC_REG_ISSUEANCE_DATE DATE,
    LETTER_ISSUEANCE_DATE DATE,
    BSEC_REG_CERT_SEND_DATE DATE,
    BSEC_REG_NO VARCHAR2(40 CHAR),
    EFFECTIVE_DATE DATE,
    EXPIRY_DATE DATE,
    APPLICATION_DATE_TO_DSE DATE,
    FEE FLOAT(126),
    FEE_FILE VARCHAR2(255 CHAR),
    REMARKS VARCHAR2(255),
    STATUS VARCHAR2(40),
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE,
    UPDATED_DATE DATE,
    SUBMISSION_DATE DATE,
	
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
   
    constraint PK_AUTHREP_APP primary key (AUTH_REP_APP_ID),
    constraint FK_AUTHREP_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
    constraint FK_AUTHREP_APP_PERSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)
);


------------------------------------------------------
 AUTH_REP_WORKSTATION_ADD_APP
------------------------------------------------------

CREATE TABLE AUTH_REP_WORKSTATION_ADD_APP(
    AUTH_REP_WS_ADD_APP_ID number(10) NOT NULL,
    AUTH_REP_ID number(10) NOT NULL,
    WS_ID number(5) NOT NULL,
    FIRST_DAY_USING_WS DATE NOT NULL,
    REMARKS VARCHAR2(255),
    STATUS VARCHAR2(40),
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE,
    UPDATED_DATE DATE,
    SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_AUTH_REP_ADD_WS_APP primary key (AUTH_REP_WS_ADD_APP_ID),
    constraint FK_AUTH_REP_ADD_WS_APP_AR_ID foreign key (AUTH_REP_ID) references AUTH_REP(AUTH_REP_ID),
    constraint FK_AUTH_REP_ADD_WS_APP_WS_ID foreign key (WS_ID) references WORKSTATION(WORKSTATION_ID)
);


------------------------------------------------------
 AUTH_REP_WORKSTATION_RMV_APP
------------------------------------------------------

CREATE TABLE AUTH_REP_WORKSTATION_RMV_APP(
    AUTH_REP_WS_RMV_APP_ID number(10) NOT NULL,
    AUTH_REP_ID number(10) NOT NULL,
    AUTH_REP_WORKSTATION_ID number(10) NOT NULL,
    LAST_DAY_USING_WS DATE NOT NULL,
    REMARKS VARCHAR2(255),
    STATUS VARCHAR2(40),
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE,
    UPDATED_DATE DATE,
    SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_AUTH_REP_RMV_WS_APP primary key (AUTH_REP_WS_RMV_APP_ID),
    constraint FK_AUTH_REP_RMV_WS_APP_AR_ID foreign key (AUTH_REP_ID) references AUTH_REP(AUTH_REP_ID),
    constraint FK_AUTH_REP_RMV_WS_APP_WS_ID foreign key (AUTH_REP_WORKSTATION_ID) references AUTH_REP_WORKSTATION(AUTH_REP_WORKSTATION_ID)
);

------------------------------------------------------
 AUTH_REP_STATUS_CHA_APP
------------------------------------------------------

CREATE TABLE AUTH_REP_STATUS_CHA_APP(
    AUTH_REP_STATUS_CHA_APP_ID number(10) NOT NULL,
    AUTH_REP_ID number(10) NOT NULL,
    NEW_STATUS VARCHAR2(40),
    EFFECTIVE_DATE DATE,
    REMARKS VARCHAR2(255),
    STATUS VARCHAR2(40),
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE,
    UPDATED_DATE DATE,
    SUBMISSION_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_AUTH_REP_STATUS_CHA_APP primary key (AUTH_REP_STATUS_CHA_APP_ID),
    constraint FK_AUTH_REP_STATUS_CHA_APP_AR foreign key (AUTH_REP_ID) references AUTH_REP(AUTH_REP_ID)

);

------------------------------------------------------
 AUTH_REP_RNW_LCNS_APP
------------------------------------------------------

CREATE TABLE AUTH_REP_RNW_LCNS_APP(
    AUTH_REP_RNW_LCNS_APP_ID number(10) NOT NULL,
    AUTH_REP_ID number(10) NOT NULL,

    REMARKS VARCHAR2(255),
    STATUS VARCHAR2(40),
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE,
    UPDATED_DATE DATE,
    SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_AUTH_REP_RNW_LCNS_APP primary key (AUTH_REP_RNW_LCNS_APP_ID),
    constraint FK_AUTH_REP_RNW_LCNS_APP_AR_ID foreign key (AUTH_REP_ID) references AUTH_REP(AUTH_REP_ID)

);


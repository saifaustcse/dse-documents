

deleted from trec edmx with references
------------------------------------------------------

SELECT * FROM APP_NAME_CHANGE;

drop table APP_NAME_CHANGE cascade constraints;

------------------------------------------------------

desc TREC_NAME_CHANGE_APP;
desc TREC_NAME_CHANGE_FLOW;
desc TREC_NAME_CHANGE_HIST;



--drop table TREC_NAME_CHANGE_APP;
--drop table TREC_NAME_CHANGE_FLOW;
--drop table TREC_NAME_CHANGE_HIST;


------------------------------------------------------
 TREC_NAME_CHANGE_APP
------------------------------------------------------

CREATE TABLE TREC_NAME_CHANGE_APP(
    TREC_NAME_CHANGE_APP_ID number(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	NEW_NAME VARCHAR2(40) NOT NULL,
	REMARKS VARCHAR2(255),
	STATUS VARCHAR2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE NOT NULL,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
  
  constraint PK_TREC_NAME_CHANGE_APP primary key (TREC_NAME_CHANGE_APP_ID),
  constraint FK_TREC_NAME_CHANGE_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE
  --constraint FK_TREC_NAME_CHANGE_APP_CR_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
  --constraint FK_TREC_NAME_CHANGE_APP_UP_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
  --constraint FK_TREC_NAME_CHANGE_APP_ST_BY foreign key (SENT_BY) references DSESMS.TBLUSERINFO(USER_ID)

);


------------------------------------------------------
 TREC
------------------------------------------------------


	  
------------------------------------------------------
 TREC_NAME_CHANGE_FLOW
------------------------------------------------------

CREATE TABLE TREC_NAME_CHANGE_FLOW(
    TREC_NAME_CHANGE_FLOW_ID number(10) NOT NULL,
	TREC_NAME_CHANGE_APP_ID number(10) NOT NULL,
    TREC_ID NUMBER(5,0) NOT NULL,
    USER_ID varchar2(200) NOT NULL,
    JOB_DOMAIN VARCHAR2(40),
    ACTION_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,

    constraint PK_TREC_NAME_CHANGE_FLOW primary key (TREC_NAME_CHANGE_FLOW_ID),
	constraint FK_TREC_NAME_CHANGE_FLOW_APP foreign key (TREC_NAME_CHANGE_APP_ID) references TREC_NAME_CHANGE_APP(TREC_NAME_CHANGE_APP_ID) ON DELETE CASCADE ENABLE,
    constraint FK_TREC_NAME_CHANGE_FLOW_TREC foreign key (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE
    --constraint FK_TREC_NAME_CHANGE_FLOW_USER foreign key (USER_ID) references DSESMS.TBLUSERINFO (USER_ID) ENABLE
);

------------------------------------------------------
 TREC_NAME_CHANGE_HIST
------------------------------------------------------

CREATE TABLE TREC_NAME_CHANGE_HIST(
    TREC_NAME_CHANGE_HIST_ID number(10) NOT NULL,
    TREC_NAME_CHANGE_APP_ID number(10) NOT NULL,
    TREC_ID NUMBER(5,0) NOT NULL,
    OLD_NAME VARCHAR2(40 CHAR) NOT NULL,
    APPROVED_BY varchar2(200),
    APPROVED_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    
    constraint PK_TREC_NAME_CHANGE_HIST primary key (TREC_NAME_CHANGE_HIST_ID),
    constraint FK_TREC_NAME_CHNG_HST_CHNG_APP foreign key (TREC_NAME_CHANGE_APP_ID) references TREC_NAME_CHANGE_APP(TREC_NAME_CHANGE_APP_ID) ON DELETE CASCADE ENABLE,
    constraint FK_TREC_NAME_CHANGE_HIST_TREC foreign KEY (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE
    --constraint FK_TREC_NAME_CHANGE_HIST_AP_BY foreign key (APPROVED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);
 
------------------------------------------------------
 TREC_RENAME // This table is used for admin
------------------------------------------------------

CREATE TABLE TREC_RENAME(
    TREC_RENAME_ID number(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	NEW_NAME VARCHAR2(40) NOT NULL,
	REMARKS VARCHAR2(255),
	STATUS VARCHAR2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE NOT NULL,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
  
  constraint PK_TREC_RENAME_ID_APP primary key (TREC_RENAME_ID),
  constraint FK_TREC_RENAME_ID_TREC foreign key (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE

);



CREATE TABLE TREC_AUDITOR(
    AUDITOR_ID NUMBER(5,0) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	NAME VARCHAR2(255 CHAR), 
	DETAILS VARCHAR2(255 CHAR), 
	FROM_DATE DATE, 
	TODATE_DATE DATE, 
	REMARKS VARCHAR2(255 CHAR), 
	STATUS VARCHAR2(40),
	CREATED_BY varchar2(200) NOT NULL,
	UPDATED_BY varchar2(200) ,
	CREATED_DATE DATE NOT NULL,
	UPDATED_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    constraint PK_TREC_AUDITOR primary key (AUDITOR_ID),
    constraint FK_TREC_AUDITOR_TREC foreign key (TREC_ID) references TREC(TREC_ID)
);



deleted from trec edmx with references
------------------------------------------------------

select * from APP_CODE_CHANGE;
select * from FLOW_CODE_CHANGE;
select * from HIST_CODE_CHANGE;
select * from ATMS_APP_TREC_CODE;

drop table APP_CODE_CHANGE cascade constraints;
drop table FLOW_CODE_CHANGE cascade constraints;
drop table HIST_CODE_CHANGE cascade constraints;
drop table ATMS_APP_TREC_CODE cascade constraints;

------------------------------------------------------

desc TREC_CODE_CHANGE_APP;
desc TREC_CODE_CHANGE_FLOW;
desc TREC_CODE_CHANGE_HIST;

--drop table TREC_CODE_CHANGE_APP;
--drop table TREC_CODE_CHANGE_FLOW;
--drop table TREC_CODE_CHANGE_HIST;


------------------------------------------------------
 TREC_CODE_CHANGE_APP
------------------------------------------------------


CREATE TABLE TREC_CODE_CHANGE_APP(
    TREC_CODE_CHANGE_APP_ID number(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	NEW_CODE VARCHAR2(40) NOT NULL,
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
  
  constraint PK_TREC_CODE_CHANGE_APP primary key (TREC_CODE_CHANGE_APP_ID),
  constraint FK_TREC_CODE_CHANGE_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE
  
  --constraint FK_TREC_CODE_CHANGE_APP_CR_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
  --constraint FK_TREC_CODE_CHANGE_APP_UP_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
  --constraint FK_TREC_CODE_CHANGE_APP_ST_BY foreign key (SENT_BY) references DSESMS.TBLUSERINFO(USER_ID)

);
  
------------------------------------------------------
 TREC_CODE_CHANGE_FLOW
------------------------------------------------------


CREATE TABLE TREC_CODE_CHANGE_FLOW(
    TREC_CODE_CHANGE_FLOW_ID number(10) NOT NULL,
	TREC_CODE_CHANGE_APP_ID number(10) NOT NULL,
    TREC_ID NUMBER(5,0) NOT NULL,
    USER_ID varchar2(200) NOT NULL,
    JOB_DOMAIN VARCHAR2(40) NOT NULL,
    ACTION_DATE DATE NOT NULL,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,

    constraint PK_TREC_CODE_CHANGE_FLOW primary key (TREC_CODE_CHANGE_FLOW_ID),
	constraint FK_TREC_CODE_CHANGE_FLOW_APP foreign key (TREC_CODE_CHANGE_APP_ID) references TREC_CODE_CHANGE_APP(TREC_CODE_CHANGE_APP_ID) ON DELETE CASCADE ENABLE,
    constraint FK_TREC_CODE_CHANGE_FLOW_TREC foreign key (TREC_ID) references TREC (TREC_ID) ON DELETE CASCADE ENABLE
    --constraint FK_TREC_CODE_CHANGE_FLOW_USER foreign key (USER_ID) references DSESMS.TBLUSERINFO (USER_ID) ENABLE
);



------------------------------------------------------
 TREC_CODE_CHANGE_HIST
------------------------------------------------------

CREATE TABLE TREC_CODE_CHANGE_HIST(
    TREC_CODE_CHANGE_HIST_ID number(10) NOT NULL,
    TREC_CODE_CHANGE_APP_ID number(10) NOT NULL,
    TREC_ID NUMBER(5,0) NOT NULL,
    OLD_CODE VARCHAR2(40 CHAR) NOT NULL,
    APPROVED_BY varchar2(200),
    APPROVED_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    
    constraint PK_TREC_CODE_CHANGE_HIST primary key (TREC_CODE_CHANGE_HIST_ID),
    constraint FK_TREC_CODE_CHNG_HST_CHNG_APP foreign key (TREC_CODE_CHANGE_APP_ID) references TREC_CODE_CHANGE_APP(TREC_CODE_CHANGE_APP_ID) ON DELETE CASCADE ENABLE,
    constraint FK_TREC_CODE_CHANGE_HIST_TREC foreign KEY (TREC_ID) references TREC (TREC_ID) ON DELETE CASCADE ENABLE
    --constraint FK_TREC_CODE_CHANGE_HIST_AP_BY foreign key (APPROVED_BY) references DSESMS.TBLUSERINFO(USER_ID)
);

 

------------------------------------------------------
 TREC_RECODE // This table is used for admin
------------------------------------------------------

CREATE TABLE TREC_RECODE(
    TREC_RECODE_ID number(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	NEW_CODE VARCHAR2(40) NOT NULL,
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
  
  constraint PK_TREC_RECODE primary key (TREC_RECODE_ID),
  constraint FK_TREC_RECODE_TREC foreign key (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE
 
);



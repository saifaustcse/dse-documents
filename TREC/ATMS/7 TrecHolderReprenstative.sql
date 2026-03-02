

deleted from trec edmx with references
------------------------------------------------------

APP_TREC_HLDR_REPRESENT  -- will be deleted from database
TREC_REPRESENTATIVE -- will be deleted from database
TREC_REPRESENTATIVE_ACTION -- will be deleted from database

drop table APP_TREC_HLDR_REPRESENT cascade constraints;
drop table TREC_REPRESENTATIVE cascade constraints;
drop table TREC_REPRESENTATIVE_ACTION cascade constraints;
------------------------------------------------------

DELETE from TREC_HLDR_REPRESENT_APP;
DELETE from TREC_HLDR_REPRESENT;
DELETE from TREC_HLDR_REPRESENT_CHA_APP;


------------------------------------------------------
 TREC_HLDR_REPRESENT_APP
------------------------------------------------------

CREATE TABLE TREC_HLDR_REPRESENT_APP(
    TREC_HLDR_REPRESENT_APP_ID NUMBER(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	PERSONNEL_INFO_ID NUMBER(10,0) NOT NULL,
	EFFECTIVE_FROM_DATE DATE ,
    FEE FLOAT(126),
	FEE_FILE VARCHAR2(255 CHAR),
	REMARKS VARCHAR2(255),
	STATUS VARCHAR2(40),
    CREATED_BY VARCHAR2(200),
    UPDATED_BY VARCHAR2(200),
    SENT_BY VARCHAR2(200),
    CREATED_DATE DATE,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
	IS_ACTIVE NUMBER(1) DEFAULT (1) NOT NULL,
	IS_DELETED NUMBER(1) DEFAULT (0) NOT NULL,
    constraint PK_TREC_HLDR_REP_APP primary key (TREC_HLDR_REPRESENT_APP_ID),
	constraint FK_TREC_HLDR_REP_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
    constraint FK_TREC_HLDR_REP_APP_PERSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)
);

	  
------------------------------------------------------
 TREC_HLDR_REPRESENT_CHANGE_APP
------------------------------------------------------

CREATE TABLE TREC_HLDR_REPRESENT_CHA_APP(
    TREC_HLDR_REP_CHA_APP_ID NUMBER(10) NOT NULL,
	TREC_HLDR_REPRESENT_ID NUMBER(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	PERSONNEL_INFO_ID NUMBER(10,0) NOT NULL,
	FEE FLOAT(126),
	FEE_FILE VARCHAR2(255 CHAR),
	EFFECTIVE_FROM_DATE DATE ,
	END_DATE  DATE ,
	REMARKS VARCHAR2(255),
	STATUS VARCHAR2(40),
    CREATED_BY varchar2(200),
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE DATE,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
	IS_ACTIVE NUMBER(1) DEFAULT (1) NOT NULL,
	IS_DELETED NUMBER(1) DEFAULT (0) NOT NULL,
    constraint PK_TREC_HLDR_REP_CHA_APP primary key (TREC_HLDR_REP_CHA_APP_ID),
    constraint FK_TREC_HLDR_REP_CHA_APP_REP foreign key (TREC_HLDR_REPRESENT_ID) references TREC_HLDR_REPRESENT(TREC_HLDR_REPRESENT_ID),
    constraint FK_TREC_HLDR_REP_CHA_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
    constraint FK_TREC_HLDR_REP_CHA_APP_PRSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)	  
);

------------------------------------------------------
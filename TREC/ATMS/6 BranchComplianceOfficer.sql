

-----------------------OLD-------------------------------

drop table BRNCH_COMP_OFFCR_CHNG_APP CASCADE CONSTRAINTS;
drop table BRNCH_COMP_OFFCR_HIST CASCADE CONSTRAINTS;

drop table BRNCH_COMPL_OFFICER_CHNG_APP cascade constraints;
drop table BRNCH_COMPL_OFFICER_HIST cascade constraints;

-----------------------new-------------------------------

DELETE from BRNCH_COMPL_OFFICER_APP;
DELETE from BRNCH_COMPL_OFFICER ;
DELETE from BRNCH_COMPL_OFFICER_RMV_APP;

commit;
------------------------------------------------------
 BRNCH_COMPL_OFFICER_APP
------------------------------------------------------

CREATE TABLE BRNCH_COMPL_OFFICER_APP(
	BRNCH_COMPL_OFFICER_APP_ID NUMBER(10,0) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	OFFICE_ID NUMBER(5,0) NOT NULL,
	PERSONNEL_INFO_ID NUMBER(10,0) NOT NULL,
	APPROVAL_DATE DATE, 
	REMARKS VARCHAR2(255 CHAR), 
	STATUS VARCHAR2(40),
	CREATED_BY varchar2(200),
	UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
	CREATED_DATE DATE,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
	IS_DELETED number(1) DEFAULT (0) NOT NULL,

	constraint PK_BR_COM_OFCR_APP_ID primary key (BRNCH_COMPL_OFFICER_APP_ID),
	constraint FK_BR_COM_OFCR_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
	constraint FK_BR_COM_OFCR_APP_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID),
    constraint FK_BR_COM_OFCR_APP_PERSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)

);

------------------------------------------------------
 BRNCH_COMPL_OFFICER_RMV_APP
------------------------------------------------------

CREATE TABLE BRNCH_COMPL_OFFICER_RMV_APP(
    BRNCH_COMPL_OFFICER_RMV_APP_ID number(10) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	OFFICE_ID NUMBER(5,0) NOT NULL,
	PERSONNEL_INFO_ID NUMBER(10,0) NOT NULL,
	APPROVAL_DATE DATE, 
	REMARKS VARCHAR2(255 CHAR), 
	STATUS VARCHAR2(40),
	CREATED_BY varchar2(200),
	UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
	CREATED_DATE DATE,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
	IS_DELETED number(1) DEFAULT (0) NOT NULL,

    constraint PK_BR_COM_OFCR_RMV_APP primary key (BRNCH_COMPL_OFFICER_RMV_APP_ID),
    constraint FK_BR_COM_OFCR_RMV_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
	constraint FK_BR_COM_OFCR_RMV_APP_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID),
    constraint FK_BR_COM_OFCR_RMV_APP_PERSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)
);

------------------------------------------------------


select * from PERSONNEL_INFO;

drop table BRANCH_MANAGER_CHANGE_APP cascade constraints;
drop table BRANCH_MANAGER_HIST cascade constraints;

drop table BRANCH_MANAGER_APP cascade constraints;
drop table BRANCH_MANAGER cascade constraints;
drop table BRANCH_MANAGER_REMOVE_APP cascade constraints;

------------------------NEW------------------------------

DELETE from BRANCH_MANAGER_APP ; 
DELETE from BRANCH_MANAGER ; 
DELETE from BRANCH_MANAGER_REMOVE_APP ; 

commit;

------------------------------------------------------
 BRANCH_MANAGER_APP
------------------------------------------------------

CREATE TABLE BRANCH_MANAGER_APP(
	BRANCH_MANAGER_APP_ID NUMBER(10,0) NOT NULL,
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

	constraint PK_BR_MANAGER_APP_ID primary key (BRANCH_MANAGER_APP_ID),
    constraint FK_BR_MANAGER_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
	constraint FK_BR_MANAGER_APP_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID),
    constraint FK_BR_MANAGER_APP_PERSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)
);

------------------------------------------------------
 BRANCH_MANAGER_REMOVE_APP
------------------------------------------------------

CREATE TABLE BRANCH_MANAGER_REMOVE_APP(
    BRANCH_MANAGER_REMOVE_APP_ID number(10) NOT NULL,
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

    constraint PK_BR_MANAGER_RMV_APP primary key (BRANCH_MANAGER_REMOVE_APP_ID),
    constraint FK_BR_MANAGER_RMV_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
	constraint FK_BR_MANAGER_RMV_APP_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID),
    constraint FK_BR_MANAGER_RMV_APP_PERSON foreign key (PERSONNEL_INFO_ID) references PERSONNEL_INFO(PERSONNEL_INFO_ID)
);

------------------------------------------------------

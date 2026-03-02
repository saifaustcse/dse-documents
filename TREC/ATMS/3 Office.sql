

select * from AUTHORIZED_CAPITAL;
select * from PAID_UP_CAPITAL;
select * from TREC_HOLDER_CERT;
select * from TREC_HOLDER_CERT_REMINDER;
select * from TREC_HOLDER_CERT_RENEWAL;
select * from ADDITIONAL_SPACE;
select * from ADDITIONAL_SPACE_CLOSE;


select * from TC;
select * from TC_ACTION;
select * from TC_REMINDER;
select * from TC_RENEWAL;
select * from APPROVED_TC;

select * from APPROVED_TC;



------------------------------------tabes-----------------------------------------------------

select * from APP_OFFICE;
--select * from FLOW_OFFICE; -- not using need to be used instead of FLOW
select * from APPROVED_OFFICE;  -- select * from OFFICE;  -- actual table

select * from APP_OFFICE_CLOSE; -- select * from OFFICE_CLOSE; -- actual table
select * from APP_OFFICE_SHIFT; -- select * from OFFICE_SHIFT; -- actual table
select * from HIST_OFFICE_SHIFT;

select * from FLOW;
select * from OFFICE_CLOSE;
select * from OFFICE_SHIFT;


drop table APP_OFFICE cascade constraints;
drop table APPROVED_OFFICE cascade constraints;
drop table APP_OFFICE_CLOSE cascade constraints;
drop table APP_OFFICE_SHIFT cascade constraints;
drop table HIST_OFFICE_SHIFT cascade constraints;

------------------------NEW------------------------------

select * from OFFICE_APP ; 
select * from OFFICE_CLOSE_APP ; 
select * from OFFICE_SHIFT_APP ; 
select * from OFFICE_SHIFT_HIST ; 

------------------------------------------------------
 OFFICE_APP
------------------------------------------------------

CREATE TABLE OFFICE_APP(
	OFFICE_APP_ID NUMBER(10,0) NOT NULL,
	TREC_ID NUMBER(5,0) NOT NULL,
	OFFICE_TYPE VARCHAR2(40 CHAR) NOT NULL, 
	LOCATION VARCHAR2(255 CHAR), 
	AREA VARCHAR2(40 CHAR), 
	DISTRICT VARCHAR2(40 CHAR), 
	THANA VARCHAR2(40 BYTE),
	EUNION VARCHAR2(40 BYTE), 
	FEE_FILE VARCHAR2(255 CHAR),
	REMARKS VARCHAR2(255 CHAR), 
	STATUS VARCHAR2(40),
	CREATED_BY varchar2(200) NOT NULL,
	UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
	CREATED_DATE DATE NOT NULL,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,

	constraint PK_OFFICE_APP_ID primary key (OFFICE_APP_ID),
	constraint FK_OFFICE_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID) ON DELETE CASCADE ENABLE
	
	--constraint FK_OFFICE_APP_CR_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
	--constraint FK_OFFICE_APP_UP_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
	--constraint FK_OFFICE_APP_ST_BY foreign key (SENT_BY) references DSESMS.TBLUSERINFO(USER_ID)
);

------------------------------------------------------
 OFFICE
------------------------------------------------------

ALTER TABLE office ADD OFFICE_APP_ID NUMBER(10,0);

------------------------------------------------------
 OFFICE_CLOSE_APP
------------------------------------------------------

CREATE TABLE OFFICE_CLOSE_APP(
    OFFICE_CLOSE_APP_ID NUMBER(10,0) NOT NULL,
	OFFICE_ID NUMBER(5,0) NOT NULL,
	FEE_FILE VARCHAR2(255 CHAR),
	REMARKS VARCHAR2(255 CHAR), 
	STATUS VARCHAR2(40),
	CREATED_BY varchar2(200) NOT NULL,
	UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
	CREATED_DATE DATE NOT NULL,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,

	constraint PK_OFFICE_CLOSE_APP_ID primary key (OFFICE_CLOSE_APP_ID),
	constraint FK_OFFICE_CLOSE_APP_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID) ON DELETE CASCADE ENABLE
	
	--constraint FK_OFFICE_CLOSE_APP_CR_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
	--constraint FK_OFFICE_CLOSE_APP_UP_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
	--constraint FK_OFFICE_CLOSE_APP_ST_BY foreign key (SENT_BY) references DSESMS.TBLUSERINFO(USER_ID)
);


------------------------------------------------------
 OFFICE_SHIFT_APP
------------------------------------------------------

CREATE TABLE OFFICE_SHIFT_APP(
    OFFICE_SHIFT_APP_ID NUMBER(10,0) NOT NULL,
	OFFICE_ID NUMBER(5,0) NOT NULL,
	NEW_LOCATION VARCHAR2(255 CHAR), 
	NEW_AREA VARCHAR2(40 CHAR), 
	NEW_DISTRICT VARCHAR2(40 CHAR), 
	NEW_UNION VARCHAR2(40 BYTE), 
	NEW_THANA VARCHAR2(40 BYTE),
	FEE_FILE VARCHAR2(255 CHAR),
	REMARKS VARCHAR2(255 CHAR), 
	STATUS VARCHAR2(40),
	CREATED_BY varchar2(200) NOT NULL,
	UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
	CREATED_DATE DATE NOT NULL,
	UPDATED_DATE DATE,
	SUBMISSION_DATE DATE,
	IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,

	constraint PK_OFFICE_SHIFT_APP_ID primary key (OFFICE_SHIFT_APP_ID),
	constraint FK_OFFICE_SHIFT_APP_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID) ON DELETE CASCADE ENABLE
		
	--constraint FK_OFFICE_SHIFT_APP_CR_BY foreign key (CREATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
	--constraint FK_OFFICE_SHIFT_APP_UP_BY foreign key (UPDATED_BY) references DSESMS.TBLUSERINFO(USER_ID),
	--constraint FK_OFFICE_SHIFT_APP_ST_BY foreign key (SENT_BY) references DSESMS.TBLUSERINFO(USER_ID)
);




	
	

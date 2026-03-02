

--------------------------ADMIN------------------------------------

delete from WORKSTATION_ACTION;
delete from WK_SHFT_ADD_SP_ADD_SP;
delete from WK_SHIFT_OFFICE_OFFICE;
delete from WORKSTATION_ADDITIONAL_SPACE;
delete from WORKSTATION_OFFICE;
delete from WORKSTATION;
commit;

------------------------NEW------------------------------

delete from WORKSTATION_ACTION;
delete from WORKSTATION_APP;
delete from WORKSTATION_SUSPENSION_APP;
delete from WORKSTATION_RESUME_APP;
delete from WORKSTATION_SHIFT_APP;
delete from WORKSTATION_SHIFT_HIST;

delete from WORKSTATION_OFFICE;
delete from WORKSTATION;

commit;

------------------------------------------------------
 WORKSTATION_APP
------------------------------------------------------

CREATE TABLE WORKSTATION_APP(
    WORKSTATION_APP_ID number(10) NOT NULL,
	TREC_ID number(5,0) NOT NULL,
	OFFICE_ID number(5) NOT NULL,    
	FEE_FILE VARCHAR2(255 CHAR),
	REMARKS varchar2(255),
	STATUS varchar2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE date NOT NULL,
	UPDATED_DATE date,
	SUBMISSION_DATE date,
	IS_MODERATE_BY_NET number(1) DEFAULT (0) NOT NULL,       
	IS_MODERATE_BY_APP number(1) DEFAULT (0) NOT NULL,     
	IS_MODERATE_BY_SYS number(1) DEFAULT (0) NOT NULL,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_WRKST_APP primary key (WORKSTATION_APP_ID),
    constraint FK_WRKST_APP_TREC foreign key (TREC_ID) references TREC(TREC_ID),
	constraint FK_WRKST_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID)
);

------------------------------------------------------
 WORKSTATION_APP_MOD_BY_NET
------------------------------------------------------

CREATE TABLE WORKSTATION_APP_MOD_BY_NET(
    WORKSTATION_APP_MOD_BY_NET_ID number(10) NOT NULL,
	WORKSTATION_APP_ID number(10) NOT NULL,
	IP_ADDRESS_1  varchar2(40 CHAR), 
	IP_ADDRESS_2  varchar2(40 CHAR), 
	IP_ADDRESS_3  varchar2(40 CHAR),
	COMMENTS  varchar2(255 CHAR),
	REMARKS varchar2(255),
	STATUS  varchar2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
    CREATED_DATE date NOT NULL,
	UPDATED_DATE date,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_WRKST_APP_MOD_BY_NET primary key (WORKSTATION_APP_MOD_BY_NET_ID),
	constraint FK_WRKST_APP_MOD_BY_NET_APP foreign key (WORKSTATION_APP_ID) references WORKSTATION_APP(WORKSTATION_APP_ID)
);

------------------------------------------------------
 WORKSTATION_APP_MOD_BY_APP
------------------------------------------------------

CREATE TABLE WORKSTATION_APP_MOD_BY_APP(
    WORKSTATION_APP_MOD_BY_APP_ID number(10) NOT NULL,
	WORKSTATION_APP_ID number(10) NOT NULL,
	TWS_ID  varchar2(40 CHAR) NOT NULL,   
	COMMENTS      varchar2(255 CHAR) ,
	REMARKS varchar2(255),
	STATUS varchar2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
    CREATED_DATE date NOT NULL,
	UPDATED_DATE date,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_WRKST_APP_MOD_BY_APP primary key (WORKSTATION_APP_MOD_BY_APP_ID),
    constraint FK_WRKST_APP_MOD_BY_APP_APP foreign key (WORKSTATION_APP_ID) references WORKSTATION_APP(WORKSTATION_APP_ID)
);


------------------------------------------------------
 WORKSTATION_SUSPENSION_APP
------------------------------------------------------

CREATE TABLE WORKSTATION_SUSPENSION_APP(
    WORKSTATION_SUSPENSION_APP_ID number(10) NOT NULL,
	WORKSTATION_ID number(5) NOT NULL,
	FEE_FILE VARCHAR2(255 CHAR),
	REMARKS varchar2(255),
	STATUS varchar2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
    CREATED_DATE date NOT NULL,
	UPDATED_DATE date,
	SUBMISSION_DATE date,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_WRKST_SUSPENSION_APP primary key (WORKSTATION_SUSPENSION_APP_ID),
	constraint FK_WRKST_SUSPENSION_APP_WRKST foreign key (WORKSTATION_ID) references WORKSTATION(WORKSTATION_ID)
);

------------------------------------------------------
 WORKSTATION_RESUME_APP
------------------------------------------------------

CREATE TABLE WORKSTATION_RESUME_APP(
    WORKSTATION_RESUME_APP_ID number(10) NOT NULL,
	WORKSTATION_ID number(5) NOT NULL, 
	FEE_FILE VARCHAR2(255 CHAR),	
	REMARKS varchar2(255),
	STATUS varchar2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
	SENT_BY varchar2(200),
    CREATED_DATE date NOT NULL,
	UPDATED_DATE date,
	SUBMISSION_DATE date,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_WRKST_RESUME_APP primary key (WORKSTATION_RESUME_APP_ID),
	constraint FK_WRKST_RESUME_APP_WRKST foreign key (WORKSTATION_ID) references WORKSTATION(WORKSTATION_ID)
);

------------------------------------------------------
 WORKSTATION_SHIFT_APP
------------------------------------------------------

CREATE TABLE WORKSTATION_SHIFT_APP(
    WORKSTATION_SHIFT_APP_ID number(10) NOT NULL,
	WORKSTATION_ID number(5) NOT NULL,
	OFFICE_ID number(5) NOT NULL,   
	FEE_FILE VARCHAR2(255 CHAR),		
	REMARKS varchar2(255),
	STATUS varchar2(40),
    CREATED_BY varchar2(200) NOT NULL,
    UPDATED_BY varchar2(200),
    SENT_BY varchar2(200),
    CREATED_DATE date NOT NULL,
	UPDATED_DATE date,
	SUBMISSION_DATE date,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
	
    constraint PK_WRKST_SHIFT_APP primary key (WORKSTATION_SHIFT_APP_ID),
	constraint FK_WRKST_SHIFT_APP_WRKST foreign key (WORKSTATION_ID) references WORKSTATION(WORKSTATION_ID),
	constraint FK_WRKST_SHIFT_OFFICE foreign key (OFFICE_ID) references OFFICE(OFFICE_ID)
);

------------------------------------------------------------------------------------------------
 WORKSTATION_OFFICE_APP   -- will be used only for migrated data as office is not assigned
------------------------------------------------------------------------------------------------

CREATE TABLE WORKSTATION_OFFICE_APP(
    WORKSTATION_OFFICE_APP_ID number(10) NOT NULL,
	WORKSTATION_ID number(5) NOT NULL,
	OFFICE_ID number(5),         
    APPROVED_BY varchar2(200),
    APPROVED_DATE DATE,
    IS_ACTIVE number(1) DEFAULT (1) NOT NULL,
    IS_DELETED number(1) DEFAULT (0) NOT NULL,
    constraint PK_WRKST_OFFICE_APP primary key (WORKSTATION_OFFICE_APP_ID),
    constraint FK_WRKST_OFFICE_APP_WRKST foreign key (WORKSTATION_ID) references WORKSTATION(WORKSTATION_ID)
);

------------------------------------------------------

------------------------------------------------------
TREC_DSESMS.TBLEMPLEVEL
------------------------------------------------------

CREATE TABLE  TBLEMPLEVEL(
    EMPLEVELID  NOT NULL NUMBER(4)     
    LEVELNAME   NOT NULL VARCHAR2(256) 
    DESCRIPTION          VARCHAR2(256) 
    PRIORITY    NOT NULL NUMBER(4)   

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.USER_EMP_INFO
------------------------------------------------------

CREATE TABLE  USER_EMP_INFO(
    USER_EMP_ID NOT NULL NUMBER(10) 
    LOGINID     NOT NULL NUMBER(5)  
    EMPID       NOT NULL NUMBER(5) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLEMPINFO
------------------------------------------------------

CREATE TABLE  TBLEMPINFO(
    EMPID            NOT NULL NUMBER(5)     
    FULLNAME         NOT NULL VARCHAR2(120) 
    EMPLEVELID       NOT NULL NUMBER(4)     
    DEPTID           NOT NULL NUMBER(4)     
    WINGID                    NUMBER(4)     
    DIVISIONID       NOT NULL NUMBER(4)     
    EMPSTATUS        NOT NULL VARCHAR2(50)  
    NID                       VARCHAR2(100) 
    REPORTTO                  NUMBER(5)     
    ISACTIVE         NOT NULL CHAR(1)       
    PERMANENTADDRESS          VARCHAR2(300) 
    PRESENTADDRESS            VARCHAR2(300) 
    EMAIL            NOT NULL VARCHAR2(50)  
    DOB              NOT NULL DATE          
    GENDER                    CHAR(1)       
    MARITALSTATUS             CHAR(1)       
    JOINDATE                  DATE          
    MOBILE                    VARCHAR2(30)  
    CREATIONDATE              DATE          
    SENIORITY        NOT NULL NUMBER(3)  
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLDIVISION
------------------------------------------------------

CREATE TABLE  TBLDIVISION(
    DIVISIONID   NOT NULL NUMBER(4)     
    DIVISIONNAME NOT NULL VARCHAR2(100) 
    DESCRIPTION           VARCHAR2(256)
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLDIVISIONHEAD
------------------------------------------------------

CREATE TABLE  TBLDIVISIONHEAD(
    DIVINCHARGEID NOT NULL NUMBER(5)     
    EMPID         NOT NULL NUMBER(4)     
    DIVISIONID    NOT NULL NUMBER(4)     
    ISDIVHEAD     NOT NULL CHAR(1)       
    DESCRIPTION            VARCHAR2(500)  
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLDEPARTMENT
------------------------------------------------------

CREATE TABLE  TBLDEPARTMENT(
    DEPARTMENTNAME NOT NULL VARCHAR2(100) 
    ISACTIVE       NOT NULL CHAR(1)       
    DESCRIPTION             VARCHAR2(256) 
    WINGID                  NUMBER(4)     
    DIVISIONID     NOT NULL NUMBER(4)     
    LOCATIONID              NUMBER(5)     
    DEPTID         NOT NULL NUMBER(4)

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLDEPTINCHARGE
------------------------------------------------------

CREATE TABLE  TBLDEPTINCHARGE(
    DEPTINCHARGEID NOT NULL NUMBER(5)     
    EMPID          NOT NULL NUMBER(5)     
    DEPTID         NOT NULL NUMBER(4)     
    ISDEPTHEAD     NOT NULL CHAR(1)       
    ISACTIVE       NOT NULL CHAR(1)       
    DESCRIPTION             VARCHAR2(500) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLWING
------------------------------------------------------

CREATE TABLE  TBLWING(

    WINGID      NOT NULL NUMBER(4)     
    WINGNAME    NOT NULL VARCHAR2(100) 
    DIVISIONID  NOT NULL NUMBER(4)     
    DESCRIPTION          VARCHAR2(256) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);


------------------------------------------------------
TREC_DSESMS.TBLLOCATION
------------------------------------------------------

CREATE TABLE  TBLLOCATION(

    LOCATIONID   NOT NULL NUMBER(5)     
    LOCATIONNAME NOT NULL VARCHAR2(256) 
    ADDRESS               VARCHAR2(256) 
    DESCRIPTION           VARCHAR2(256) 
    FLOORNO               VARCHAR2(40)  

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

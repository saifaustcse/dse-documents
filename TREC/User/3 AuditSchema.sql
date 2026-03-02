
------------------------------------------------------
TREC_DSESMS.TBLAUDITLOGINFO
------------------------------------------------------

CREATE TABLE  TBLAUDITLOGINFO(
    ID            NOT NULL NUMBER(10)    
    USERID        NOT NULL NUMBER(5)     
    USERIPADDRESS          VARCHAR2(100) 
    ACCESSTIME    NOT NULL DATE          
    STATUS                 VARCHAR2(50)  
    SIGN_OUT_TIME          DATE          
    DESCRIPTION            VARCHAR2(250) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLAUDITFORGOTPASSWORD
------------------------------------------------------

CREATE TABLE  TBLAUDITFORGOTPASSWORD(
    ID              NOT NULL NUMBER(10)    
    USERID          NOT NULL NUMBER(5)     
    USERNAME                 VARCHAR2(100) 
    USERDEPARTMENT           VARCHAR2(100) 
    USERDESIGNATION          VARCHAR2(100) 
    DOB                      DATE          
    USERIPADDRESS   NOT NULL VARCHAR2(100) 
    ACCESSTIME      NOT NULL DATE          
    STATUS                   VARCHAR2(50)  
    DESCRIPTION              VARCHAR2(250

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLAUDITDETAIL_LOB
------------------------------------------------------

CREATE TABLE  TBLAUDITDETAIL_LOB(
    ID         NOT NULL NUMBER       
    AUDITID    NOT NULL NUMBER       
    COLUMNNAME          VARCHAR2(50) 
    NEWVALUE            NCLOB        
    OLDVALUE            NCLOB    

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLAUDITDETAIL
------------------------------------------------------

CREATE TABLE  TBLAUDITDETAIL(
    ID         NOT NULL NUMBER         
    AUDITID    NOT NULL NUMBER         
    COLUMNNAME          VARCHAR2(50)   
    NEWVALUE            VARCHAR2(4000) 
    OLDVALUE            VARCHAR2(4000)  

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);


------------------------------------------------------
TREC_DSESMS.TBLAUDITMASTER
------------------------------------------------------

CREATE TABLE  TBLAUDITMASTER(
    ID                   NOT NULL NUMBER       
    USERID               NOT NULL NUMBER(5)    
    MENUID               NOT NULL NUMBER(4)    
    ACTIONTYPE                    VARCHAR2(30) 
    TABLENAME                     VARCHAR2(50) 
    DATETIME                      DATE         
    IDCOLUMN                      VARCHAR2(30) 
    IDVALUE                       VARCHAR2(30) 
    TRANSACTION_SCOPE_ID          NUMBER(10)   
    SCHEMA_NAME                   VARCHAR2(40) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.ERROR_TABLE
------------------------------------------------------

CREATE TABLE  ERROR_TABLE(
    ECODE      NUMBER        
    EMSG       VARCHAR2(250) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLERROR
------------------------------------------------------

CREATE TABLE  TBLERROR(

    PACKAGENAME      VARCHAR2(250) 
    CLASSNAME        VARCHAR2(250) 
    METHODNAME       VARCHAR2(250) 
    ERRORTYPE        VARCHAR2(250)  

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.SYS_EXPORT_SCHEMA_01
------------------------------------------------------



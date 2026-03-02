


------------------------------------------------------
TREC_DSESMS.ROLE_TYPE
------------------------------------------------------

CREATE TABLE  ROLE_TYPE(
    ROLE_TYPE_ID NOT NULL NUMBER(10)         
    ROLEID                NUMBER(4)          
    USER_GROUP            VARCHAR2(40 CHAR)  
    USER_TYPE             VARCHAR2(40 CHAR)  
    ISDELETED             CHAR(1 CHAR)       
    STATUS                VARCHAR2(40 CHAR)  
    ORGANIZATION          VARCHAR2(255 CHAR) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLROLE
------------------------------------------------------

CREATE TABLE  TBLROLE(
    ROLEID      NOT NULL NUMBER(4)     
    ROLENAME    NOT NULL VARCHAR2(100)  -- Role name (e.g., "Admin", "User")
    DESCRIPTION          VARCHAR2(255) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLUSERROLEINFO
------------------------------------------------------

CREATE TABLE  TBLUSERROLEINFO(
    ID      NOT NULL NUMBER(5) 
    LOGINID NOT NULL NUMBER(5) 
    ROLEID  NOT NULL NUMBER(4) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLMENU
------------------------------------------------------

CREATE TABLE  TBLMENU(
    MENUID    NOT NULL NUMBER(5)     
    MENUNAME  NOT NULL VARCHAR2(100) 
    LINK               VARCHAR2(150) 
    PARENTID           NUMBER(5)     
    MENUORDER          NUMBER(3)
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLUSERPRIVILEGE
------------------------------------------------------

CREATE TABLE  TBLUSERPRIVILEGE(
    ID           NOT NULL NUMBER(5) 
    LOGINID      NOT NULL NUMBER(5) 
    ROLEID                NUMBER(4) 
    MENUID       NOT NULL NUMBER(5) 
    SELECTSTATUS          NUMBER(1) 
    INSERTSTATUS          NUMBER(1) 
    UPDATESTATUS          NUMBER(1) 
    DELETESTATUS          NUMBER(1
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLROLEDETAILS
------------------------------------------------------

CREATE TABLE  TBLROLEDETAILS(
    ID           NOT NULL NUMBER(5) 
    ROLEID       NOT NULL NUMBER(4) 
    MENUID       NOT NULL NUMBER(5) 
    SELECTSTATUS          NUMBER(1) 
    INSERTSTATUS          NUMBER(1) 
    UPDATESTATUS          NUMBER(1) 
    DELETESTATUS          NUMBER(1) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLPRIVILEGETYPE
------------------------------------------------------

CREATE TABLE  TBLPRIVILEGETYPE(
    ID            NOT NULL NUMBER(1)    
    DESCRIPTION            VARCHAR2(80) 
    PRIVILEGENAME NOT NULL VARCHAR2(20) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);


------------------------------------------------------

SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name = 'USER'
    AND constraint_type IN ('P', 'U')
);

------------------------------------------------------
TREC_DSESMS.USER_CATEGORY
------------------------------------------------------

CREATE TABLE  USER_CATEGORY(
    USER_CAT_ID   NOT NULL NUMBER(5)     
    USER_CAT_NAME NOT NULL VARCHAR2(200) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.USER_CAT_HOMEPAGE
------------------------------------------------------

CREATE TABLE  USER_CAT_HOMEPAGE(
    ID          NOT NULL NUMBER(10)         
    USER_CAT_ID          NUMBER(5)          
    LINK                 VARCHAR2(255 CHAR) 
    ISDELETED            CHAR(1 CHAR)       
    STATUS               VARCHAR2(40 CHAR) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.USER_PROFILE
------------------------------------------------------

CREATE TABLE USER_PROFILE
(
    USER_PROFILE_ID   NOT NULL NUMBER(10)    
    FULLNAME          NOT NULL VARCHAR2(220) 
    DESIGNATION       NOT NULL VARCHAR2(120) 
    NID                        VARCHAR2(100) 
    PERMANENT_ADDRESS          VARCHAR2(500) 
    PRESENT_ADDRESS            VARCHAR2(500) 
    EMAIL             NOT NULL VARCHAR2(50)  
    GENDER                     CHAR(1)       
    MOBILE                     VARCHAR2(200) 
    CREATION_DATE              DATE          
    STATUS            NOT NULL VARCHAR2(200)

    --CONSTRAINT PK_DEALER_ID PRIMARY KEY (DEALER_ID),
    --CONSTRAINT FK_DEALER_TREC FOREIGN KEY (TREC_ID) REFERENCES TREC_TREC.TREC (TREC_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLUSERINFO
------------------------------------------------------

CREATE TABLE  TBLUSERINFO(
    LOGINID                 NOT NULL NUMBER(5)     
    USERPASSWORD            NOT NULL VARCHAR2(50)  
    ISACTIVE                NOT NULL CHAR(1)       
    USERCREATIONDATE        NOT NULL DATE          
    PRIVILEGETYPE           NOT NULL NUMBER(1)     
    CODE                             VARCHAR2(100) 
    PASSWORD_CHANGE_DATE             DATE          
    USER_ID                 NOT NULL VARCHAR2(200) 
    USER_CAT_ID             NOT NULL NUMBER(5)     
    STATUS                  NOT NULL VARCHAR2(100) 
    IS_OTP_ENABLE                    CHAR(1)       
    IS_PROFILE_LOCK                  CHAR(1)       
    PROFILE_LOCK_UNTILL              DATE          
    IS_MULTILOGIN_ENABLE             CHAR(1 CHAR)  
    PASSWORD_WRONG_ATTEMPTS          NUMBER(5)     
    STAKEHOLDER_CAT_ID               NUMBER(5) 

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.USER_PROFILE_MAPPING
------------------------------------------------------

CREATE TABLE USER_PROFILE_MAPPING(
    USER_PROF_MAP_ID NOT NULL NUMBER(10) 
    USER_PROFILE_ID  NOT NULL NUMBER(10) 
    LOGINID          NOT NULL NUMBER(5) 
    --CONSTRAINT PK_DEALER_STATUS_ID PRIMARY KEY (DEALER_STATUS_ID),
    --CONSTRAINT FK_DEALER_STATUS_DEALER_ID FOREIGN KEY (DEALER_ID) REFERENCES DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.USER_TREC
------------------------------------------------------

CREATE TABLE  USER_TREC(
    USER_TREC_ID            NOT NULL NUMBER(10)        
    LOGINID                 NOT NULL NUMBER(5)         
    TREC_NO                 NOT NULL NUMBER(5)         
    USER_STATUS                      VARCHAR2(40 CHAR) 
    STAKEHOLDER_CATEGORY_ID          NUMBER(5)         

    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);


------------------------------------------------------
TREC_DSESMS.USER_HOMEPAGE
------------------------------------------------------

CREATE TABLE  USER_HOMEPAGE(
    ID        NOT NULL NUMBER(10)         
    LOGINID            NUMBER(5)          
    LINK               VARCHAR2(255 CHAR) 
    ISDELETED          CHAR(1 CHAR)       
    STATUS             VARCHAR2(40 CHAR)  
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.USER_EXCEPTION
------------------------------------------------------

CREATE TABLE  USER_EXCEPTION(
    ID       NOT NULL NUMBER(10)        
    LOGINID           NUMBER(5)         
    MENUID            NUMBER(5)         
    ISACTIVE          CHAR(1 CHAR)      
    STATUS            VARCHAR2(40 CHAR) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.TBLABC
------------------------------------------------------

CREATE TABLE  TBLABC(
    ID   NOT NULL NUMBER(4)     
    CN   NOT NULL VARCHAR2(200) 
    SD   NOT NULL DATE          
    ED   NOT NULL DATE          
    V    NOT NULL VARCHAR2(150) 
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);

------------------------------------------------------
TREC_DSESMS.SYSPARAM
------------------------------------------------------

CREATE TABLE  SYSPARAM(
    ID          NOT NULL NUMBER         
    PARAMNAME   NOT NULL VARCHAR2(50)   
    DESCRIPTION NOT NULL VARCHAR2(200)  
    PARAMVALUE           VARCHAR2(100)  
    PARAMNOTE            VARCHAR2(1000) 
    ADMINFLAG            VARCHAR2(5)    
    ISDELETED            CHAR(1)  
    --constraint PK_DEALER_RENEW_ID PRIMARY key (DEALER_RENEW_ID),
    --constraint FK_DEALER_RENEW_DEALER_ID foreign key (DEALER_ID) references DEALER(DEALER_ID)
);





























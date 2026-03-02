
------------------------------------------------------

select * from TMS_USER.AUDIT_LOGIN;
select * from TMS_USER.AUDIT_DETAIL;
select * from TMS_USER.AUDIT_MASTER;

------------------------------------------------------

delete from TMS_USER.AUDIT_LOGIN;
delete from TMS_USER.AUDIT_DETAIL;
delete from TMS_USER.AUDIT_MASTER;

commit;

------------------------------------------------------

drop table TMS_USER.AUDIT_LOGIN;
drop table TMS_USER.AUDIT_DETAIL;
drop table TMS_USER.AUDIT_MASTER;

------------------------------------------------------
TREC_DSESMS.AUDIT_LOGINFO
------------------------------------------------------

CREATE TABLE AUDIT_LOGIN
(
    AUDIT_LOGIN_ID      NUMBER(10)      NOT NULL, 
    USER_ID            NUMBER(10)      NOT NULL,   
    USER_IP_ADDRESS    VARCHAR2(45), 
    SIGN_IN_TIME       TIMESTAMP       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    SIGN_OUT_TIME      TIMESTAMP,
    REMARKS            VARCHAR2(500),

    CONSTRAINT PK_AUDIT_LOGIN PRIMARY KEY (AUDIT_LOGIN_ID),  
    CONSTRAINT FK_AUDIT_LOGIN_USER FOREIGN KEY (USER_ID) REFERENCES USER_INFO(USER_ID)
);


CREATE OR REPLACE FORCE VIEW "TMS_USER"."VW_AUDIT_LOGIN"
(
    "AUDIT_LOGIN_ID",
    "USER_IP_ADDRESS",
    "SIGN_IN_TIME",
    "SIGN_OUT_TIME",
    "REMARKS",

    "USER_ID",
    "USER_NAME",
    "PASSWORD_CHANGE_DATE",
    "PASSWORD_WRONG_ATTEMPTS",
    "PROFILE_LOCK_UNTIL",
    "INFO_REMARKS",
    "STATUS",
    
    "USER_PROFILE_ID",
    "USER_CAT_ID",
    "USER_CAT_NAME",
    "USER_IDENTIFIER_NAME",
    "USER_IDENTIFIER_VALUE",
    "FULL_NAME",
    "MOBILE",
    "EMAIL",
    "GENDER",
    "DESIGNATION",
    "PROFILE_REMARKS"
)
AS
SELECT
    aua.AUDIT_LOGIN_ID,
    aua.USER_IP_ADDRESS,
    aua.SIGN_IN_TIME,
    aua.SIGN_OUT_TIME,
    aua.REMARKS,

    ui.USER_ID,
    ui.USER_NAME,
    ui.PASSWORD_CHANGE_DATE,
    ui.PASSWORD_WRONG_ATTEMPTS,
    ui.PROFILE_LOCK_UNTIL,
    ui.REMARKS AS INFO_REMARKS,
    ui.STATUS,

    up.USER_PROFILE_ID,
    up.USER_CAT_ID,
    uc.USER_CAT_NAME,
    up.USER_IDENTIFIER_NAME,
    up.USER_IDENTIFIER_VALUE,
    up.FULL_NAME,
    up.MOBILE,
    up.EMAIL,
    up.GENDER,
    up.DESIGNATION,
    up.REMARKS AS PROFILE_REMARKS

FROM AUDIT_LOGIN aua
INNER JOIN USER_INFO ui ON aua.USER_ID = ui.USER_ID
INNER JOIN USER_PROFILE up ON ui.USER_PROFILE_ID = up.USER_PROFILE_ID
INNER JOIN USER_CATEGORY uc ON up.USER_CAT_ID = uc.USER_CAT_ID;

select * from VW_AUDIT_LOGIN;

------------------------------------------------------
TREC_DSESMS.AUDIT_MASTER 
------------------------------------------------------

CREATE TABLE AUDIT_MASTER
(
    AUDIT_MASTER_ID      NUMBER(10)        NOT NULL,
    USER_ID              NUMBER(10)        NOT NULL,
    MENU_ID              NUMBER(5)         NOT NULL,
    SCHEMA_NAME          VARCHAR2(50)      NOT NULL,
    TABLE_NAME           VARCHAR2(50)      NOT NULL,
    TABLE_ROW_ID         VARCHAR2(10)      NOT NULL, -- Works for all key types (int, long, Guid, string)
    ACTION_TYPE          VARCHAR2(30)      NOT NULL CHECK (ACTION_TYPE IN ('CREATE', 'READ', 'UPDATE', 'DELETE')),
    ACTION_DATE_TIME     TIMESTAMP         DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT PK_AUDIT_MASTER PRIMARY KEY (AUDIT_MASTER_ID),  
    CONSTRAINT FK_AUDIT_MASTER_USER FOREIGN KEY (USER_ID) REFERENCES USER_INFO(USER_ID)
);

------------------------------------------------------
TREC_DSESMS.AUDIT_DETAIL
------------------------------------------------------

CREATE TABLE AUDIT_DETAIL
(
    AUDIT_DETAIL_ID      NUMBER(10)       NOT NULL,
    AUDIT_MASTER_ID      NUMBER(10)       NOT NULL,
    COLUMN_NAME          VARCHAR2(100)    NOT NULL,
    OLD_VALUE            VARCHAR2(1000),
    NEW_VALUE            VARCHAR2(1000),

    CONSTRAINT PK_AUDIT_DETAIL PRIMARY KEY (AUDIT_DETAIL_ID),
    CONSTRAINT FK_AUDIT_DETAIL_MASTER FOREIGN KEY (AUDIT_MASTER_ID) REFERENCES AUDIT_MASTER(AUDIT_MASTER_ID)
);

------------------------------------------------------
TMS_USER.VW_AUDIT
------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "TMS_USER"."VW_AUDIT"  
( "AUDIT_MASTER_ID", "USER_ID", "MENU_ID",
  "SCHEMA_NAME","TABLE_NAME", "TABLE_ROW_ID", "ACTION_TYPE", "ACTION_DATE_TIME",
  "AUDIT_DETAIL_ID", "COLUMN_NAME", "OLD_VALUE", "NEW_VALUE",
  "USER_PROFILE_ID"
)
AS
SELECT
    am.AUDIT_MASTER_ID,
    am.USER_ID,
    am.MENU_ID,
    am.SCHEMA_NAME,
    am.TABLE_NAME,
    am.TABLE_ROW_ID,
    am.ACTION_TYPE,
    am.ACTION_DATE_TIME,
    
    ad.AUDIT_DETAIL_ID,
    ad.COLUMN_NAME,
    ad.OLD_VALUE,       
    ad.NEW_VALUE,

    ui.USER_PROFILE_ID

FROM AUDIT_MASTER am
INNER JOIN AUDIT_DETAIL ad ON am.AUDIT_MASTER_ID = ad.AUDIT_MASTER_ID
INNER JOIN USER_INFO ui ON ui.USER_ID = am.USER_ID;

select * from VW_AUDIT;



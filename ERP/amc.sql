

-- drop table AMC_info;
-- drop table amc_products;
-- drop table amc_document;
-- drop table amc_info_renew;
-- drop table amc_renew_products;
-- drop table amc_renew_document;
-- drop table amc_info_close;
-- drop table amc_reminder_setting;

--------------------------------------------------------------------------------

create table AMC_info
(
amc_id number(10) not null,
amc_name varchar2(100) not null,
product_name varchar2(500) not null,
vendor_id number(5) not null,
work_order_no VARCHAR2(200) ,
Work_Order_Date date,
work_name varchar2(200),
work_order_value float not null,
rate number(5),
purchase_date date not null,
qty number(16) not null,
amc_type varchar2(100) not null,
start_date date not null,
expiry_date date not null,
validity_days number(10),
amc_amount number(16,2) not null,
reference_no number(10) default 0 not null ,
renew_times numeric(5) not null,
reminder_days number(10) not null,
status varchar2(50) not null,
remarks varchar2(250),
added_by number(5) not null,
added_at date not null,
constraint Pk_amc_id primary key(amc_id),
constraint Fk_amc_vendor_ref FOREIGN KEY(vendor_id) references tblvendor(VENDORID)
);

--------------------------------------------------------------------------------


create table amc_products
(
product_id number(10) not null,
amc_id number(10) not null,
product_name varchar2(500) not null,
specification varchar2(1000) ,
serial_no varchar2(200),
Remarks varchar2(1000),
added_by number(5) not null,
added_at date not null,
CONSTRAINT pk_product_id PRIMARY key(product_id),
constraint Fk_product_amc FOREIGN KEY(amc_id) references AMC_info(amc_id)
);

--------------------------------------------------------------------------------


--document_Type='Contract/AMC/SLA/Warrenty/Renew'
create table amc_document
(
document_id number(8) not null,
document_Type varchar2(200) not null,
amc_id number(10) not null,
doc_url varchar2(500) not null,
remarks varchar2(500),
added_by number(5) not null,
added_at date not null,
CONSTRAINT pk_amc_doc_id PRIMARY key(document_id),
constraint Fk_amc_doc_ref FOREIGN KEY(amc_id) references AMC_info(amc_id)

);

--------------------------------------------------------------------------------


create table amc_info_renew
(
amc_renew_id number(10) not null,
amc_id number(10) not null,
vendor_id number(5) not null,
renew_date date not null,
expiry_date date not null,
amc_amount number(16,2) not null,
qty number(16) not null,
remarks varchar2(300),
added_by number(5) not null,
added_at date not null,
CONSTRAINT pk_amc_renew_id PRIMARY key(amc_renew_id),
constraint Fk_amc_renew FOREIGN KEY(amc_id) references AMC_info(amc_id),
constraint Fk_amc_vendor_renew FOREIGN KEY(vendor_id) references tblvendor(VENDORID)

);
--------------------------------------------------------------------------------


create table amc_renew_products
(
product_renew_id number(10) not null,
product_id number(10) not null,
amc_renew_id number(10) not null,
Remarks varchar2(1000),
added_by number(5) not null,
added_at date not null,
CONSTRAINT pk_product_renew_id PRIMARY key(product_id),
constraint Fk_product_amcrenew FOREIGN KEY(product_id) references amc_products(product_id),
constraint Fk_product_renewid FOREIGN KEY(amc_renew_id) references amc_info_renew(amc_renew_id)
);

--------------------------------------------------------------------------------

create table amc_renew_document
(
renew_document_id number(8) not null,
document_Type varchar2(200) not null,
amc_renew_id number(10) not null,
doc_url varchar2(500) not null,
remarks varchar2(500),
added_by number(5) not null,
added_at date not null,
CONSTRAINT pk_amc_renew_doc_id PRIMARY key(renew_document_id),
constraint Fk_amc_renew_doc_ref FOREIGN KEY(amc_renew_id) references amc_info_renew(amc_renew_id)

);

--------------------------------------------------------------------------------

--alter table bank_guarantee_info drop constraint Fk_bank_guarantee_refund;

create table amc_info_close
(
amc_close_id number(10) not null,
amc_id number(10) not null,
closing_date date not null,
remarks varchar2(300),
added_by number(5) not null,
added_at date not null,
CONSTRAINT pk_amc_amc_close_id PRIMARY key(amc_close_id),
constraint Fk_amc_close FOREIGN KEY(amc_id) references AMC_info(amc_id)
);

--------------------------------------------------------------------------------


create table amc_reminder_setting
(
amc_reminder_id number(5) not null,
module_id number(5) default 0 not null,
reminder_name varchar2(500) not null,
reminder_value varchar2(500) not null,
is_active char(1) default 'Y' not null,
added_by number(5) not null,
added_at date not null,
modified_by number(5)  ,
modified_at date ,
constraint pk_reminder_id primary key(amc_reminder_id)
);

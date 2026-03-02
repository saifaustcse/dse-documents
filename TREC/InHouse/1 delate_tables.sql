SELECT table_name, TO_NUMBER(
    EXTRACTVALUE(
        xmltype(
            DBMS_XMLGEN.GETXML('SELECT COUNT(*) c FROM ' || table_name)
        ),
        '/ROWSET/ROW/C'
    )
) AS num_rows
FROM user_tables;


DELETE from TR_SHARE_HOLDER_DETAILS;
DELETE from TR_SHARE_DIRECTOR_DETAILS;
DELETE from TR_SHARE_TRANSFER;

delete from WORKSTATION_STATUS;
delete from WORKSTATION_OFFICE;
delete from WORKSTATION_AUTH_REP;
delete from WORKSTATION;

delete from AUTH_REP_STATUS;
delete from AUTH_REP_RENEW;
delete from AUTH_REP;

delete from WORKSTATION_AUTH_REP;
delete from TREC_CAMALCO;
delete from TREC_POWER_OF_ATT;
delete from TREC_COMPLIANCE_AUTH;
delete from TREC_HLDR_REPRESENT;
delete from OFFICE_INCHARGE;
delete from OFFICE_COMPL_OFFICER;
delete from AUTH_REP;
delete from PERSONNEL;


delete from DEALER_STATUS;
delete from DEALER_RENEW;
delete from DEALER;

delete from BROKER_STATUS;
delete from BROKER_RENEW;
delete from BROKER;

delete from PERSONNEL;
delete from DUAL_TREC;
delete from TREC_AUDITOR;
delete from TREC_STATUS;
delete from TREC_CODE;
delete from TREC_NAME;
delete from TREC_AUTHORISED_CAPITAL;
delete from TREC_PAIDUP_CAPITAL;
delete from TREC_PARENT_COMPANY;
delete from TREC_DOCUMENT;
delete from  TREC_NETWORK;
delete from WORKSTATION;
delete from TR_SHARE_HOLDER_MASTER;

delete from OFFICE_TYPE;
delete from OFFICE_STATUS;
delete from OFFICE_ADDRESS;
delete from OFFICE_NETWORK;
delete from OFFICE_INCHARGE;
delete from OFFICE_COMPL_OFFICER;
delete from WORKSTATION_OFFICE;
delete from OFFICE;

delete from TREC;

delete from TREC_REG_BACKUP;
delete from OFFICE_BACKUP;
delete from AUTH_REP_BACKUP;
delete from WORKSTATION_BACKUP;
delete from TREC_BACKUP;
delete from TREC_NETWORK_BACKUP;

commit;


INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (231.0, 0.0, 6.0, 17.0, NULL, '130.10.231.1 (24004)', '130.1.1.4(2)', '6', 0.0, 0.0, NULL, '                                        ', 'FO', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (232.0, 0.0, 7.0, 11.0, NULL, '130.10.232.1(24005)', '130.1.1.3(4)', '7', 0.0, 0.0, NULL, '                                        ', 'FO', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (233.0, 0.0, 5.0, 7.0, NULL, '130.10.233.1 (24009)', '130.1.1.3(1)', '8', 0.0, 0.0, NULL, '                                        ', 'FO', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (234.0, 0.0, 2.0, 5.0, NULL, '130.10.234.1 (24008)', '130.1.1.6(2)', '9', 0.0, 0.0,NULL, '                                        ', 'FO', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (235.0, 0.0, 0.0, 0.0, NULL, '130.4.235.1/26 (24003)', '130.1.1.3(4)', '2', 0.0, 0.0,  NULL , '                                        ', 'DC', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (236.0, 0.0, 0.0, 0.0, NULL, '130.7.236.1(24006)', '130.1.1.4(1)', '2', 0.0, 0.0, NULL , '                                        ', 'L3', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (237.0, 0.0, 6.0, 19.0, NULL, '130.10.237.1 (24009)', '130.1.1.3(2)', '6', 0.0, 0.0, NULL, '                                        ', 'FO', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (238.0, 0.0, 2.0, 11.0, NULL, '130.10.238.1 (24009)', '130.1.1.4(1)', '8', 0.0, 0.0, NULL , '                                        ', 'FO', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (333.0, 0.0, 0.0, 0.0, ' ', ' ', '130.1.1.3 ', 'NULL', 0.0, 0.0, NULL, '                                        ', '  ', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (555.0, 0.0, 0.0, 0.0, NULL, '130.2.252.1', '130.1.1.4', 'NULL', 0.0, 0.0,NULL , ' ', 'XN', '');

INSERT INTO TREC_NETWORK_BACKUP (MEM_NO, XFERNO, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, OLD_IP, WANCON, NETREMARKS) 
VALUES (556.0, 0.0, 1.0, 16.0, NULL, '130.2.251.1(24003)', '130.1.1.3', 'NULL', 0.0, 0.0,NULL, '                                        ', 'FO', '');

------------------------------------------------------------------------------------------------------------------------------------

SELECT  * FROM [InHouse].[dbo].[hub] where mem_no < 600 order by mem_no, xferno asc;
-- SELECT ROW_NUMBER() OVER (Order by mem_no) AS id, * FROM [InHouse].[dbo].[hub] where mem_no > 600 order by mem_no, xferno asc;
SELECT count(*)  FROM [InHouse].[dbo].[hub] where mem_no < 600 ;-- 312

------------------------------------------------------------------------------------------------------------------------------------

--delete from TREC_NETWORK_BACKUP;
commit;
select count(*) from TREC_NETWORK_BACKUP; -- 312

---------------------------------------------------OFFICE_BACKUP---------------------------------------------------------------------

CREATE TABLE TREC_NETWORK_BACKUP ( 
ID NUMBER(10),
MEM_NO NUMBER(5),
XFERNO NUMBER(1),
HUB_NO NUMBER(5),
PORT NUMBER(5),
FLOOR VARCHAR2(40),
IP_ADDRESS VARCHAR2(50),
CARD_IP VARCHAR2(50),
SILO VARCHAR2(5),
DLUPNO NUMBER(10),
TMPDLUPNO VARCHAR2(5),
HOSTPORT VARCHAR2(10),
OLD_IP VARCHAR2(50),
WANCON VARCHAR2(5),
NETREMARKS VARCHAR2(100)
);

-------------------------------------------CLEAN--------------------------------------------------------

select  count (*) from TREC_NETWORK_BACKUP ; -- 312
select * from TREC_NETWORK_BACKUP WHERE MEM_NO NOT IN(select TREC_ID from TREC); -- 0
select * from TREC_NETWORK_BACKUP order by MEM_NO asc;

update TREC_NETWORK_BACKUP 
set MEM_NO = TRIM(MEM_NO),
XFERNO = TRIM(XFERNO),
HUB_NO = TRIM(HUB_NO), 
PORT = TRIM(PORT),
FLOOR = TRIM(FLOOR), 
IP_ADDRESS = TRIM(IP_ADDRESS), 
CARD_IP = TRIM(CARD_IP), 
SILO = TRIM(SILO), 
DLUPNO = TRIM(DLUPNO), 
TMPDLUPNO = TRIM(TMPDLUPNO), 
HOSTPORT = TRIM(HOSTPORT), 
OLD_IP = TRIM(OLD_IP), 
WANCON = TRIM(WANCON), 
NETREMARKS = TRIM(NETREMARKS);
-- 312 rows updated.

commit;

ALTER TABLE TREC_NETWORK_BACKUP ADD IS_ACTIVE number(1) DEFAULT (1) NOT NULL;

select ob.* from TREC_BACKUP tb
inner join TREC_NETWORK_BACKUP ob on tb.MEM_NO = ob.MEM_NO
and tb.XFERNO <> ob.XFERNO
order by tb.MEM_NO;

select MEM_NO, count(MEM_NO) from TREC_NETWORK_BACKUP group by MEM_NO having count(MEM_NO) >1 ; -- 0

commit;

-------------------------------------------INSERT TREC_NETWORK--------------------------------------------------------

--delete from TREC_NETWORK;

select count(*) from TREC_NETWORK; -- 312

insert into TREC_NETWORK (TREC_NETWORK_ID, TREC_ID, HUB_NO, PORT, FLOOR, IP_ADDRESSES, CARD_IP, OLD_IP, SILO, DLUPNO,  TMP_DLUPNO,  HOST_PORT, WAN_CON, REMARKS, ADDED_BY)
select ROWNUM TREC_NETWORK_ID, a.TREC_ID, a.HUB_NO, a.PORT, a.FLOOR, a.IP_ADDRESS, a.CARD_IP, a.OLD_IP, a.SILO, a.DLUPNO,  a.TMPDLUPNO,  a.HOSTPORT, a.WANCON, a.NETREMARKS, 496 as ADDED_BY from
(
select  TO_NUMBER(MEM_NO) as TREC_ID, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, OLD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, WANCON, NETREMARKS from TREC_NETWORK_BACKUP 
where  REGEXP_LIKE(MEM_NO, '^[0-9]+$') 
and TO_NUMBER(MEM_NO) IN (select TREC_ID from TREC)
order by TO_NUMBER(MEM_NO)
) a;

-- 301 rows inserted.
commit;

-------------------------------------------INSERT TREC_NETWORK--------------------------------------------------------

insert into TREC_NETWORK (TREC_NETWORK_ID, TREC_ID, HUB_NO, PORT, FLOOR, IP_ADDRESSES, CARD_IP, OLD_IP, SILO, DLUPNO,  TMP_DLUPNO,  HOST_PORT, WAN_CON, REMARKS, ADDED_BY)
select (ROWNUM+ (select max(TREC_ID) from TREC_NETWORK)) as  TREC_NETWORK_ID, a.TREC_ID, a.HUB_NO, a.PORT, a.FLOOR, a.IP_ADDRESS, a.CARD_IP, a.OLD_IP, a.SILO, a.DLUPNO,  a.TMPDLUPNO,  a.HOSTPORT, a.WANCON, a.NETREMARKS, 496 as ADDED_BY from
(
select  TO_NUMBER(MEM_NO) as TREC_ID, HUB_NO, PORT, FLOOR, IP_ADDRESS, CARD_IP, OLD_IP, SILO, DLUPNO, TMPDLUPNO, HOSTPORT, WANCON, NETREMARKS from TREC_NETWORK_BACKUP 
where  REGEXP_LIKE(MEM_NO, '^[0-9]+$') 
and TO_NUMBER(MEM_NO) NOT IN (select TREC_ID from TREC_NETWORK)
and TO_NUMBER(MEM_NO) IN (select TREC_ID from TREC)
order by TO_NUMBER(MEM_NO)

) a;

-- 11 rows inserted.
commit;



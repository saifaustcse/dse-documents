
-- MIS and Development
update USER_PROFILE set EMAIL='saiful.islam496@dse.com.bd' where USER_PROFILE_ID=496;
update USER_PROFILE set EMAIL='m.kamruzzaman@dse.com.bd' where USER_PROFILE_ID=52;
update USER_PROFILE set EMAIL='abdul.kader@dse.com.bd' where USER_PROFILE_ID=94;
update USER_PROFILE set EMAIL='golam.kibria@dse.com.bd' where USER_PROFILE_ID=108;
update USER_PROFILE set EMAIL='kamrul.hasan490@dse.com.bd' where USER_PROFILE_ID=490;
update USER_PROFILE set EMAIL='mahsin.kabir@dse.com.bd' where USER_PROFILE_ID=493;

-- TREC Affairs
update USER_PROFILE set EMAIL='haroon.pathan@dse.com.bd' where USER_PROFILE_ID=55;
update USER_PROFILE set EMAIL='delower.hossain@dse.com.bd' where USER_PROFILE_ID=58;
-- update USER_PROFILE set EMAIL='sm.shahidullah@dse.com.bd' where USER_PROFILE_ID=81;
update USER_PROFILE set EMAIL='rahim.bhuiyan@dse.com.bd' where USER_PROFILE_ID=111;
update USER_PROFILE set EMAIL='mannan.bashar@dse.com.bd' where USER_PROFILE_ID=114;
update USER_PROFILE set EMAIL='shazzad.hossain@dse.com.bd' where USER_PROFILE_ID=133;
update USER_PROFILE set EMAIL='matiur.rahman@dse.com.bd' where USER_PROFILE_ID=137;
update USER_PROFILE set EMAIL='manirul.islam@dse.com.bd' where USER_PROFILE_ID=138;
-- update USER_PROFILE set EMAIL='sahera.hoque@dse.com.bd' where USER_PROFILE_ID=144;
update USER_PROFILE set EMAIL='sahab.uddin@dse.com.bd' where USER_PROFILE_ID=181;
--update USER_PROFILE set EMAIL='sahab.uddin@dse.com.bd' where USER_PROFILE_ID=222;
update USER_PROFILE set EMAIL='tasneem.tabassum@dse.com.bd' where USER_PROFILE_ID=360;
update USER_PROFILE set EMAIL='mariwam.akter@dse.com.bd' where USER_PROFILE_ID=366;
update USER_PROFILE set EMAIL='nasrin.sultana@dse.com.bd' where USER_PROFILE_ID=524;

-- Application Support
update USER_PROFILE set EMAIL='ruhul.amin@dse.com.bd' where USER_PROFILE_ID=30;
update USER_PROFILE set EMAIL='mahmudul.hasan@dse.com.bd' where USER_PROFILE_ID=44;
update USER_PROFILE set EMAIL='makhdum.hossain@dse.com.bd' where USER_PROFILE_ID=46;
update USER_PROFILE set EMAIL='faysal.ibnekhair@dse.com.bd' where USER_PROFILE_ID=74;
update USER_PROFILE set EMAIL='meherab.ali@dse.com.bd' where USER_PROFILE_ID=90;
update USER_PROFILE set EMAIL='habib.nabi@dse.com.bd' where USER_PROFILE_ID=91;
update USER_PROFILE set EMAIL='arif.rahman@dse.com.bd' where USER_PROFILE_ID=100;

-- Network Development
update USER_PROFILE set EMAIL='eleas.hosain@dse.com.bd' where USER_PROFILE_ID=18;
update USER_PROFILE set EMAIL='syful.islam@dse.com.bd' where USER_PROFILE_ID=51;
update USER_PROFILE set EMAIL='sariful.islam@dse.com.bd' where USER_PROFILE_ID=63;
update USER_PROFILE set EMAIL='sm.bhayejid@dse.com.bd' where USER_PROFILE_ID=82;
-- update USER_PROFILE set EMAIL='marezul.kabir@dse.com.bd' where USER_PROFILE_ID=535;

-- Backoffice Development
-- update USER_PROFILE set EMAIL='raquib.uddin@dse.com.bd' where USER_PROFILE_ID=18;
-- update USER_PROFILE set EMAIL='nazmus.sakib@dse.com.bd' where USER_PROFILE_ID=446;
-- update USER_PROFILE set EMAIL='rajib.sarker@dse.com.bd' where USER_PROFILE_ID=451;
-- update USER_PROFILE set EMAIL='tanzin.kabir@dse.com.bd' where USER_PROFILE_ID=492;

-- Web Development
-- update USER_PROFILE set EMAIL='rezaur.rahman@dse.com.bd' where USER_PROFILE_ID=17;
-- update USER_PROFILE set EMAIL='farhana.sharifa@dse.com.bd' where USER_PROFILE_ID=27;
-- update USER_PROFILE set EMAIL='zahangir.alam@dse.com.bd' where USER_PROFILE_ID=72;
-- update USER_PROFILE set EMAIL='farjana.firoj@dse.com.bd' where USER_PROFILE_ID=414;

-- IT Infrastructure
-- update USER_PROFILE set EMAIL='hasan.ahmed@dse.com.bd' where USER_PROFILE_ID=93;
-- update USER_PROFILE set EMAIL='faiz.ahmed@dse.com.bd' where USER_PROFILE_ID=101;
-- update USER_PROFILE set EMAIL='ali.hossen@dse.com.bd' where USER_PROFILE_ID=296;
-- update USER_PROFILE set EMAIL='mahfuzul.islam@dse.com.bd' where USER_PROFILE_ID=303;
-- update USER_PROFILE set EMAIL='mustafijur.rahman@dse.com.bd' where USER_PROFILE_ID=440;
-- update USER_PROFILE set EMAIL='ariful.islam@dse.com.bd' where USER_PROFILE_ID=534;


-- IT Strategy and Security
-- update USER_PROFILE set EMAIL='arifur.rahman@dse.com.bd' where USER_PROFILE_ID=40;
-- update USER_PROFILE set EMAIL='khayrul.alam@dse.com.bd' where USER_PROFILE_ID=71;
-- update USER_PROFILE set EMAIL='imran.hosan@dse.com.bd' where USER_PROFILE_ID=453;

-- System and Market Administration
-- update USER_PROFILE set EMAIL='hasan.karim@dse.com.bd' where USER_PROFILE_ID=28;
-- update USER_PROFILE set EMAIL='jishan.hasan@dse.com.bd' where USER_PROFILE_ID=31;
update USER_PROFILE set EMAIL='sadat.hasnayen@dse.com.bd' where USER_PROFILE_ID=57;
-- update USER_PROFILE set EMAIL='rahat.ahmed@dse.com.bd' where USER_PROFILE_ID=107;
-- update USER_PROFILE set EMAIL='ahsanul.haque@dse.com.bd' where USER_PROFILE_ID=533;

commit;

select * from USER_CAT_HOMEPAGE;
update USER_CAT_HOMEPAGE set LINK= '/User/DashboardDse.aspx' where USER_CAT_ID=1;
update USER_CAT_HOMEPAGE set LINK= '/User/DashboardTrec.aspx' where USER_CAT_ID=2;
update USER_CAT_HOMEPAGE set LINK= '/User/DashboardBsec.aspx' where USER_CAT_ID=3;

select * from USER_HOMEPAGE;
update USER_HOMEPAGE set LINK= '/User/BlankPage.aspx';
--update USER_HOMEPAGE set LOGINID=52, LINK= '/Dashboards/BlankPage.aspx' where id=6;

commit;

-- update TBLUSERINFO set ISACTIVE='Y', STATUS='OPEN', PASSWORD_CHANGE_DATE='01-SEP-24', USERPASSWORD='MQ=='  where LOGINID in 
-- (
-- 496, 58, 81, 111, 114, 133, 137, 138, 144, 181, 222, 360, 366, 524, 30, 44, 46, 74, 90, 91, 100, 18, 51, 63, 419
-- );

-- update USER_PROFILE set STATUS='APPROVED' where USER_PROFILE_ID in (
-- 496, 58, 81, 111, 114, 133, 137, 138, 144, 181, 222, 360, 366, 524, 30, 44, 46, 74, 90, 91, 100, 18, 51, 63, 419
-- );

-- update TBLUSERINFO set ISACTIVE='N', STATUS='DELETED', PASSWORD_CHANGE_DATE='01-JAN-25' where LOGINID not in 
-- (
-- 496, 58, 81, 111, 114, 133, 137, 138, 144, 181, 222, 360, 366, 524, 30, 44, 46, 74, 90, 91, 100, 18, 51, 63, 419
-- );

-- update USER_PROFILE set STATUS='CLOSED' where USER_PROFILE_ID not in (
-- 496, 58, 81, 111, 114, 133, 137, 138, 144, 181, 222, 360, 366, 524, 30, 44, 46, 74, 90, 91, 100, 18, 51, 63, 419
-- );

commit;


select * from TBLUSERINFO where  ISACTIVE='Y' and STATUS='OPEN';
select * from USER_PROFILE where STATUS='APPROVED';

select * from TBLUSERINFO where LOGINID =  55 ; --1
select * from USER_PROFILE where USER_PROFILE_ID =  55 ; --1

update TBLUSERINFO set ISACTIVE='Y', STATUS='OPEN', PASSWORD_CHANGE_DATE='01-DEC-25', USERPASSWORD='MQ=='  where LOGINID =  55 ; --1
update USER_PROFILE set STATUS='APPROVED' where USER_PROFILE_ID = 55;

update TBLUSERINFO set ISACTIVE='Y', STATUS='OPEN', PASSWORD_CHANGE_DATE='01-AUG-25', USERPASSWORD='MTE='  where LOGINID in  --11
(
419
);

update USER_PROFILE set STATUS='APPROVED' where USER_PROFILE_ID in (
419
);

commit;
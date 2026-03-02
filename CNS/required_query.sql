-- BOID exists in cns from 10 Jun 2012

-- client code exists 28 February 2007

-- data exists in cns from 13-APR-06

-- foreign client exist from 11 Dec 2014

--------------------------------------- Renewal TREC affairs ----------------------------------------------------


select rownum as slno,b.* from (
select name||decode(memstatus,'A','',' (Inactive)') name,decode(type,'B','Broker','Dealer') as type,id,trec_code,to_char(last_tradedate,'dd/mm/yyyy') last_tradedate,decode(last_tradedate,null,to_char(last_tradedate_before,'dd/mm/yyyy'),null) last_tradedate_before from (
select membercode as trec_code,max(last_tradedate) as last_tradedate,max(last_tradedate_before) as last_tradedate_before from(
select membercode,max(tradedate) as last_tradedate,null as last_tradedate_before from payreceivablehistory where tradedate between '1-Jul-2022' and '1-Sep-2022' group by membercode
union all
select membercode,null as last_tradedate,max(tradedate) as last_tradedate_before from payreceivablehistory where tradedate< '1-Jul-2022'  group by membercode
) group by membercode) a,member m where a.trec_code=m.code  order by substr(lpad(to_char(id),6,'0'),4,6)
) b;

--------------------------------------- Monitoring(Trade status,on demand) ----------------------------------------------------


SELECT TO_CHAR(TRADEDATE,'dd/mm/yyyy') tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,buyerclient,boidbuyer,sellercode,sellerclient,boidseller
from(
select tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,buyerclient,boidbuyer,sellercode,sellerclient,boidseller
from tradehistory where isdeleted='N' and isinvalid='N' and tradedate between '01-Jan-2019' and '21-Apr-2019' and instrumentcode='DELTASPINN'
ORDER BY 1,2);

--------------------------------------- Monitoring(Trade status,on demand) if Tradedate include today ----------------------------------------------------

SELECT TO_CHAR(TRADEDATE,'dd/mm/yyyy') tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,buyerclient,boidbuyer,sellercode,sellerclient,boidseller
from(
select tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,buyerclient,boidbuyer,sellercode,sellerclient,boidseller
from tradedata where isdeleted='N' and isinvalid='N' and tradedate between '01-Jan-2018' and '21-Apr-2018' and instrumentcode='DELTASPINN'
ORDER BY 1,2);


--------------------------------------- IED (Trade status, on demand) for a boid of a broker/dealer with counter party ----------------------------------------------------

SELECT * FROM(
SELECT TO_CHAR(tradedate,'dd-Mon-yyyy') AS tradedate,tradetime,buyercode AS MEMBER,boidbuyer AS boid,buyerclient AS client,instrumentcode,
'Buy' AS buysell,sellercode AS counterMember,boidseller AS counterboid,tradevolume,tradeprice FROM tradehistory WHERE buyercode='DSEBRL' AND   boidbuyer='1205150004385698' AND instrumentcode='AIMS1STMF' AND  tradedate BETWEEN '01-Apr-2018' AND '30-Apr-2018' AND isinvalid='N' AND isdeleted='N'
UNION ALL
SELECT TO_CHAR(tradedate,'dd-Mon-yyyy') AS tradedate,tradetime,sellercode AS MEMBER,boidseller AS boid,sellerclient AS client,instrumentcode,'Sell' AS buysell,buyercode AS counterMEMBER,boidbuyer AS counterboid,tradevolume,tradeprice FROM tradehistory WHERE sellercode='DSEBDF' AND boidseller='1205150004385698' AND instrumentcode='AIMS1STMF'  AND tradedate BETWEEN '01-Apr-2018' AND  '30-Apr-2018' 
AND isinvalid='N' AND isdeleted='N')
ORDER BY TO_DATE(tradedate),tradetime;


--------------------------------------- IED (Trade status, on demand with markettype without buy sale tag ----------------------------------------------------

SELECT TO_CHAR(TRADEDATE,'dd/mm/yyyy') tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,
buyerclient,boidbuyer,sellercode,sellerclient,boidseller,markettype
from(
select tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,
buyerclient,boidbuyer,sellercode,sellerclient,boidseller,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '01-Dec-2016' AND '31-May-2017'  and instrumentcode='AGRANINS' 
and (boidbuyer='1201530000003501' or boidseller='1201530000003501')
ORDER BY 1,2);

---------------------------------------IED (Trade status, on demand with markettype) ----------------------------------------------------

SELECT TO_CHAR(TRADEDATE,'dd/mm/yyyy') tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,
buyerclient,boidbuyer,sellercode,sellerclient,boidseller,markettype
from(
select tradedate,tradetime,instrumentcode,tradevolume,tradeprice,buyercode,
buyerclient,boidbuyer,sellercode,sellerclient,boidseller,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '21-Jul-2019' and '29-Aug-2019' and instrumentcode='MONNOSTAF'
ORDER BY 1,2)

---------------------------------------With Howlano ----------------------------------------------------

SELECT TO_CHAR(TRADEDATE,'dd/mm/yyyy') tradedate,tradetime,howlano,instrumentcode,tradevolume,tradeprice,buyercode,
buyerclient,boidbuyer,sellercode,sellerclient,boidseller,markettype
from(
select tradedate,tradetime,howlano,instrumentcode,tradevolume,tradeprice,buyercode,
buyerclient,boidbuyer,sellercode,sellerclient,boidseller,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '26-Aug-2020' and '21-Jan-2021' and instrumentcode='ACFL'
ORDER BY 1,2,3)



-- Query for Block trade check


select * from TRADEHISTORY where tradedate between 
'9-Jun-2019' and '30-Jun-2019' and instrumentcode='LIBRAINFU' and markettype='B';

select * from TRADEHISTORY where tradedate between 
'9-Jun-2019' and '30-Jun-2019' and instrumentcode='LIBRAINFU' and markettype='S'
and compulsoryspot='B';

---------------------------------------IED (on demand) for a boid of a broker/dealer with counter party with market type) ----------------------------------------------------

SELECT * FROM(
SELECT TO_CHAR(tradedate,'dd-Mon-yyyy') AS tradedate,tradetime,buyercode AS MEMBER,boidbuyer AS boid,buyerclient AS client,
instrumentcode,
'Buy' AS buysell,sellercode AS counterMember,boidseller AS counterboid,tradevolume,tradeprice,case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype 
FROM tradehistory WHERE boidbuyer='1201530000003501' and 
instrumentcode='REPUBLIC' AND  tradedate BETWEEN '01-Dec-2016' AND '31-May-2017' AND isinvalid='N' AND isdeleted='N'
UNION ALL
SELECT TO_CHAR(tradedate,'dd-Mon-yyyy') AS tradedate,tradetime,sellercode AS MEMBER,boidseller AS boid,sellerclient AS client,
instrumentcode,
'Sell' AS buysell,buyercode AS counterMEMBER,boidbuyer AS counterboid,tradevolume,tradeprice,case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype 
FROM tradehistory WHERE  boidseller='1201530000003501' and 
instrumentcode='REPUBLIC'  AND tradedate BETWEEN '01-Dec-2016' AND '31-May-2017' 
AND isinvalid='N' AND isdeleted='N')
ORDER BY TO_DATE(tradedate),tradetime;

---------------------------------------Foreign Weekly Data (mail:afzal.rahman@dse.com.bd, zinnat.ferdous@dse.com.bd ) ----------------------------------------------------

select trdate, buy, sell, (buy+sell) as turnover, (buy-sell) as netbuysell from(
                select trdate, SUM(buyonly) buy, SUM(sellonly) sell from(
                                SELECT TO_CHAR(tradedate,'yyyy-mm-dd') AS trdate, SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE tradedate BETWEEN '11-Sep-2022' AND '15-Sep-2022'
                                AND
                                ( SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
                               
        AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'yyyy-mm-dd')
 
                                UNION ALL
 
                                SELECT TO_CHAR(tradedate,'yyyy-mm-dd') AS trdate, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE tradedate BETWEEN '11-Sep-2022' AND '15-Sep-2022'
                                AND
                                ( SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'yyyy-mm-dd')
                ) group by trdate
) order by trdate ASC


---------------------------------------Pakkhik pujibazar ----------------------------------------------------

select i.id,a.* from (
select to_char(tradedate,'yyyy-mm') as month , instrumentcode,sum(trdvol) as tradevolume,sum(turnover) as VALUE,sum(howla) as noofhowla,
COUNT(DISTINCT TRADEDATE) AS TRADINGDAY from tradecloseprice
where tradedate between '1-Aug-2021' and '15-Aug-2021'
AND TRDVOL IS NOT NULL
group by  to_char(tradedate,'yyyy-mm') ,instrumentcode) a,instrument i
where i.code=a.instrumentcode ORDER BY instrumentcode


select i.id,a.* from (
select to_char(tradedate,'yyyy-mm') as month , instrumentcode,sum(trdvol) as tradevolume,sum(turnover) as VALUE,sum(howla) as noofhowla,
COUNT(DISTINCT TRADEDATE) AS TRADINGDAY from tradecloseprice
where tradedate between '1-Jul-2022' and '15-Jul-2022'
AND TRDVOL IS NOT NULL
group by  to_char(tradedate,'yyyy-mm') ,instrumentcode) a,instrument i
where i.code=a.instrumentcode ORDER BY instrumentcode


-- verification of tading day

select  distinct tradedate from TRADEHISTORY where INSTRUMENTCODE='AIBL1STIMF'
and tradedate between '1-Dec-2018' and '15-Dec-2018' order by tradedate;
  

select count(distinct tradedate) as nooftradingday from TRADEHISTORY where INSTRUMENTCODE='AIBL1STIMF'
and tradedate between '1-Dec-2018' and '15-Dec-2018' order by tradedate;


---------------------------------------CNS theke Client Type wise trade statistics ber kora (For mamun vi) ----------------------------------------------------


select title,buyamount,round((buyamount/totalbuyamount)*100,2) "BUY %",sellamount saleamount,round((sellamount/totalsellamount)*100,2) "SALE %" from (
select title,buyamount,sellamount,totalbuyamount,totalsellamount from (
select title,sum(buyamount) buyamount,sum(sellamount) sellamount from mis_data where tradedate between '23-Oct-2022' and '20-Nov-2022' and type='c'
group by title)a, (select sum(buyamount) totalbuyamount,sum(sellamount) totalsellamount from mis_data where tradedate between '23-Oct-2022' and '20-Nov-2022' and type='c'))d
order by title;


---------------------------------------Mobile trade data (it has been integrated in CNS in send mobile data)----------------------------------------------------


select a.tradedate,buyamount as buy,round(buyamount/total*100,2) as "BUY %",sellamount as sell,round(sellamount/total*100,2) as "SELL %" from(
select tradedate,buyamount,sellamount from mis_data where tradedate='01-Nov-2021' and type='p' and title='Mobile') a,
(select tradedate,sum(buyprice) as total from payreceivable where tradedate='01-Nov-2021' group by tradedate) b where
a.tradedate=b.tradedate order by tradedate;


---------------------------------------High-Low-deviation price of instrument within a date range----------------------------------------------------


SELECT d.*,max(e.tradedate) AS lowdate FROM tradehistory e,
(SELECT c.*,max(b.tradedate) AS highdate FROM tradehistory b,
(select 'Jan2009-Dec,2011' as duration,i.id,i.CODE,a.tradedday,a.noofhowla,a.value,a.highprice,a.lowprice,a.highprice-a.lowprice as deviation from instrument i,
(select instrumentcode,count(distinct tradedate) as tradedday,sum(tradevolume) as noofshare,sum(tradeprice*tradevolume) as value,
count(*) as noofhowla,max(tradeprice) as highprice,min(tradeprice) as lowprice
from tradehistory
where isinvalid='N' and isdeleted='N' and tradedate between '01-Jan-2009' and '31-Dec-2011'
group by instrumentcode) a
where i.CODE=a.instrumentcode) c
WHERE c.code=b.INSTRUMENTCODE AND c.highprice=b.tradeprice and b.tradedate between '01-Jan-2009' and '31-Dec-2011'
group by duration,id,CODE,tradedday,noofhowla,noofshare,value,highprice,lowprice,deviation) d
WHERE d.code=e.INSTRUMENTCODE AND d.lowprice=e.tradeprice and e.tradedate between '01-Jan-2009' and '31-Dec-2011'
group by duration,id,CODE,tradedday,noofhowla,noofshare,value,highprice,lowprice,deviation,highdate
order by 2


-------------------------------------------------------------------------------------------
                                --RNI DATA
-------------------------------------------------------------------------------------------

--------------Percentage of trade value by top 20 brokers (monthly basis for 2020) mailed on 5.01.2021 from afzal vi---------------------------

select rownum as rank,x.* from (
select id,name,tradedate,brokerturnover ,totalturnover,round((brokerturnover /totalturnover)*100,2) as percent from(
select id,name,tradedate,brokerturnover from(

select to_char(tradedate,'Mon-yyyy') as tradedate,substr(membercode,4.6) as code,sum(buyprice+sellprice)/2 as brokerturnover
from payreceivablehistory where
to_char(tradedate,'mm-yyyy')='12-2020' group by substr(membercode,4.6),to_char(tradedate,'Mon-yyyy')

) a,member b where b.code = 'DSE'||a.code and b.ID<>333 order by 3 desc)c,(select sum(buyprice+sellprice)/2 as totalturnover from
payreceivablehistory where
to_char(tradedate,'mm-yyyy')='12-2020')d order by brokerturnover desc) x where rownum <=20

--------------Breakdown of percentage of trade value by institutional and retail clients (monthly basis for 2020)---------------------------


select a.tradedate,Investor,buyvalue,sellvalue,turnover,totturnover,round((turnover/totturnover)*100,2) as "%To Total" from(
select tradedate, type as Investor,buyvalue,sellvalue,(buyvalue+sellvalue)/2 as turnover
                         from(
                         select tradedate, decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O',
                         'Others','R','NRB','-') as type,
                         round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue from(
                         select to_char(tradedate,'Mon-yyyy') as tradedate, frbuyer as type,
                         sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue
                         from tradehistory where
                         tradedate between '1-Jan-2020' and '31-Dec-2020' and isinvalid='N' group by frbuyer,                         
                         buyercode||buyerclient,to_char(tradedate,'Mon-yyyy')
                         union all
                         select to_char(tradedate,'Mon-yyyy') as tradedate, frseller as type,0 as buvalue,
                         sum(tradeprice*tradevolume) as sellvalue from tradehistory where tradedate between '1-Jan-2020' and '31-Dec-2020' and
                         isinvalid='N' group by frseller,sellercode||sellerclient,to_char(tradedate,'Mon-yyyy')
                         ) where type in ('I','N') group by type,tradedate) order by tradedate,investor)a,                         
                         (select to_char(tradedate,'Mon-yyyy') as tradedate,sum(buyprice+sellprice)/2  as totturnover
from PAYRECEIVABLEHISTORY where  tradedate between '1-Jan-2020' and '31-Dec-2020' group by to_char(tradedate,'Mon-yyyy'))b
where a.tradedate=b.tradedate order by tradedate,investor


--------------Afzal vi data (cns mail dailybasis)---------------------------


select tradedate, type as Investor,buyvalue,sellvalue
                         from(
                         select tradedate, decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O',
                         'Others','R','NRB','-') as type,
                         round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue from(
                         select tradedate, frbuyer as type,
                         sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue
                         from tradehistory where
                         tradedate between '1-Jan-2021' and '31-Oct-2021' and isinvalid='N' group by frbuyer,                         
                         buyercode||buyerclient,tradedate
                         union all
                         select tradedate, frseller as type,0 as buvalue,
                         sum(tradeprice*tradevolume) as sellvalue from tradehistory where tradedate 
                         between '1-Jan-2021' and '31-Oct-2021' and
                         isinvalid='N' group by frseller,sellercode||sellerclient,tradedate
                         ) group by type,tradedate) order by tradedate,investor;


--------------Client Type wise details (no need to check))---------------------------

select clienttype,"Avg Daily Buy","Buy%","Avg Daily Sale","Sale%","Avg Daily Turnover",round(("Avg Daily Turnover"/"Avg Daily Total Turnover")*100,2)
as "Turnover%","Avg Daily Distinct Client" from(
select clienttype,buyvalue,round((buyvalue/NoofTradeDate),2)as "Avg Daily Buy","Buy%",sellvalue,
round((sellvalue/NoofTradeDate),2)as "Avg Daily Sale",
"Sale%",round((turnover/NoofTradeDate),2) as "Avg Daily Turnover",round((totturnover/NoofTradeDate),2) as 
"Avg Daily Total Turnover",client,round((client/NoofTradeDate),0) as "Avg Daily Distinct Client" from(
select clienttype,buyvalue,sellvalue,turnover,totalbuyvalue,totalsellvalue,totturnover,"Buy%","Sale%",
round((turnover/totturnover)*100,2) as "Turnover%",
client,NoofTradeDate from(
select clienttype,buyvalue,sellvalue,(buyvalue+sellvalue)as turnover,totalbuyvalue,totalsellvalue,totturnover,
round((buyvalue/totalbuyvalue)*100,2) as "Buy%",round((sellvalue/totalsellvalue)*100,2) as "Sale%",
client from(
select type as clienttype,sum(buyvalue) as buyvalue,sum(sellvalue) as sellvalue,
sum(client) as client from( 
select tradedate,decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O','Others','R','NRB','-') as type,
count(distinct client) as client,sum(buyhowla) as buyhowla,sum(sellhowla) as sellhowla,sum(buyvolume) as buyvolume,sum(sellvolume) as sellvolume,
round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue,round(sum(buytrancharge+selltrancharge),2) as transaction_charge from( 
select tradedate,frbuyer as type,buyercode||buyerclient as client,count(*) as buyhowla,0 as sellhowla,sum(tradevolume) as buyvolume,0 as sellvolume,
sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue,sum(buylagacharge+howlacharge) as buytrancharge,0 as selltrancharge 
from tradehistory where tradedate between '01-Jan-2016' and '31-Dec-2020' and isinvalid='N' group by tradedate,frbuyer,buyercode||buyerclient 
union all 
select tradedate,frseller as type,sellercode||sellerclient as client,0 as buyhowla,count(*) as sellhowla,0 as buyvolume,sum(tradevolume) as sellvolume,
0 as buvalue,sum(tradeprice*tradevolume) as sellvalue,0 as buytrancharge,sum(selllagacharge+howlacharge) as selltrancharge 
from tradehistory 
where tradedate between '01-Jan-2016' and '31-Dec-2020' and isinvalid='N' group by tradedate,frseller,sellercode||sellerclient ) group by 
tradedate,type order by tradedate)a group by type)a,
(select sum(buyprice) as totalbuyvalue,sum(sellprice)as totalsellvalue,sum(buyprice+sellprice)  as totturnover
from payreceivablehistory where  tradedate between '01-Jan-2016' and '31-Dec-2020')b)c,
(select count(distinct tradedate) as NoofTradeDate from payreceivablehistory where tradedate between '01-Jan-2016' and '31-Dec-2020')d)e);


--------------Afzal vi Data---------------------------

-- Listed Securities’ Daily Trading Market Data____2014 - 2019 

select t.TRADEDATE,
i.id as COMID,
decode(t.LOWPRC,null,0,t.LOWPRC) AS LOWPRC,
decode(t.HIPRC,null,0,t.HIPRC) AS HIPRC,
decode(t.AVGPRC,null,0,t.AVGPRC) AS AVGPRC,
decode(t.WTAVGPRC,null,0,t.WTAVGPRC) AS WTAVGPRC,
decode(t.TRADECLOSEPRICE,null,0,t.TRADECLOSEPRICE) AS CLSPRC,
decode(t.HOWLA,null,0,t.HOWLA) AS TRDNO,
decode(t.TURNOVER,null,0,t.TURNOVER) AS TURNOVER,
i.name as CompanyName,
CASE 
WHEN TRDVOL is NULL THEN 'Not Traded'
ELSE 'Traded'
END Status from tradecloseprice t inner join instrument i on
i.CODE=t.INSTRUMENTCODE
where tradedate>= TO_DATE('1-1-2014','dd-mm-yyyy') AND tradedate< TO_DATE('30-11-2019','dd-mm-yyyy') 
and i.SECTORID not in (88,91) order by t.TRADEDATE,i.CODE;


--------------Weekly RNI ---------------------------

CREATE OR REPLACE VIEW histdatavu AS SELECT t.OBLIGATIONID,
t.TRANSACTIONID,
t.HOWLANO,
t.INSTRUMENTCODE,
t.MARKETTYPE,
case t.markettype
when 'P' then 'Public'
when 'S' then case when t.compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end as TypeofMarket,
t.TRADEDATE,
t.TRADETIME,
t.TRADEPRICE,
t.TRADEVOLUME,
t.BUYERCODE,
t.SELLERCODE,
t.TRADECROSSING,
t.BUYERTRANSID,
t.SELLERTRANSID,
t.HOWLATYPE,
t.HOWLACHARGE,
t.LAGACHARGE,
t.ISEXCEPTION,
t.PAYIN,
t.PAYOUT,
t.GROUPCODE,
t.NETTING,
t.ISDELETED,
t.ISINVALID,
t.ISDEMATTED,
t.TAX,
t.COMPULSORYSPOT,
t.BUYERCLIENT,
t.SELLERCLIENT,
t.BOIDBUYER,
t.BOIDSELLER,
t.FRBUYER,
t.FRSELLER,
t.SCRIPPAYIN,
t.SCRIPPAYOUT,
t.BUYLAGACHARGE,
t.SELLLAGACHARGE,
t.SOURCEBUYER,
t.SOURCESELLER
, i.id AS comid,i.instrumenttype,i.name,
c.tradecloseprice AS clsprc FROM tradedata t,
instrument i,tradecloseprice c WHERE
t.instrumentcode=i.code AND c.INSTRUMENTCODE=t.instrumentcode AND
c.tradedate=t.tradedate AND  t.tradedate>= TO_DATE('11-09-2022','dd-mm-yyyy')
AND t.tradedate<= TO_DATE('15-09-2022','dd-mm-yyyy');




SELECT TO_CHAR(tradedate,'dd-mm-yyyy') AS tradedate,comid,MIN(tradeprice) AS lowprc,MAX(tradeprice) AS hiprc,ROUND(AVG(tradeprice),2) AS avgprc,
ROUND(sum(tradevolume*tradeprice)/sum(tradevolume),2) AS wtavgprc,
ROUND(AVG(clsprc),2) AS clsprc,COUNT(*) AS trdno,SUM(tradevolume) AS trdvol,SUM(tradevolume*tradeprice) AS turnover,
name AS companyname,TypeofMarket FROM histdatavu  GROUP BY tradedate,comid,name,TypeofMarket order by tradedate,comid;


SELECT comid,MIN(tradeprice) AS lowprc,MAX(tradeprice) AS hiprc,
name AS companyname,TypeofMarket FROM histdatavu  
GROUP BY comid,name,TypeofMarket order by comid;


drop view histdatavu;


-------------- Monthly rni query (using toad)---------------------------


CREATE OR REPLACE VIEW histdatavu AS SELECT t.*, i.id AS comid,i.instrumenttype,c.issuedshare,i.name,
c.tradecloseprice AS clsprc FROM tradedata t, 
instrument i,tradecloseprice c WHERE 
t.instrumentcode=i.code AND c.INSTRUMENTCODE=t.instrumentcode AND 
c.tradedate=t.tradedate AND  t.tradedate>= TO_DATE('01-04-2020','dd-mm-yyyy') AND t.tradedate< TO_DATE('01-05-2020','dd-mm-yyyy') ;

SELECT TO_CHAR(tradedate,'dd-mm-yyyy') AS tradedate,comid,MIN(tradeprice) AS lowprc,MAX(tradeprice) AS hiprc,ROUND(AVG(tradeprice),2) AS avgprc,
ROUND(sum(tradevolume*tradeprice)/sum(tradevolume),2) AS wtavgprc,
ROUND(AVG(clsprc),2) AS clsprc,COUNT(*) AS trdno,SUM(tradevolume) AS trdvol,SUM(tradevolume*tradeprice) AS turnover,
name AS companyname FROM histdatavu  GROUP BY tradedate,comid,name order by tradedate,comid;

drop view histdatavu;


-- This data is given through email
-------------- monthly rni (only for ied) query (using toad) ---------------------------
-- if data is older than 2 month then we must use tradehistory table instead of tradedata
-- souzia.afrin@dse.com.bd;
-- training@dse.com.bd;


CREATE OR REPLACE VIEW histdatavu AS SELECT t.OBLIGATIONID,
t.TRANSACTIONID,
t.HOWLANO,
t.INSTRUMENTCODE,
t.MARKETTYPE,
case t.markettype
when 'P' then 'Public'
when 'S' then case when t.compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end as TypeofMarket,
t.TRADEDATE,
t.TRADETIME,
t.TRADEPRICE,
t.TRADEVOLUME,
t.BUYERCODE,
t.SELLERCODE,
t.TRADECROSSING,
t.BUYERTRANSID,
t.SELLERTRANSID,
t.HOWLATYPE,
t.HOWLACHARGE,
t.LAGACHARGE,
t.ISEXCEPTION,
t.PAYIN,
t.PAYOUT,
t.GROUPCODE,
t.NETTING,
t.ISDELETED,
t.ISINVALID,
t.ISDEMATTED,
t.TAX,
t.COMPULSORYSPOT,
t.BUYERCLIENT,
t.SELLERCLIENT,
t.BOIDBUYER,
t.BOIDSELLER,
t.FRBUYER,
t.FRSELLER,
t.SCRIPPAYIN,
t.SCRIPPAYOUT,
t.BUYLAGACHARGE,
t.SELLLAGACHARGE,
t.SOURCEBUYER,
t.SOURCESELLER
, i.id AS comid,i.instrumenttype,i.name,
c.tradecloseprice AS clsprc FROM tradedata t,
instrument i,tradecloseprice c WHERE
t.instrumentcode=i.code AND c.INSTRUMENTCODE=t.instrumentcode AND
c.tradedate=t.tradedate AND  t.tradedate>= TO_DATE('01-09-2019','dd-mm-yyyy') 
AND t.tradedate< TO_DATE('01-10-2019','dd-mm-yyyy');


SELECT TO_CHAR(tradedate,'dd-mm-yyyy') AS tradedate,comid,MIN(tradeprice) AS lowprc,MAX(tradeprice) AS hiprc,ROUND(AVG(tradeprice),2) AS avgprc,
ROUND(sum(tradevolume*tradeprice)/sum(tradevolume),2) AS wtavgprc,
ROUND(AVG(clsprc),2) AS clsprc,COUNT(*) AS trdno,SUM(tradevolume) AS trdvol,SUM(tradevolume*tradeprice) AS turnover,
name AS companyname,TypeofMarket FROM histdatavu  GROUP BY tradedate,comid,name,TypeofMarket order by tradedate,comid;


drop view histdatavu;


-------------- Investor update query in CNS---------------------------


UPDATE INST_CLIENT SET ISDELETED='Y' WHERE MEMBERCODe='LRK';
COMMIT;


INSERT INTO INST_CLIENT (id,membercode,clientcode,boid,isdeleted,entry_datetime)
SELECT rownum+(select max(id) from INST_CLIENT) id,'EBS',clientcode,boid,'N',SYSDATE from INST_CLIENT where membercode='LRK'; 
COMMIT;


-------------- Monthly Performance Data---------------------------

-- ALL TREC

SELECT ROWNUM AS SLNO,A.* FROM (
select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY" from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivable where tradedate
between '01-Sep-2020' and '30-Sep-2020' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<>333  ORDER BY TURNOVER DESC
) A


-- Broker

SELECT ROWNUM AS SLNO,A.* FROM (
select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY" from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivable
where tradedate between '01-Sep-2020' and '30-Sep-2020' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<333  ORDER BY TURNOVER DESC
) A

-- Dealer

SELECT ROWNUM AS SLNO,A.* FROM (
select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY" from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivable where tradedate
between '01-Nov-2020' and '30-Nov-2020' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id>333  ORDER BY TURNOVER DESC
) A


--Instrument

select  month,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select to_char(tradedate,'MON--YYYY') AS MONTH, instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where to_char(tradedate,'yyyy-mm')= '2020-09' ))*100,4) as percent_tot from tradecloseprice
where to_char(tradedate,'yyyy-mm')= '2020-09' and trdvol<>0 group by to_char(tradedate,'MON--YYYY'), instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id order by i.name



--New code for instrument without SCP


select  month,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select to_char(tradedate,'MON--YYYY') AS MONTH, instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where to_char(tradedate,'yyyy-mm')= '2021-09' and groupcode<>'S' ))*100,4) as percent_tot from tradecloseprice
where to_char(tradedate,'yyyy-mm')= '2021-09' and trdvol<>0 and groupcode<>'S' group by to_char(tradedate,'MON--YYYY'), instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id order by i.name;


-------------- Performance New code---------------------------

SELECT ROWNUM AS SLNO,id,"NAME OF THE MEMBER'S COMPANY" FROM (
select x.id,decode(x.type,'B',x.id||' ','')||x.name||decode(x.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",turnover from (
select id,sum(turnover) turnover from(
select m.id,n.code,name,turnover from(
select membercode as code,sum((buyprice+sellprice)) as turnover from payreceivable where tradedate
between '01-Oct-2022' and '31-Oct-2022' group by membercode)n, member m where
n.code=m.code and m.id<>333) group by id)y, member x where
y.id=x.id and y.id<>333 and x.memstatus='A' order by turnover desc)g



-- Instrument:

select  month,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select to_char(tradedate,'MON--YYYY') AS MONTH, instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where to_char(tradedate,'yyyy-mm')= '2022-10' and groupcode<>'S' ))*100,4) as percent_tot from tradecloseprice
where to_char(tradedate,'yyyy-mm')= '2022-10' and trdvol<>0 and groupcode<>'S' group by to_char(tradedate,'MON--YYYY'), instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id and i.status=1 order by i.id


------------------------------------------------------------------
                    --6 month or year end data
------------------------------------------------------------------

-- 1. All TREC, ONLY BROKER AND ONLY DEALER PERFORMANCE WILL TAKE FROM CNS SOFTWARE

--------------------------------------All Instrument Performance yearly and half yearly ------------------------------------

select 'FY 2022-23' AS year,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where tradedate between '01-Jul-2022' and '30-Jun-2023' ))*100,4) as percent_tot from tradecloseprice
where tradedate between '01-Jul-2022' and '30-Jun-2023' and trdvol<>0  group by instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id and s.name not in ('BOND') order by i.name;


select 'FY Jan-Jun-2023' AS year,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where tradedate between '01-Jan-2023' and '30-Jun-2023' ))*100,4) as percent_tot from tradecloseprice
where tradedate between '01-Jan-2023' and '30-Jun-2023' and trdvol<>0  group by instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id and s.name not in ('BOND') order by i.name;



--------------------------------------Instrument Performance yearly and half yearly (withou SME and ATB)--------------------------------------

select 'FY 2022-23' AS year,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where tradedate between '01-Jul-2022' and '30-Jun-2023' and groupcode not in ('S','P')))*100,4) as percent_tot from tradecloseprice
where tradedate between '01-Jul-2022' and '30-Jun-2023' and trdvol<>0 and groupcode not in ('S','P') group by instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id and s.name not in ('BOND') order by i.name;


select 'FY Jan-Jun-2023' AS year,i.id as comid,i.name as cname,total_sr,total_tk,percent_tot,total_howla,s.name as sectorname from(
select instrumentcode,sum(trdvol) as total_sr,sum(turnover) as total_tk,sum(howla) as total_howla,
round((sum(turnover)/(select sum(turnover) from tradecloseprice where tradedate between '01-Jan-2023' and '30-Jun-2023' and groupcode not in ('S','P')))*100,4) as percent_tot from tradecloseprice
where tradedate between '01-Jan-2023' and '30-Jun-2023' and trdvol<>0 and groupcode not in ('S','P') group by instrumentcode
) a,instrument i,sector s where a.instrumentcode=i.code and i.sectorid=s.id and s.name not in ('BOND') order by i.name;



------------------------------------Yearly RNI Data------------------------

CREATE OR REPLACE VIEW histdatavu AS SELECT t.*, i.id AS comid,i.instrumenttype,c.issuedshare,i.name,
c.tradecloseprice AS clsprc FROM tradehistory t, 
instrument i,tradecloseprice c WHERE 
t.instrumentcode=i.code AND c.INSTRUMENTCODE=t.instrumentcode AND 
c.tradedate=t.tradedate AND  t.tradedate>= TO_DATE('01-07-2022','dd-mm-yyyy') AND t.tradedate< TO_DATE('01-07-2023','dd-mm-yyyy') ;

SELECT TO_CHAR(tradedate,'dd-mm-yyyy') AS tradedate,comid,MIN(tradeprice) AS lowprc,MAX(tradeprice) AS hiprc,ROUND(AVG(tradeprice),2) AS avgprc,
ROUND(sum(tradevolume*tradeprice)/sum(tradevolume),2) AS wtavgprc,
ROUND(AVG(clsprc),2) AS clsprc,COUNT(*) AS trdno,SUM(tradevolume) AS trdvol,SUM(tradevolume*tradeprice) AS turnover,
issuedshare,name AS companyname FROM histdatavu  GROUP BY tradedate,comid,name,issuedshare order by tradedate,comid;

drop view histdatavu ;


------------------------------------------------------------------
                    --6 month or year end data end
------------------------------------------------------------------
-- Query for IPO History (from tradecloseprice but it does not give actual result always)

select k.*,lasttradedate,lasttradecloseprice,ltradedatehowla,ltradedatetrdvol,ltradedateturnover from 

(select j.*,lt.lowpricedate,lt.lowprice,lowprcdatehowla,lowprcdatetrdvol,lowprcdateturnover from 
(
select g.*,ht.highpricedate,ht.highprice,hprcdatehowla,hprcdatetrdvol,hprcdateturnover from 
(
select f.*,tradecloseprice,decode(howla,NULL,'Not Found',howla) as ftradedatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
ftradedatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  ftradedateturnover from 
(
select t.INSTRUMENTCODE,name,min(tradedate) as firsttradedate  from tradecloseprice t,instrument i 
where i.code=t.instrumentcode and 
tradecloseprice is not null and  tradedate>='1-Jan-2009' and instrumenttype in ('DB','EQ','MF','CB') group by 
t.INSTRUMENTCODE,instrumenttype,name) f, tradecloseprice tc where tc.instrumentcode=f.INSTRUMENTCODE
and tc. tradedate=f.firsttradedate order by firsttradedate
) g, 
(select h.*,tradedate as highpricedate,decode(howla,NULL,'Not Found',howla) as hprcdatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
hprcdatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  hprcdateturnover from 
(
select instrumentcode,max(hiprc) as highprice from tradecloseprice where tradedate>='1-Jan-2009' group by instrumentcode
)h, TRADECLOSEPRICE td where td.instrumentcode=h.instrumentcode
and td.hiprc=h.highprice) ht where ht.instrumentcode=g.instrumentcode
)j,
(select l.*,tradedate as lowpricedate,decode(howla,NULL,'Not Found',howla) as lowprcdatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
lowprcdatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  lowprcdateturnover from 
(
select instrumentcode,min(lowprc) as lowprice from tradecloseprice where tradedate>='1-Jan-2009' group by instrumentcode
)l, TRADECLOSEPRICE td where td.instrumentcode=l.instrumentcode
and td.lowprc=l.lowprice) lt where lt.instrumentcode=j.instrumentcode)k,
(select lt.*,tradecloseprice as lasttradecloseprice,decode(howla,NULL,'Not Found',howla) as ltradedatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
ltradedatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  ltradedateturnover from 
(
select instrumentcode,max(tradedate) as lasttradedate from tradecloseprice 
where tradedate>='1-Jan-2009' and tradecloseprice is not null
group by instrumentcode)lt, tradecloseprice td3 where  td3.instrumentcode=lt.instrumentcode
and td3.tradedate=lt.lasttradedate) m where m.instrumentcode=k.instrumentcode order by k.instrumentcode;

----------------------------Index Rebalance Query for rnd--------------------------------------

select i.id,a.* from (select month,instrumentcode,sum(tradevolume) as tradevolume,sum(value) as
value,count(distinct tradedate) as tradingday from (select to_char(tradedate,'Mon-yyyy')
month,tradedate,tradeprice,howlano,instrumentcode,tradevolume,tradevolume*tradeprice as value from tradehistory 
where tradedate between '01-Jan-2018' and '31-Mar-2018' and isinvalid='N'
and isdeleted='N')group by month,instrumentcode) a,instrument i where i.code=a.instrumentcode

----------------------------Index Rebalance Query for rnd(with Howla)--------------------------------------

select i.id,a.* from (select month,instrumentcode,sum(tradevolume) as tradevolume,sum(value) as
value,count(distinct tradedate) as tradingday,count(*) as noofhowla from (select to_char(tradedate,'Mon-yyyy')
month,tradedate,tradeprice,howlano,instrumentcode,tradevolume,tradevolume*tradeprice as value from 
tradehistory where tradedate between '01-Jan-2021' and '31-Jan-2021' and isinvalid='N'
and isdeleted='N')group by month,instrumentcode) a,instrument i where i.code=a.instrumentcode


----------------------------Index Rebalance Query for rnd(with Howla)combinedly--------------------------------------


select i.id,a.* from (select instrumentcode,sum(tradevolume) as tradevolume,sum(value) as
value,count(distinct tradedate) as tradingday,count(*) as noofhowla from (select to_char(tradedate,'Mon-yyyy')
month,tradedate,tradeprice,howlano,instrumentcode,tradevolume,tradevolume*tradeprice as value from 
tradehistory where tradedate between '01-Jul-2021' and '31-Dec-2021' and isinvalid='N'
and isdeleted='N')group by instrumentcode) a,instrument i where i.code=a.instrumentcode order by id

----------------------------Index Rebalance with avg value and market type--------------------------------------

select i.id,a.* from (select duration,instrumentcode,tradevolume,value,tradingday,round((value/tradingday),2) as AvgValue from 
(select 'Apr-Jun,2022' as duration,instrumentcode,sum(tradevolume) as tradevolume,sum(value) as
value,count(distinct tradedate) as tradingday from (select to_char(tradedate,'Mon-yyyy')
month,tradedate,tradeprice,howlano,instrumentcode,tradevolume,tradevolume*tradeprice as value from tradehistory 
where tradedate between '01-Apr-2022' and '29-Jun-2022' and isinvalid='N'
and isdeleted='N' 
union all
select  to_char(tradedate,'Mon-yyyy')
month,tradedate,tradeprice,howlano,instrumentcode,tradevolume,tradevolume*tradeprice as value from tradedata 
where tradedate between '30-Jun-2022' and '30-Jun-2022' and isinvalid='N'
and isdeleted='N' 

)group by instrumentcode)c) a,instrument i where i.code=a.instrumentcode
and board_type='M' order by board_type,id;

----------------------------RNI Yearly Median Query--------------------------------------

select b.id as "Scrip Code",c.instrumentcode as "Trading Code","Security Name",b.tradingday as "NumberofTradingDays",
b.value as "TotalTradedValue",c.median,c.tradecloseprice as "ClosingPric",
c.tradedate as "DateoftheclosingPrice" from 
(
select i.instrumentcode,i.median,TO_CHAR(a.tradedate,'dd-mm-yyyy') as tradedate ,tradecloseprice from (
select tradedate,instrumentcode,tradecloseprice from tradecloseprice tc where tradedate=(select max(tradedate) from tradecloseprice
where instrumentcode=tc.instrumentcode and tradedate between
'01-Jan-2017' and '31-Dec-2017')
)a,(
select instrumentcode,median(value) as median from 
(
select tradedate,instrumentcode,sum(TRADEVOLUME*tradeprice) as value from tradehistory where tradedate between
'01-Jan-2017' and '31-Dec-2017' group by instrumentcode,tradedate
)group by instrumentcode) i where i.instrumentcode=a.instrumentcode
)c,
(
select i.id,i.name as "Security Name",d.* from (select instrumentcode,sum(tradevolume) as tradevolume,sum(value) as
value,count(distinct tradedate) as tradingday from (select to_char(tradedate,'Mon-yyyy')
month,tradedate,tradeprice,howlano,instrumentcode,tradevolume,tradevolume*tradeprice as value from tradehistory 
where tradedate between '01-Jan-2017' and '31-Dec-2017' and isinvalid='N'
and isdeleted='N')group by instrumentcode) d,instrument i where i.code=d.instrumentcode 
)b where b.instrumentcode=c.instrumentcode

----------------------------Broker wise CnS mail Report (for Kamrun madam). ie. break up of CnS mail Report after trade--------------------------------------

select Tradedate,name,type,buyvolume,sellvolume,buyvalue,sellvalue from (
select tradedate,decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O',
                        'Others','R','NRB','-') as type,
                        Broker,
                        sum(sellhowla) as sellhowla,sum(buyvolume) as buyvolume,sum(sellvolume) as sellvolume,
						round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue
                         from(
						select TO_CHAR(tradedate,'dd-mm-yyyy') AS tradedate, frbuyer as type,buyercode as Broker,count(*) as buyhowla,0 as sellhowla,
                        sum(tradevolume) as buyvolume,0 as sellvolume,sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue,
                        sum(buylagacharge+howlacharge) as buytrancharge,0 as selltrancharge from tradedata where 
                        tradedate between '3-Jun-2018' and '21-Jun-2018' and isinvalid='N' group by 
                        tradedate,frbuyer,buyercode                                                                     
                        union all
						 select TO_CHAR(tradedate,'dd-mm-yyyy') AS tradedate, frseller as type,sellercode as Broker,0 as buyhowla,count(*) as sellhowla,
                         0 as buyvolume,sum(tradevolume) as sellvolume,0 as buvalue,sum(tradeprice*tradevolume) as sellvalue,
                         0 as buytrancharge,sum(selllagacharge+howlacharge) as selltrancharge from tradedata where
                         tradedate between '3-Jun-2018' and '21-Jun-2018' and 
                         isinvalid='N' group by tradedate,frseller,sellercode
						) group by TRADEDATE,type,Broker order by tradedate,type)u,
                        (select code,name from member)m where m.code=u.broker and u.type in 
                        ('Dealer','Foreign','Institution','Normal') 



----------------------------Client type wise buy sell (tested no need to verify everytime)--------------------------------------

select type as CLIENT_TYPE,buyvalue as "BUYAMOUNT (TK)",sellvalue  as "SELLAMOUNT(TK)"
                         from(
                         select decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O',
                         'Others','R','NRB','-') as type,
                         round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue from(
                         select frbuyer as type,
                         sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue
                         from tradehistory where
                         tradedate between '1-Jan-2020' and '31-Dec-2020' and isinvalid='N' group by frbuyer,                         
                         buyercode||buyerclient
                         union all
                         select frseller as type,0 as buvalue,
                         sum(tradeprice*tradevolume) as sellvalue from tradehistory where tradedate between '1-Jan-2020' and '31-Dec-2020' and
                         isinvalid='N' group by frseller,sellercode||sellerclient
                         )  group by type) order by type;


			or


select title,sum(buyamount) as "BUYAMOUNT(TK)",sum(sellamount) as "SELLAMOUNT(TK)" from mis_data where tradedate between '1-Jan-2020' and '31-Dec-2020'
and title in ('Foreign','Institution','Normal','Others','Omnibus','NRB','Dealer') group by title;

---------Broker wise CnS mail Report (for Kamrun madam). ie. break up of CnS mail Report after trade modified version  of above query------------

select TO_CHAR('18-21,Jun,2018') as tradedate, name,dealerbuyvalue,dealersellvalue,foreignbuyvalue,foreignsellvalue,
                        Institutionbuyvalue,    institutionsellvalue,brokerbuyvalue,brokersellvalue  from (                 
                        select BrokerCode,sum(dealerbuyvalue) as dealerbuyvalue,sum(dealersellvalue) as dealersellvalue,
                        sum(foreignbuyvalue) as foreignbuyvalue,sum(foreignsellvalue) as foreignsellvalue,
                        sum(Institutionbuyvalue) as Institutionbuyvalue, sum(institutionsellvalue) as institutionsellvalue,
                        sum(brokerbuyvalue) as brokerbuyvalue, sum(brokersellvalue) as brokersellvalue from
                        (
select  frbuyer as type,SUBSTR(buyercode,4,3) as BrokerCode,
                        sum(tradeprice*tradevolume) as dealerbuyvalue,0 as dealersellvalue,
                        0 as foreignbuyvalue,0 as foreignsellvalue,
                        0 as Institutionbuyvalue, 0 as institutionsellvalue,
                        0 as brokerbuyvalue ,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frbuyer='D' and isinvalid='N' group by 
                        tradedate,frbuyer,buyercode
                        union all
select  frbuyer as type,SUBSTR(buyercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,0 as dealersellvalue,
                        sum(tradeprice*tradevolume) as foreignbuyvalue,0 as foreignsellvalue,
                        0 as Institutionbuyvalue, 0 as institutionsellvalue, 
                        0 as brokerbuyvalue,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frbuyer='F' and isinvalid='N' group by 
                        tradedate,frbuyer,buyercode
                        union all
select  frbuyer as type,SUBSTR(buyercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,0 as dealersellvalue,
                        0 as foreignbuyvalue,0 as foreignsellvalue,
                        sum(tradeprice*tradevolume) as Institutionbuyvalue, 0 as institutionsellvalue,
                        0 as brokerbuyvalue,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frbuyer='I' and isinvalid='N'  group by 
                        tradedate,frbuyer,buyercode
                        union all                        
select  frbuyer as type,SUBSTR(buyercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,0 as dealersellvalue,
                        0 as foreignbuyvalue,0 as foreignsellvalue,
                        0 as Institutionbuyvalue, 0 as institutionsellvalue, 
                        sum(tradeprice*tradevolume) as brokerbuyvalue,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frbuyer='N' and isinvalid='N' group by 
                        tradedate,frbuyer,buyercode
                        union all
select  frseller as type,SUBSTR(sellercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,sum(tradeprice*tradevolume) as dealersellvalue,
                        0 as foreignbuyvalue,0 as foreignsellvalue,
                        0 as Institutionbuyvalue, 0 as institutionsellvalue,
                        0 as brokerbuyvalue,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frseller='D' and isinvalid='N' group by 
                        tradedate,frseller,sellercode
                        union all
select  frseller as type,SUBSTR(sellercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,0 as dealersellvalue,
                        0 as foreignbuyvalue,sum(tradeprice*tradevolume) as foreignsellvalue,
                        0 as Institutionbuyvalue, 0 as institutionsellvalue,
                        0 as brokerbuyvalue,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frseller='F' and isinvalid='N' group by 
                        tradedate,frseller,sellercode
                        union all
select  frseller as type,SUBSTR(sellercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,0 as dealersellvalue,
                        0 as foreignbuyvalue,0 as foreignsellvalue,
                        0 as Institutionbuyvalue, sum(tradeprice*tradevolume) as institutionsellvalue,
                        0 as brokerbuyvalue ,0 as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frseller='I' and isinvalid='N' group by 
                        tradedate,frseller,sellercode
                        union all                        
select  frseller as type,SUBSTR(sellercode,4,3) as BrokerCode,
                        0 as dealerbuyvalue,0 as dealersellvalue,
                        0 as foreignbuyvalue,0 as foreignsellvalue,
                        0 as Institutionbuyvalue, 0 as institutionsellvalue,
                        0 as brokerbuyvalue ,sum(tradeprice*tradevolume) as brokersellvalue from tradedata where 
                        tradedate between '18-Jun-2018' and '21-Jun-2018' and frseller='N' and isinvalid='N'  group by 
                        tradedate,frseller,sellercode                        
                        ) group by BrokerCode)u,
                        (select code,name from member)m where m.code=CONCAT('DSE',u.BrokerCode) order by name;


/*---------
it is decided not to give it and again decided to give by a note)
monitoring(monthly) mail to,mic***mcd@dse.com.bd (new query mailed by kader vai on Tue, January 5, 2016 12:43 pm) 
Monthly Stock Brokers and Stock Dealers list of DSE-Jun 2021
----------*/                                                                                                                                                                      ********

select rownum as slno,id as memno,name as brokername from (
select distinct id,name from (
select tradedate,m.id,name from payreceivable p,member m where
p.membercode=m.code and to_char(tradedate,'mm-yyyy')='06-2021'
) order by id)


/*--------- mcd yearly data on request ----------*/      

---------Total traded value of all TREC Holder companies of DSE during July 1, 2019 to May 31, 2020------------

select x.id as TRECNO,x.name as TRECName,brokertradedvalue,dealertradedvalue,tottradedvalue from
(
(select membercode,SUM(brokerturnover) as brokertradedvalue,sum(dealerturnover) as dealertradedvalue,
sum(brokerturnover+dealerturnover)as tottradedvalue from
(
select substr(p.membercode,4,3) as membercode, sum(buyprice+sellprice) as brokerturnover,0 as dealerturnover from payreceivablehistory p
 where p.tradedate>= TO_DATE('01-07-2019','dd-mm-yyyy')
AND p.tradedate<= TO_DATE('31-05-2020','dd-mm-yyyy') and p.membercode not in ('DSEMGT') and substr(p.membercode,1,3)='DSE'  group by
p.membercode
union all
select substr(p.membercode,4,3) as code, 0 as brokerturnover,sum(buyprice+sellprice) as dealerturnover from payreceivablehistory p
 where p.tradedate>= TO_DATE('01-07-2019','dd-mm-yyyy')
AND p.tradedate<= TO_DATE('31-05-2020','dd-mm-yyyy') and p.membercode not in ('DSEMGT') and substr(p.membercode,1,3)='DLR'  group by
p.membercode) group by membercode)y left join

(select m.id,m.name,substr(m.code,4,3) as code from member m where m.id<331 and m.code is not null
)x on x.code=y.membercode and y.membercode is not null) order by id


/*--------- Afzal Vi data for Investor wise yearly turnover ----------*/      

select 'FY'||TO_CHAR('01-Jul-2013')||'-'||TO_CHAR('30-Jun-2014') as "FYYear", type as Investor,buyvalue,sellvalue,(buyvalue+sellvalue)/2 as turnover,round((((buyvalue+sellvalue)/2)/(select sum(tradevolume*tradeprice) 
from tradehistory where  tradedate between '01-Jul-2013' and '30-Jun-2014')*100),2)as Percent,(select sum(tradevolume*tradeprice) 
from tradehistory where  tradedate between '01-Jul-2013' and '30-Jun-2014') as totturnover
                         from(
						 select decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O',
                         'Others','R','NRB','-') as type,count(distinct client) as client,sum(buyhowla) as buyhowla,
                         sum(sellhowla) as sellhowla,sum(buyvolume) as buyvolume,sum(sellvolume) as sellvolume,
						 round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue,
                         round(sum(buytrancharge+selltrancharge),2) as transaction_charge from(
						 select frbuyer as type,buyercode||buyerclient as client,count(*) as buyhowla,0 as sellhowla,
                         sum(tradevolume) as buyvolume,0 as sellvolume,sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue,
                         sum(buylagacharge+howlacharge) as buytrancharge,0 as selltrancharge from tradehistory where 
                         tradedate between '01-Jul-2013' and '30-Jun-2014' and isinvalid='N' group by frbuyer,                         
                         buyercode||buyerclient
						 union all
						 select frseller as type,sellercode||sellerclient as client,0 as buyhowla,
                         count(*) as sellhowla,0 as buyvolume,sum(tradevolume) as sellvolume,0 as buvalue,
                         sum(tradeprice*tradevolume) as sellvalue,0 as buytrancharge,sum(selllagacharge+howlacharge) 
                         as selltrancharge from tradehistory where tradedate between '01-Jul-2013' and '30-Jun-2014' and 
                         isinvalid='N' group by frseller,sellercode||sellerclient
						 ) group by type) order by investor;


------------------------------------------------------------------
                    --Information
------------------------------------------------------------------

/*--------- data we can provide condfidently from 2007 since previous data may have some problems ----------*/      


/************************Query for retrieving boid **********************/

select distinct boidseller,sellercode||'-'||sellerclient member_client 
from tradehistory where tradedate between '01-Aug-2015' and '08-Sep-2015' and sellercode||'-'||sellerclient in 
('DSEGLO-O127','DSEFCS-41888','DSETSL-S00995','DSESAK-14780','DSEAMC-062098','DSESAG-1370','DSEEPS-C3997','DSESAK-02885',
'DSEGLO-O172','DSETSL-S00681','DSEJKC-5823','DSESAK-14229','DSEAMC-062038','DSERSC-31020','DSEMOR-160693',
'DSEAMC-062147','DSEASE-0007','DSESBL-13471','DSEGLO-O124','DSEAIB-E1291','DSEHAI-39188','DSEMOR-065364',
'DSEFCS-41588','DSETOT-55052','DSESAK-00556','DSEJSL-26515','DSEAZA-4398','DSEBDS-567','DSELRK-338','DSEAAL-19',
'DSEIHC-10124','DSEJSL-32747','DSESBL-20705','DSETAR-30260','DSEBDS-2902','DSEPSL-54942','DSERAP-M1116',
'DSESBM-08190','DSEPSL-21251','DSERNT-2363','DSEJAH-6127','DSEAIB-A1318','DSENCC-08696','DSESAG-TNG14705',
'DSEGSL-30395','DSEMOR-005115') and isdeleted='N' and isinvalid='N' order by member_client asc;



/*********************************Query for Nasir saheb(data of the TREC holders 
of DSE regarding Turnover (from July, 2015 to till) for preparing the draft yearly monitoring plan. )**************************************/


select m.id,m.name,p.membercode, sum(buyprice+sellprice) as turnover from payreceivablehistory p
inner join
member m on p.membercode=m.code where p.tradedate>= TO_DATE('01-07-2015','dd-mm-yyyy') 
AND p.tradedate<= TO_DATE('19-05-2016','dd-mm-yyyy') and m.id<>333 group by m.id,m.name,
p.membercode order by m.id asc



/*********************** list of TREC holders based on the basis of turnover including turnover data (mcd)***********************/


select rownum as rank,x.* from (

select id,name,turnover from(

select substr(membercode,4.6) as code,sum(buyprice+sellprice) as turnover from payreceivablehistory where 
tradedate between '01-Jan-2019' AND '31-Aug-2020' group by substr(membercode,4.6)

) a,member b where b.code = 'DSE'||a.code and b.ID<>333 order by 3 desc

) x;


/**************************list of TREC holders based on the basis of yearly avg turnover*******************************/


select rownum as rank,id as "TREC No",name as "Name of the TREC Company","Yearly Avg Turnover" from (

select id,name,turnover as "Yearly Avg Turnover" from(

select substr(membercode,4.6) as code,round(sum(buyprice+sellprice)/3,2) as turnover from payreceivablehistory where
tradedate between '01-Jul-2017' AND '30-Jun-2020' group by substr(membercode,4.6)

) a,member b where b.code = 'DSE'||a.code and b.ID<>333 order by 3 desc

) x;


/*****************************
Aloke foreign query(aloke@dsebd.org and 
kamrun.nahar@dse.com.bd and mis@dse.com.bd) AND markettype<>'S' this condition is removed on 04 Nov 2018
after telephonic conversation with kamrun madam
************************/  


SELECT TO_CHAR(tradedate,'yyyy-mm') AS MONTH,COUNT(*) AS
howla,SUM(tradevolume*tradeprice) AS turnover FROM tradehistory 
WHERE tradedate BETWEEN '01-Jan-2019' AND '31-Jan-2019' AND 
(SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM 
marginforeignclient) OR SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) 
FROM marginforeignclient)) AND howlatype<>'D' AND isinvalid='N' GROUP BY TO_CHAR(tradedate,'yyyy-mm')


/*******************Query for Bangladesh bank (mamun vi)*******************/

-- Total query:

select count(*) from(
select trecholder from 
(select SUBSTR(buyercode,4,3) as trecholder
from TRADEHISTORY where tradedate between '01-Oct-2017' AND '31-Dec-2017'
and SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM 
marginforeignclient where isdeleted='N')  AND markettype<>'S' AND howlatype<>'D' AND isinvalid='N')
union
(select SUBSTR(sellercode,4,3) as trecholder
from TRADEHISTORY where tradedate between '01-Oct-2017' AND '31-Dec-2017'
and SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) 
FROM marginforeignclient where isdeleted='N')  AND markettype<>'S' AND howlatype<>'D' AND isinvalid='N'));

--Details Query

select month,count(*) as "No of Broker"
 from(
select month, trecholder from 
(select TO_CHAR(tradedate,'yyyy-mm') AS MONTH,SUBSTR(buyercode,4,3) as trecholder
from TRADEHISTORY where tradedate between '01-Dec-2022' AND '31-Dec-2022'
and SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM 
marginforeignclient where isdeleted='N')  AND markettype<>'S' AND howlatype<>'D' AND isinvalid='N')
union
(select TO_CHAR(tradedate,'yyyy-mm') AS MONTH,SUBSTR(sellercode,4,3) as trecholder
from TRADEHISTORY where tradedate between '01-Dec-2022' AND '31-Dec-2022'
and SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) 
FROM marginforeignclient where isdeleted='N')  AND markettype<>'S' AND howlatype<>'D' AND isinvalid='N')) group by month order by month



--------------Block Turnover----------------

SELECT sum(tradevolume) tradevolume, sum(turnover) turnover
from(
select tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jun-2021' and '30-Jun-2021'
) where markettype='Block';


---------------------Block and Public Turnover (Without SME)-------------------------------

select tradedate,sum(PublicTradevolume) NormalVolume, sum(Publicturnover)NormalTurnover, sum(BlockTradevolume)BlockTradevolume, sum(BlockTurnover)BlockTurnover from(
SELECT tradedate,sum(tradevolume) PublicTradevolume, sum(turnover) Publicturnover,0 BlockTradevolume,0 BlockTurnover
from(
select tradedate,tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradedata where isdeleted='N' and isinvalid='N' and tradedata.GROUPCODE<>'S'
and tradedate between '1-Nov-2022' and '20-Dec-2022'
) where markettype='Public' group by tradedate
union all
SELECT tradedate,0 PublicTradevolume, 0 Publicturnover,sum(tradevolume) BlockTradevolume,sum(turnover) BlockTurnover
from(
select tradedate,tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradedata where isdeleted='N' and isinvalid='N'
and tradedate between '1-Nov-2022' and '20-Dec-2022'
) where markettype='Block' group by tradedate) group by tradedate order by tradedate;


----------------------------------------Block and Public Turnover (Without SME and ATB)----------------------------------------------------


select d.markettype,turnover, tot_turnover,Percent_of_total_trade,No_of_Trade from ( select markettype,turnover, tot_turnover, round((turnover/tot_turnover)*100,2) 
Percent_of_total_trade from ( select markettype,turnover, tot_turnover from ( SELECT markettype,sum(tradevolume) tradevolume, sum(turnover) turnover from( select tradevolume,
(tradevolume*tradeprice) turnover, case markettype when 'P' then 'Public' when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end when 'D' then 'Public' when 'B' then 'Block' 
end markettype from tradehistory where isdeleted='N' and isinvalid='N' and groupcode not in('S','P')  
and tradedate between to_date('01/01/2023','dd/mm/yyyy')  and to_date('31/01/2023','dd/mm/yyyy') ) 
group by markettype)a,(select sum(tradevolume*tradeprice) tot_turnover from tradehistory where isdeleted='N' and isinvalid='N' and groupcode not in('S','P')
and tradedate between to_date('01/01/2023','dd/mm/yyyy')  
and to_date('31/01/2023','dd/mm/yyyy'))))d, (SELECT markettype,MONTH,count(*) No_of_Trade from( select to_char(tradedate,'MON-YY') MONTH,howlano, 
case markettype when 'P' then 'Public' when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end when 'D' then 'Public' when 'B' then 'Block' end markettype 
from tradehistory where isdeleted='N' and isinvalid='N' and groupcode not in('S','P')
and tradedate between to_date('01/01/2023','dd/mm/yyyy')  and to_date('31/01/2023','dd/mm/yyyy') )  group by markettype, MONTH)e where e.markettype=d.markettype order by d.markettype;


--------------------Block and Public Turnover------------------

select sum(PublicTradevolume) PublicTradevolume, sum(Publicturnover)Publicturnover, sum(BlockTradevolume)BlockTradevolume, sum(BlockTurnover)BlockTurnover from(
SELECT sum(tradevolume) PublicTradevolume, sum(turnover) Publicturnover,0 BlockTradevolume,0 BlockTurnover
from(
select tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jul-2021' and '31-Jul-2021'
) where markettype='Public'
union all
SELECT 0 PublicTradevolume, 0 Publicturnover,sum(tradevolume) BlockTradevolume,sum(turnover) BlockTurnover
from(
select tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jul-2021' and '31-Jul-2021'
) where markettype='Block')


--------------Block No of  Trade----------------

SELECT MONTH,count(*) "No of Trade"
from(
select to_char(tradedate,'MON-YY') MONTH,howlano,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jun-2021' and '30-Jun-2021'
) where markettype='Block' group by MONTH;


-----------------Public and Block No of Trade----------


select sum ("No of PublicTrade") "No of PublicTrade",sum("No of BlockTrade") "No of BlockTrade" from(
SELECT MONTH,count(*) "No of PublicTrade",0  "No of BlockTrade"
from(
select to_char(tradedate,'MON-YY') MONTH,howlano,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jul-2021' and '31-Jul-2021'
) where markettype='Public' group by MONTH
union all
SELECT MONTH,0 "No of PublicTrade",count(*) "No of BlockTrade"
from(
select to_char(tradedate,'MON-YY') MONTH,howlano,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jul-2021' and '31-Jul-2021'
) where markettype='Block' group by MONTH) group by MONTH;


--------------Top 5 Instrument in Block----------------

select rownum as slno,instrumentcode,tradevolume, turnover from (
SELECT instrumentcode,sum(tradevolume) tradevolume,sum(turnover) turnover
from(
select instrumentcode,tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Jun-2021' and '30-Jun-2021'
) where markettype='Block' group by instrumentcode order by turnover desc) where rownum<=5;


------------------SEC query for mamun monthly (Total Trading in exchanges)-----------


select markettype,turnover, tot_turnover, round((turnover/tot_turnover)*100,2) "% of total trade" from (
select markettype,turnover, tot_turnover from (
SELECT markettype,sum(tradevolume) tradevolume, sum(turnover) turnover
from(
select tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N' and groupcode<>'S'
and tradedate between '1-Sep-2021' and '30-Sep-2021'
) group by markettype)a,(select sum(tradevolume*tradeprice) tot_turnover from tradehistory where isdeleted='N' and isinvalid='N' and groupcode<>'S'
and tradedate between '1-Sep-2021' and '30-Sep-2021'));


SELECT markettype,MONTH,count(*) "No of Trade"
from(
select to_char(tradedate,'MON-YY') MONTH,howlano,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N' and groupcode<>'S'
and tradedate between '1-Sep-2021' and '30-Sep-2021'
)  group by markettype, MONTH;


select rownum as slno,instrumentcode,round(turnover/tradevolume,2) price,tradevolume, turnover from (
SELECT instrumentcode,sum(tradevolume) tradevolume,sum(turnover) turnover
from(
select instrumentcode,tradevolume,(tradevolume*tradeprice) turnover,
case markettype
when 'P' then 'Public'
when 'S' then case when compulsoryspot='B' then 'Block' else 'Public' end
when 'D' then 'Public'
when 'B' then 'Block'
end markettype
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Sep-2021' and '30-Sep-2021'
) where markettype='Block' group by instrumentcode order by turnover desc) where rownum<=5;


---------------All Market Top 40 Buy----------------

select instrumentcode ,
buyercode ,
buyerclient ,
boidbuyer ,
tradevolume  from (
select instrumentcode,buyercode,
buyerclient,boidbuyer,sum(tradevolume) as tradevolume
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Apr-2018' and '30-May-2019' and instrumentcode='MONNOSTAF' 
group by instrumentcode,buyercode,buyerclient,boidbuyer
ORDER BY tradevolume desc) where rownum<=40;

---------------All Market Top 40 Sell ----------------
select instrumentcode ,
buyercode ,
buyerclient ,
boidbuyer ,
tradevolume  from (
select instrumentcode,sellercode,sellerclient,boidseller,sum(tradevolume) as tradevolume
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Apr-2018' and '30-May-2019' and instrumentcode='MONNOCERA' 
group by instrumentcode,sellercode,sellerclient,boidseller
ORDER BY tradevolume desc) where rownum<=40;


---------------------Public Market Top 40 Buy ------------------------
select instrumentcode ,
buyercode ,
buyerclient ,
boidbuyer ,
tradevolume  from( 
select instrumentcode,buyercode,
buyerclient,boidbuyer,sum(tradevolume) as tradevolume
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Apr-2018' and '30-May-2019' and instrumentcode='MONNOSTAF' 
and (markettype in ('P','D') or (markettype='S' and compulsoryspot<>'B')) 
group by instrumentcode,buyercode,buyerclient,boidbuyer
ORDER BY tradevolume desc) where rownum<=40;

---------------------Public Market Top 40 Sell ------------------------
select instrumentcode ,
sellercode,sellerclient,boidseller,
tradevolume  from( 
select instrumentcode,sellercode,sellerclient,boidseller,sum(tradevolume) as tradevolume
from tradehistory where isdeleted='N' and isinvalid='N'
and tradedate between '1-Apr-2018' and '30-May-2019' and instrumentcode='MONNOCERA' 
and (markettype in ('P','D') or (markettype='S' and compulsoryspot<>'B')) 
group by instrumentcode,sellercode,sellerclient,boidseller
ORDER BY tradevolume desc) where rownum<=40;


/*********************For sahera First tradedate of New TREC HOLDER************************/

SELECT a.id, m.code, m.name, a.tradestartDate
FROM (
    SELECT membercode, MIN(tradedate) tradestartDate
    FROM payreceivablehistory
    WHERE tradedate BETWEEN TO_DATE('01-Jan-2022', 'DD-MON-YYYY') AND TO_DATE('04-Jul-2022', 'DD-MON-YYYY')
    AND membercode IN (
        'DSEKBR', 'DSEMHL', 'DSESSB', 'DSERBH', 'DSEJBS', 'DSESEL', 'DSEISC', 'DSESAT', 'DSETRI', 'DSERSZ', 'DSESON',
        'DSEMIR', 'DSESBA', 'DSEAMA', 'DSEPRC', 'DSEBBL', 'DSEBSE', 'DSESFS', 'DSETSA', 'DSEDYS', 'DSEAMR', 'DSEBHL',
        'DSEACS', 'DSEBRL', 'DSECSS', 'DSERML', 'DSESMT', 'DSESIL', 'DSEASM', 'DSECAL', 'DSEIBL', 'DLRKBR', 'DLRMHL',
        'DLRSSB', 'DLRRBH', 'DLRJBS', 'DLRSEL', 'DLRISC', 'DLRSAT', 'DLRTRI', 'DLRRSZ', 'DLRMIR', 'DLRSBA', 'DLRBBL',
        'DLRBSE', 'DLRSFS', 'DLRTSA', 'DLRDYS', 'DLRAMR', 'DLRBHL', 'DLRCSS', 'DLRRML', 'DLRSIL', 'DLRASM', 'DLRCAL',
        'DLRIBL', 'DSEMIR', 'DSEJBS', 'DSESAT'
    )
    GROUP BY membercode
) a
JOIN member m ON m.code = a.membercode
ORDER BY a.id;


 /******************************IPF Query (It should be run from sql developer)****************************************/

 select m.id AS TRECID,name AS
"TREC Name",TURNOVER,turnover/1000000 as FUND from(
 SELECT MEMCODE,SUM(TURNOVER) AS TURNOVER FROM 
 (
 select SUBSTR(membercode,4,3) AS MEMCODE,sum((buyprice+sellprice)) as turnover from PAYRECEIVABLEHISTORY where tradedate 
between '01-Apr-2017' and '30-Jun-2017' GROUP BY MEMBERCODE)A 
GROUP BY MEMCODE)B, member m where m.id<333 AND B.MEMCODE=substr(m.code,4,3) order by id;


--------------------------IPO Price Movement using comid------------------

select u.code as instrumentcode,s.* from
(
select code, sum (first30avgprice) as first30avgprice, sum(last30avgprice) as last30avgprice from (
select  code,ROUND(sum(turnover)/sum(trdvol),2) as first30avgprice,0 as last30avgprice from
(
select * from (
SELECT e.tradedate,e.trdvol,e.turnover,e.code , DENSE_RANK() 
   OVER (PARTITION BY e.code ORDER BY e.tradedate asc) AS drank from
   (
select t.tradedate,t.trdvol,t.turnover,t.instrumentcode,i.id as code
FROM  tradecloseprice t, instrument i
where t.instrumentcode=i.code and i.id in(
17481,
13246,
17482,
18495,
29004,
13247
))e, tradecloseprice d  WHERE e.instrumentcode = d.instrumentcode 
and e.tradedate=d.tradedate)a where a.drank<=30)b group by b.code

union all

select  code,0 as first30avgprice,ROUND(sum(turnover)/sum(trdvol),2) as last30avgprice from
(
select * from (
SELECT e.tradedate,e.trdvol,e.turnover,e.code , DENSE_RANK() 
   OVER (PARTITION BY e.code ORDER BY e.tradedate desc) AS drank from
   (
select t.tradedate,t.trdvol,t.turnover,t.instrumentcode,i.id as code
FROM  tradecloseprice t, instrument i
where t.instrumentcode=i.code and i.id in(
17481,
13246,
17482,
18495,
29004,
13247
))e, tradecloseprice d  WHERE e.instrumentcode = d.instrumentcode 
and e.tradedate=d.tradedate)a where a.drank<=30)g group by g.code) h group by h.code)s,instrument u
where s.code=u.id and u.status=1 order by u.code asc;


/******** IPO Price Movement using Instrumentcode
Problem here in case of first30 days if instrumentname is changed then it will not come
*******/

select instrumentcode, sum (first30avgprice) as first30avgprice, sum(last30avgprice) as last30avgprice from (
select  instrumentcode,ROUND(sum(turnover)/sum(trdvol),2) as first30avgprice,0 as last30avgprice from(
select *from
(
SELECT e.tradedate,e.trdvol,e.turnover,e.instrumentcode , DENSE_RANK()
   OVER (PARTITION BY e.instrumentcode ORDER BY e.tradedate asc) AS drank
   FROM  tradecloseprice e, tradecloseprice d
   WHERE e.instrumentcode = d.instrumentcode and e.tradedate=d.tradedate
   AND d.instrumentcode IN (
'ESQUIRENIT',
'RUNNERAUTO',
'NEWLINE',
'SILCOPHL',
'SEAPEARL',
'COPPERTECH'
))a where a.drank<=30)b group by b.instrumentcode

union all

select  instrumentcode,0 as first30avgprice,ROUND(sum(turnover)/sum(trdvol),2) as last30avgprice from(
select *from
(
SELECT e.tradedate,e.trdvol,e.turnover,e.instrumentcode , DENSE_RANK()
   OVER (PARTITION BY e.instrumentcode ORDER BY e.tradedate desc) AS drank
   FROM  tradecloseprice e, tradecloseprice d
   WHERE e.instrumentcode = d.instrumentcode and e.tradedate=d.tradedate
   AND d.instrumentcode IN (
'ESQUIRENIT',
'RUNNERAUTO',
'NEWLINE',
'SILCOPHL',
'SEAPEARL',
'COPPERTECH'
))a where a.drank<=30)b group by b.instrumentcode)e group by e.instrumentcode order by e.instrumentcode asc;


/*************Imam vai: Per Day Per instrument per howla trade volume > 5 lac****************/

select tradedate,instrumentcode,count(*) as count,round(avg(tradevalue),2) as avgtradevalue
from(
select tradedate,instrumentcode,tradeprice*tradevolume as tradevalue from
tradehistory where tradedate between '16-Apr-2017' and '15-Apr-2018'
and tradeprice*tradevolume>500000
)group by tradedate,instrumentcode order by tradedate,count desc;


/*************Imam vai: Per Day Per per howla trade volume > 5 lac ****************/

select tradedate,count(*) as count,round(avg(tradevalue),2) as avgtradevalue
from(
select tradedate,instrumentcode,tradeprice*tradevolume as tradevalue from
tradehistory where tradedate between '16-Apr-2017' and '15-Apr-2018'
and tradeprice*tradevolume>500000
)group by tradedate order by tradedate desc;


select tradedate,instrumentcode,count(*) as count,round(avg(tradeprice),2) as avgtradeprice,
round(sum(tradevolume),2) as totradevolume
from(
select tradedate,instrumentcode,tradeprice,tradevolume from
tradehistory where tradedate between '16-Apr-2017' and '15-Apr-2018'
and tradeprice*tradevolume>500000
)group by tradedate,instrumentcode order by tradedate,count desc;


---------------------IPO----------------------------

select k.*,lasttradedate,lasttradecloseprice,ltradedatehowla,ltradedatetrdvol,ltradedateturnover from 

(select j.*,lt.lowpricedate,lt.lowprice,lowprcdatehowla,lowprcdatetrdvol,lowprcdateturnover from 
(
select g.*,ht.highpricedate,ht.highprice,hprcdatehowla,hprcdatetrdvol,hprcdateturnover from 
(
select f.*,tradecloseprice,decode(howla,NULL,'Not Found',howla) as ftradedatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
ftradedatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  ftradedateturnover from 
(
select t.INSTRUMENTCODE,name,min(tradedate) as firsttradedate  from tradecloseprice t,instrument i 
where i.code=t.instrumentcode and 
tradecloseprice is not null and  tradedate>='1-Jan-2009' and instrumenttype in ('DB','EQ','MF','CB') group by 
t.INSTRUMENTCODE,instrumenttype,name) f, tradecloseprice tc where tc.instrumentcode=f.INSTRUMENTCODE
and tc. tradedate=f.firsttradedate order by firsttradedate
) g, 
(select h.*,tradedate as highpricedate,decode(howla,NULL,'Not Found',howla) as hprcdatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
hprcdatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  hprcdateturnover from 
(
select instrumentcode,max(tradeprice) as highprice from tradehistory where tradedate>='1-Jan-2009' group by instrumentcode
)h, TRADECLOSEPRICE td where td.instrumentcode=h.instrumentcode
and td.hiprc=h.highprice) ht where ht.instrumentcode=g.instrumentcode
)j,
(select l.*,tradedate as lowpricedate,decode(howla,NULL,'Not Found',howla) as lowprcdatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
lowprcdatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  lowprcdateturnover from 
(
select instrumentcode,min(tradeprice) as lowprice from tradehistory where tradedate>='1-Jan-2009' group by instrumentcode
)l, TRADECLOSEPRICE td where td.instrumentcode=l.instrumentcode
and td.lowprc=l.lowprice) lt where lt.instrumentcode=j.instrumentcode)k,
(select lt.*,tradecloseprice as lasttradecloseprice,decode(howla,NULL,'Not Found',howla) as ltradedatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
ltradedatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  ltradedateturnover from 
(
select instrumentcode,max(tradedate) as lasttradedate from tradecloseprice 
where tradedate>='1-Jan-2009' and tradecloseprice is not null
group by instrumentcode)lt, tradecloseprice td3 where  td3.instrumentcode=lt.instrumentcode
and td3.tradedate=lt.lasttradedate) m where m.instrumentcode=k.instrumentcode order by k.instrumentcode;


------------------------------TREC ranking by turnover (must check duplicade id after running the query)------------------------------------------

select ROWNUM AS SLNO,id,name,code,turnover from(
select n.id,n.name,n.code,turnover from 
(
select id,sum(turnover) turnover from (
select m.id,turnover from 
(
select SUBSTR(membercode, 4, 3)as membercode, (buyprice+sellprice) as turnover from payreceivablehistory 
where tradedate>= TO_DATE('01-07-2020','dd-mm-yyyy') 
AND tradedate<= TO_DATE('30-06-2021','dd-mm-yyyy') and membercode<>'DSEMGT')a inner join
member m on 'DSE'||a.membercode=m.code)group by id)b inner join
member n on b.id=n.id and n.MEMSTATUS='A' order by turnover desc)


--------------------------------------------------------Monthly turnover---------------------------------------------

select trdmonth, total_turnover,

spot_turnover, ROUND((spot_turnover/total_turnover)*100, 2) as spot_to_total_perc,

public_turnover, ROUND((public_turnover/total_turnover)*100, 2) as public_to_total_perc

from(

    select trdmonth, SUM(total_turnover) total_turnover, SUM(spot_turnover) spot_turnover, SUM(public_turnover) public_turnover from(

        select to_char(tradedate,'Mon-yyyy') trdmonth, sum(tradeprice*tradevolume) as total_turnover, 0 as spot_turnover, 0 as public_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Oct-2018' and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')

        union all

        select to_char(tradedate,'Mon-yyyy') trdmonth, 0 as total_turnover, sum(tradeprice*tradevolume) as spot_turnover, 0 as public_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Oct-2018' and MARKETTYPE='S' and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')

        union all

        select to_char(tradedate,'Mon-yyyy') trdmonth, 0 as total_turnover, 0 as spot_turnover, sum(tradeprice*tradevolume) as public_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Oct-2018' and MARKETTYPE='P' and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')

    ) group by trdmonth

) x


----------------------------------------Monthly Turnover New-----------------------------------


select trdmonth, total_turnover,

spot_turnover, ROUND((spot_turnover/total_turnover)*100, 2) as spot_to_total_perc,

public_turnover, ROUND((public_turnover/total_turnover)*100, 2) as public_to_total_perc,block_turnover,ROUND((block_turnover/total_turnover)*100, 2) as block_to_total_perc

from(

    select trdmonth, SUM(total_turnover) total_turnover, SUM(spot_turnover) spot_turnover, SUM(public_turnover) public_turnover,sum(block_turnover) as block_turnover
    from(

        select to_char(tradedate,'Mon-yyyy') trdmonth, sum(tradeprice*tradevolume) as total_turnover, 0 as spot_turnover, 0 as public_turnover,
        0 as block_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Feb-2021' and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')

        union all

        select to_char(tradedate,'Mon-yyyy') trdmonth, 0 as total_turnover, sum(tradeprice*tradevolume) as spot_turnover, 0 as public_turnover,
        0 as block_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Feb-2021' and MARKETTYPE='S' and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')

        union all

        select to_char(tradedate,'Mon-yyyy') trdmonth, 0 as total_turnover, 0 as spot_turnover, sum(tradeprice*tradevolume) as public_turnover,
        0 as block_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Feb-2021' and MARKETTYPE='P' and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')
            
        union all
        
        select to_char(tradedate,'Mon-yyyy') trdmonth, 0 as total_turnover, 0 as spot_turnover, 0 as public_turnover,sum(tradeprice*tradevolume) as block_turnover from tradedata

            where to_char(tradedate,'Mon-yyyy')='Feb-2021' and (MARKETTYPE='B' or (markettype='S' and compulsoryspot='B')) and isdeleted='N' and isinvalid='N'

            group by to_char(tradedate,'Mon-yyyy')

    ) group by trdmonth

) x


----------------------------------------Not Trade-----------------------------------------------------------------
 
select code, name from instrument where ISDEMATTED='Y' and status=1
and to_date(to_char(startdate,'Mon-yyyy'),'Mon-yyyy') <= to_date('Oct-2023','Mon-yyyy')
and code NOT IN (select instrumentcode from tradedata where to_char(tradedate,'Mon-yyyy')='Oct-2023' and isdeleted='N' and isinvalid='N')
order by name;


---------------------------------------------Rise / Decline For the month Jan (Data is given on Feb)--------------------------------------------------------

select name,instrumentcode, price_change_nature, start_of_month_price, end_of_month_price, price_change, price_change_perc from (
select i.name, y.*,
ROUND((y.end_of_month_price - y.start_of_month_price), 4) price_change,
decode(y.start_of_month_price, 0, 100, ROUND(((y.end_of_month_price - y.start_of_month_price)/y.start_of_month_price) * 100, 2)) price_change_perc,
decode(SIGN(y.end_of_month_price - y.start_of_month_price), 1, 'Rise', -1, 'Decline', 'No Change') price_change_nature
from instrument i, (
select instrumentcode, sum(start_of_month_price) start_of_month_price, sum(end_of_month_price) end_of_month_price from (
select instrumentcode, tradecloseprice as start_of_month_price, 0 as end_of_month_price from
(select ROW_NUMBER() OVER(PARTITION BY t.instrumentcode ORDER BY t.tradedate DESC) AS rowno, t.instrumentcode, t.tradecloseprice
from tradecloseprice t where to_char(tradedate,'Mon-yyyy')='Dec-2018') where rowno=1
union all
select instrumentcode, 0 as start_of_month_price, tradecloseprice as end_of_month_price from
(select ROW_NUMBER() OVER(PARTITION BY t.instrumentcode ORDER BY t.tradedate DESC) AS rowno, t.instrumentcode, t.tradecloseprice
from tradecloseprice t where to_char(tradedate,'Mon-yyyy')='Jan-2019') where rowno=1
) x group by instrumentcode) y where i.code=y.instrumentcode and i.SECTORID<>88) z
where ABS(z.price_change_perc)>=10 order by price_change_perc desc


-------------------------------------IPO History Final-----------------------------------------------


select k.*,lasttradedate,lasttradecloseprice,ltradedatehowla,ltradedatetrdvol,ltradedateturnover from 

(select j.*,lt.lowpricedate,lt.lowprice,lowprcdatehowla,lowprcdatetrdvol,lowprcdateturnover from 
(
select g.*,ht.highpricedate,ht.highprice,hprcdatehowla,hprcdatetrdvol,hprcdateturnover from 
(
select x.*,count(*)as fhowla,sum(tradevolume) as ftradevolume, sum(tradeprice*tradevolume) as fturnover from
(
select f.*,tradecloseprice 
 from 
(
select t.INSTRUMENTCODE,name,min(tradedate) as firsttradedate  from tradehistory t,instrument i 
where i.code=t.instrumentcode  and  tradedate between '1-Jan-2009' and '18-Jul-2018' and t.instrumentcode in ('NHFIL',
'SKTRIMS'
) group by 
t.INSTRUMENTCODE,instrumenttype,name) f, tradecloseprice tc where tc.instrumentcode=f.INSTRUMENTCODE
and tc. tradedate=f.firsttradedate)x,tradehistory th where th.tradedate=x.firsttradedate 
and th.instrumentcode=x.instrumentcode 
GROUP BY x.instrumentcode,x.name,x.firsttradedate,x.tradecloseprice order by firsttradedate
) g, 
(select h.*,tradedate as highpricedate,decode(howla,NULL,'Not Found',howla) as hprcdatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
hprcdatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  hprcdateturnover from 
(
select instrumentcode,max(tradeprice) as highprice from tradehistory where tradedate between '1-Jan-2009' and '18-Jul-2018' group by instrumentcode
)h, TRADECLOSEPRICE td where td.instrumentcode=h.instrumentcode
and td.hiprc=h.highprice) ht where ht.instrumentcode=g.instrumentcode
)j,
(select l.*,tradedate as lowpricedate,decode(howla,NULL,'Not Found',howla) as lowprcdatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
lowprcdatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  lowprcdateturnover from 
(
select instrumentcode,min(tradeprice) as lowprice from tradehistory where tradedate between '1-Jan-2009' and '18-Jul-2018' group by instrumentcode
)l, TRADECLOSEPRICE td where td.instrumentcode=l.instrumentcode
and td.lowprc=l.lowprice) lt where lt.instrumentcode=j.instrumentcode)k,
(select lt.*,tradecloseprice as lasttradecloseprice,decode(howla,NULL,'Not Found',howla) as ltradedatehowla,decode(trdvol,NULL,'Not Found',trdvol) as 
ltradedatetrdvol,decode(turnover,NULL,'Not Found',turnover)  as  ltradedateturnover from 
(
select instrumentcode,max(tradedate) as lasttradedate from tradecloseprice 
where tradedate between '1-Jan-2009' and '18-Jul-2018' and tradecloseprice is not null
group by instrumentcode)lt, tradecloseprice td3 where  td3.instrumentcode=lt.instrumentcode
and td3.tradedate=lt.lasttradedate and td3.tradedate between '1-Jan-2009' and '18-Jul-2018') m where m.instrumentcode=k.instrumentcode order by k.instrumentcode;


/**************************SEC data for close price for a instrument and a given date********************/

select tradedate,instrumentcode,tradecloseprice from TRADECLOSEPRICE where 
((tradedate=(select max(tradedate) from tradecloseprice where tradedate<'23-May-19' and instrumentcode='MIDASFIN') or tradedate=(select min(tradedate) 
from tradecloseprice where tradedate>'23-May-19' and instrumentcode='MIDASFIN')) and instrumentcode='MIDASFIN') or
((tradedate=(select max(tradedate) from tradecloseprice where tradedate<'28-May-19' and instrumentcode='GLOBALINS') or tradedate=(select min(tradedate) 
from tradecloseprice where tradedate>'28-May-19' and instrumentcode='GLOBALINS')) and instrumentcode='GLOBALINS') or
((tradedate=(select max(tradedate) from tradecloseprice where tradedate<'29-May-19' and instrumentcode='BERGERPBL') or tradedate=(select min(tradedate) 
from tradecloseprice where tradedate>'29-May-19' and instrumentcode='BERGERPBL')) and instrumentcode='BERGERPBL') 
 order by instrumentcode,tradedate;



/**********************Lasttrade date and ClosePrice*******************/


select INSTRUMENTCODE,lasttradedate,tradecloseprice,ss.name as sector from (
select lt.*,tradecloseprice from
(select t.INSTRUMENTCODE,name,max(tradedate) as lasttradedate,i.SECTORID  from tradecloseprice t,instrument i
where i.code=t.instrumentcode and
tradecloseprice is not null and trdvol is not null and  tradedate>='1-Jan-2009' and instrumenttype not in ('DB','TB')
and status =1 group by
t.INSTRUMENTCODE,instrumenttype,i.sectorid,name)lt, tradecloseprice td3 where  td3.instrumentcode=lt.instrumentcode
and td3.tradedate=lt.lasttradedate) aa, sector  ss where ss.id=aa.sectorid order by lasttradedate desc,instrumentcode asc;





/***************************BSEC data for various query**************************/

01. Total Trade Volume of other than Block Market with trading price from June 14, 2020 to June 25, 2020
02. Total Trade Volume of Block Market with trading price from June 14, 2020 to June 25, 2020
03. Total Trade Volume of Block Market below Floor Price with trading price from June 14, 2020 to June 25, 2020
04. Security wise total trade volume of Block Market with trading price from June 14, 2020 to June 25, 2020
05. Security wise (which securities transacted in block market) total trade volume of other than block market with trading price from June 14, 2020 to June 25, 2020
06. Security wise total trade volume of block market with trading price considering below floor price from June 14, 2020 to June 25, 2020
07.  Provide the closing price of the securities which shares were transacted in Block Market.

-----------1-------------------

select tradedate,sum(tradeprice*tradevolume) as totalvolume   from tradedata
where tradedate between '14-Jun-2020' and '25-Jun-2020'  and (markettype!='B' and compulsoryspot!='B') group by tradedate
order by tradedate;


-------------2------------------------------

select tradedate,sum(tradeprice*tradevolume) as totalvolume   from tradedata
where tradedate between '14-Jun-2020' and '25-Jun-2020'  and (markettype='B' or compulsoryspot='B') group by tradedate
order by tradedate;
 
 
---------------------------4--------------------

select tradedate,instrumentcode,tradevolume as sharequantity,tradeprice,tradeprice*tradevolume as totalvolume   from tradedata
where tradedate between '14-Jun-2020' and '25-Jun-2020'
and (markettype='B' or compulsoryspot='B')
order by tradedate,instrumentcode;

----------------------------5--------------


select tradedate,instrumentcode,tradevolume as sharequantity,tradeprice,tradeprice*tradevolume as totalvolume   from tradedata
where tradedate between '14-Jun-2020' and '25-Jun-2020'
and (markettype!='B' and compulsoryspot!='B')
order by tradedate,instrumentcode;

-----------7---------------------------------


select a.tradedate,b.instrumentcode,b.tradecloseprice from (

select distinct tradedate, instrumentcode from tradedata where (markettype='B' or compulsoryspot='B') and 
tradedate  between '14-Jun-2020' and '25-Jun-2020'

) a,tradecloseprice b where a.tradedate=b.tradedate and a.instrumentcode=b.instrumentcode order by 1,2;


------------------------- Turnover for a fiscal year for given members without duplicate value Dt. 30 Jan 2023----------------------

SELECT ROWNUM AS SLNO,id,code,"NAME OF THE MEMBER'S COMPANY",turnover FROM (
select x.id,x.code,decode(x.type,'B',x.id||' ','')||x.name||decode(x.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",turnover from (
select id,sum(turnover) turnover from(
select m.id,n.code,name,turnover from(
select membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory where tradedate
between '01-Jul-2020' and '30-Jun-2021' and membercode in ('DSEGSL',
'DSEFER',
'DSEEBS',
'DSERIZ',
'DSESTB',
'DSEIST',
'DSEISL',
'DSESJB',
'DSEBSR',
'DSEEPS',
'DSEIBB',
'DSEUSB','DSELRK','DSEGQU') group by membercode)n, member m where
n.code=m.code and m.id<333) group by id)y, member x where
y.id=x.id and y.id<333 and x.memstatus='A' order by turnover desc)g;


-----------------------------Broker Avg Tunover Per Day for a Fiscal Year-----------------------

select  id,code,"NAME OF THE MEMBER'S COMPANY",NoofTradeDay,turnover,round(turnover/NoofTradeDay,2) AvgTurnover from(
select x.id,x.code,decode(x.type,'B',x.id||' ','')||x.name||decode(x.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",NoofTradeDay,turnover from (
select id,sum(NoofTradeDay)NoofTradeDay,sum(turnover)turnover from (
select m.id,n.code,NoofTradeDay,name,turnover from(
select count(distinct tradedate)NoofTradeDay,code,sum(turnover) turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory where tradedate
between '01-Jul-2021' and '30-Jun-2022' and membercode in ('DSEGSL',
'DSEFER',
'DSEEBS',
'DSERIZ',
'DSESTB',
'DSEIST',
'DSEISL',
'DSESJB',
'DSEBSR',
'DSEEPS',
'DSEIBB',
'DSEUSB','DSELRK','DSEGQU') group by tradedate,membercode)a group by code order by code)n, member m where
n.code=m.code and m.id<333) group by id)y, member x where
y.id=x.id and y.id<333 and x.memstatus='A' order by turnover desc)g;



/*****************************Instrument avg howla for a certain period from starting date (cto sir)********************************/

select instrumentcode,round(sum(howla)/3,2) avghowla from (
with rws as (
  select
       row_number () over (
         partition by instrumentcode
         order by tradedate asc
       ) SLNo,tradedate,instrumentcode,howla
from   TRADECLOSEPRICE o where instrumentcode in (
select code from instrument where STARTDATE>= TO_DATE('23-09-2020','dd-mm-yyyy')
)
)
  select * from rws
  where  SLNo <= 3
  order  by instrumentcode, tradedate asc) group by instrumentcode;



select instrumentcode,round(sum(howla)/7,2) avghowla from (
with rws as (
  select
       row_number () over (
         partition by instrumentcode
         order by tradedate asc
       ) SLNo,tradedate,instrumentcode,howla
from   TRADECLOSEPRICE o where instrumentcode in (
select code from instrument where STARTDATE>= TO_DATE('23-09-2020','dd-mm-yyyy')
)
)
  select * from rws
  where  SLNo between 4 and 10
  order  by instrumentcode, tradedate asc) group by instrumentcode;



select instrumentcode,round(sum(trdvol)/7,2) avgtrdvol from (
with rws as (
  select
       row_number () over (
         partition by instrumentcode
         order by tradedate asc
       ) SLNo,tradedate,instrumentcode,trdvol
from   TRADECLOSEPRICE o where instrumentcode in (
select code from instrument where STARTDATE>= TO_DATE('23-09-2020','dd-mm-yyyy')
)
)
  select * from rws
  where  SLNo between 4 and 10
  order  by instrumentcode, tradedate asc) group by instrumentcode;


/**********************************Other query*******************************************************/


 select ROWNUM AS SLNO,"TREC NO",Name,TREC_CODE,type from (
 select id AS "TREC NO",name,code as TREC_CODE,TO_NUMBER(TRIM(LEADING 0 FROM 
 SUBSTR(ID,
 DECODE(LENGTH(ID),3,-3)||DECODE(LENGTH(ID),2,-2)||DECODE(LENGTH(ID),1,-1)||DECODE(LENGTH(ID),6,4),
 DECODE(LENGTH(ID),3,3)||DECODE(LENGTH(ID),2,2)||DECODE(LENGTH(ID),1,1)||DECODE(LENGTH(ID),6,3)
 )
 )) AS CODE,
 decode(m.type,'B','Broker')||decode(m.type,'D','Dealer','') AS
TYPE from member m order by CODE ASC,type)A;


select membercode, max(tradedate) from payreceivablehistory where tradedate between '18-Jan-2018'
and '19-Mar-2018' group by membercode order by MEMBERCODE;

select * from tradehistory where tradedate='19-Mar-2018';

select * from payreceivablehistory where tradedate='19-Mar-2018';

select p.membercode,max(tradedate) as lasttradedate,SLNO,"TREC NO",Name,type from 
(
 select ROWNUM AS SLNO,"TREC NO",Name,TREC_CODE,type from (
 select id AS "TREC NO",name,code as TREC_CODE,TO_NUMBER(TRIM(LEADING 0 FROM 
 SUBSTR(ID,
 DECODE(LENGTH(ID),3,-3)||DECODE(LENGTH(ID),2,-2)||DECODE(LENGTH(ID),1,-1)||DECODE(LENGTH(ID),6,4),
 DECODE(LENGTH(ID),3,3)||DECODE(LENGTH(ID),2,2)||DECODE(LENGTH(ID),1,1)||DECODE(LENGTH(ID),6,3)
 )
 )) AS CODE,
 decode(m.type,'B','Broker')||decode(m.type,'D','Dealer','') AS
TYPE from member m order by CODE ASC,type)A)B, PAYRECEIVABLEHISTORY p where b.TREC_CODE=p.MEMBERCODE group by p.MEMBERCODE;

select id AS "TREC NO",name,code as TREC_CODE,decode(m.type,'B','Broker')||decode(m.type,'D','Dealer','') AS
TYPE,membercode,lasttradedate,TO_NUMBER(TRIM(LEADING 0 FROM 
 SUBSTR(ID,
 DECODE(LENGTH(ID),3,-3)||DECODE(LENGTH(ID),2,-2)||DECODE(LENGTH(ID),1,-1)||DECODE(LENGTH(ID),6,4),
 DECODE(LENGTH(ID),3,3)||DECODE(LENGTH(ID),2,2)||DECODE(LENGTH(ID),1,1)||DECODE(LENGTH(ID),6,3)
 )
 )) AS TCODE from (select * from
(
select membercode, max(tradedate) as lasttradedate from payreceivablehistory where tradedate between '18-Jan-2018'
and '19-Mar-2018' group by membercode
))a, member m where m.code=a.membercode order by TCODE,type;


select id AS "TREC NO",name,code as TREC_CODE,decode(m.type,'B','Broker')||decode(m.type,'D','Dealer','') AS
TYPE,membercode,lasttradedate,TO_NUMBER(TRIM(LEADING 0 FROM 
 SUBSTR(ID,
 DECODE(LENGTH(ID),3,-3)||DECODE(LENGTH(ID),2,-2)||DECODE(LENGTH(ID),1,-1)||DECODE(LENGTH(ID),6,4),
 DECODE(LENGTH(ID),3,3)||DECODE(LENGTH(ID),2,2)||DECODE(LENGTH(ID),1,1)||DECODE(LENGTH(ID),6,3)
 )
 )) AS TCODE from (select * from
(
select membercode, max(tradedate) as lasttradedate from payreceivablehistory where tradedate>'18-Jan-2018' group by membercode
))a, member m where m.code=a.membercode order by TCODE,type;


----------------------------PMDD Data-------------------------------------------


select m.id as TRECNo,m.name as TRECName,Month, turnover from 
(
select TRECCODE,month,(BUY+SELL)as turnover from (
SELECT TRECCODE,month,SUM(buyonly) AS BUY,SUM(sellonly) AS SELL FROM
(
SELECT BUYERCODE as TRECCODE,to_char(tradedate,'yyyy-mm') as Month, SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
FROM tradehistory
WHERE tradedate BETWEEN '01-Jan-2019' AND '31-Dec-2019'
AND
( SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N')) 
AND isinvalid='N'
group by BUYERCODE,tradedate 
union all
SELECT SELLERCODE AS TRECCODE,to_char(tradedate,'yyyy-mm') as Month, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
FROM tradehistory
WHERE tradedate BETWEEN '01-Jan-2019' AND '31-Dec-2019'
AND
( SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
AND isinvalid='N' GROUP BY SELLERCODE,tradedate) GROUP BY TRECCODE,Month))n,member m where n.TRECCODE=m.code order by Month,id;  




/*------------------------Clearing Account Query-----------------------------------------

Details Query where turnover =(Total buy with spot market + Foreign sale – DVP buy) 

-------------------------------------------------------------------------------------*/

select tradedate ,m.id,m.name,n.id as code,n.turnover  from member m,(

select a.*,a.totalbuy+b.bkrfs as turnover from (

select tradedate, substr(membercode,4,6) as id,sum(buyprice) as totalbuy from payreceivablehistory where tradedate between '26-Jul-2020' and '5-Aug-2020' and membercode<>'DSEMGT' GROUP BY tradedate,substr(membercode,4,6)

) a,margindetail b where a.id=b.memcode and a.tradedate=b.tradedate ) n where 'DSE'||n.id=m.code order by tradedate,m.id

/*---------------------------------------------------------------------------------------- 
 Avg,max, min Query where turnover =(Total buy with spot market + Foreign sale – DVP buy) 
------------------------------------------------------------------------------------------*/

select id,name,round(avg(turnover),2) as avg_turnover,round(max(turnover),2) as max_turnover,round(min(turnover),2) as min_turnover from (
select tradedate ,m.id,m.name,n.id as code,n.turnover  from member m,(
select a.*,a.totalbuy+b.bkrfs as turnover from (
select tradedate, substr(membercode,4,6) as id,sum(buyprice) as totalbuy from payreceivablehistory where 
tradedate between '1-Jul-2018' and '30-Jun-2020' and membercode<>'DSEMGT' GROUP BY tradedate,substr(membercode,4,6)
) a,margindetail b where a.id=b.memcode and a.tradedate=b.tradedate ) n where 'DSE'||n.id=m.code order by tradedate,m.id)a
group by id,name,code order by id;


-------------------------------------Kamrul vi Thu 7/15/2021 3:46 PM-------------------


select tradedate,id as "TREC HOLDER NUMBER",name as "TREC HOLDER COMPANY NAME",totalbuy as margin
 from(
select tradedate,memcode,sum(bkrbuy+dlrbuy+bkrfs) totalbuy 
from margindetail
where tradedate between '01-Jan-2021' and '30-Jun-2021'
group by tradedate,memcode)n, member m where 'DSE'||n.memcode=m.code
AND totalbuy>100000000
ORDER BY TRADEDATE,ID;


/*------------------------------------------------------------------------------------------------------------
1. Average trade per day date 25.7.2022 (buy+foreign sale-DVP-spot) by kamrul vi
------------------------------------------------------------------------------------------------------------*/


select "TREC HOLDER NUMBER",o.memcode,"TREC HOLDER COMPANY NAME",totaltradingday,avgturnover
 from(
select id as "TREC HOLDER NUMBER",memcode,name as "TREC HOLDER COMPANY NAME",turnover as avgturnover
 from(
select memcode,round(avg(totalbuy),2) as turnover
 from(
select tradedate,memcode,sum(memmarginon) totalbuy 
from margindetail
where tradedate between '01-Jan-2022' and '30-Jun-2022'
group by tradedate,memcode)group by memcode)n, member m where 'DSE'||n.memcode=m.code 
)o,(select memcode,count(distinct tradedate) totaltradingday from margindetail
where tradedate between '01-Jan-2022' and '30-Jun-2022' group by memcode)p where p.memcode=o.memcode
ORDER BY "TREC HOLDER NUMBER";



-----------------------------------Kamrul vi on 20 Dec 2021-------------------------------------------------


/*------
1.       Average trade per day (greater than 10 Crore):
Sl.# 	TREC ID	TREC Name	Total Trading day	Average turnover per day
----*/

select "TREC HOLDER NUMBER",o.memcode,"TREC HOLDER COMPANY NAME",totaltradingday,avgturnover
 from(
select id as "TREC HOLDER NUMBER",memcode,name as "TREC HOLDER COMPANY NAME",turnover as avgturnover
 from(
select memcode,round(avg(totalbuy),2) as turnover
 from(
select tradedate,memcode,sum(bkrbuy+dlrbuy+bkrfs) totalbuy 
from margindetail
where tradedate between '01-Nov-2020' and '30-Nov-2021'
group by tradedate,memcode)group by memcode)n, member m where 'DSE'||n.memcode=m.code 
AND turnover>100000000)o,(select memcode,count(distinct tradedate) totaltradingday from margindetail
where tradedate between '01-Nov-2020' and '30-Nov-2021' group by memcode)p where p.memcode=o.memcode
ORDER BY "TREC HOLDER NUMBER";


/*------
2.       How many times they have crossed the following limit:
Sl.# 	TREC ID	TREC Name	Total Trading day	Number of time (Turnover 10 Crore to 13 Crore)
----*/


select id,p.memcode,name,"Number of Time","Total Trading Day" from (
select id,name,memcode,count(*) "Number of Time" from (
select tradedate,memcode,id,name,turnover
 from(
select tradedate,memcode,sum(bkrbuy+dlrbuy+bkrfs) turnover
from margindetail
where tradedate between '01-Nov-2020' and '30-Nov-2021'
group by tradedate,memcode)n, member m where 'DSE'||n.memcode=m.code
AND (turnover>=100000000 and turnover<=130000000) order by memcode) group by id,name,memcode)o,
(select memcode,count(distinct tradedate) "Total Trading Day" from margindetail
where tradedate between '01-Nov-2020' and '30-Nov-2021' group by memcode)p where p.memcode=o.memcode order by id;



/*------
3.       TREC Holder who did not crossed 10 Crore:
Sl.# 	TREC ID	TREC Name	Total Trading day	Highest turnover 
----*/

select id,p.memcode,name,"Total Trading Day",HighestTurnover from (
select id,memcode,name,max(turnover) as HighestTurnover from(
select tradedate,memcode,id,name,turnover
 from(
select tradedate,memcode,sum(bkrbuy+dlrbuy+bkrfs) turnover
from margindetail
where tradedate between '01-Nov-2020' and '30-Nov-2021'
group by tradedate,memcode)n, member m where 'DSE'||n.memcode=m.code
AND (turnover<100000000 ) order by memcode,turnover desc) group by memcode,id,name)o,
(select memcode,count(distinct tradedate) "Total Trading Day" from margindetail
where tradedate between '01-Nov-2020' and '30-Nov-2021' group by memcode)p where p.memcode=o.memcode order by id;


---------------------------------------------Dt. Wed 1/6/2021 2:48 PM-----------------


/*------
1.
----*/

select rownum as rank,x.* from (
select id,name,tradedate,brokerturnover ,totalturnover,round((brokerturnover /totalturnover)*100,2) as percent from(
select id,name,tradedate,brokerturnover from(

select to_char(tradedate,'Mon-yyyy') as tradedate,substr(membercode,4.6) as code,sum(buyprice+sellprice)/2 as brokerturnover
from payreceivablehistory where
to_char(tradedate,'mm-yyyy')='12-2020' group by substr(membercode,4.6),to_char(tradedate,'Mon-yyyy')

) a,member b where b.code = 'DSE'||a.code and b.ID<>333 order by 3 desc)c,(select sum(buyprice+sellprice)/2 as totalturnover from
payreceivablehistory where
to_char(tradedate,'mm-yyyy')='12-2020')d order by brokerturnover desc) x where rownum <=20


/*------
2. 
----*/

select a.tradedate,Investor,buyvalue,sellvalue,turnover,totturnover,round((turnover/totturnover)*100,2) as "%To Total" from(
select tradedate, type as Investor,buyvalue,sellvalue,(buyvalue+sellvalue)/2 as turnover
                         from(
                         select tradedate, decode(type,'D','Dealer','F','Foreign','I','Institution','M','Omnibus','N','Normal','O',
                         'Others','R','NRB','-') as type,
                         round(sum(buyvalue),2) as buyvalue,round(sum(sellvalue),2) as sellvalue from(
                         select to_char(tradedate,'Mon-yyyy') as tradedate, frbuyer as type,
                         sum(tradeprice*tradevolume) as buyvalue,0 as sellvalue
                         from tradehistory where
                         tradedate between '1-Jan-2020' and '31-Dec-2020' and isinvalid='N' group by frbuyer,                         
                         buyercode||buyerclient,to_char(tradedate,'Mon-yyyy')
                         union all
                         select to_char(tradedate,'Mon-yyyy') as tradedate, frseller as type,0 as buvalue,
                         sum(tradeprice*tradevolume) as sellvalue from tradehistory where tradedate between '1-Jan-2020' and '31-Dec-2020' and
                         isinvalid='N' group by frseller,sellercode||sellerclient,to_char(tradedate,'Mon-yyyy')
                         ) where type in ('I','N') group by type,tradedate) order by tradedate,investor)a,                         
                         (select to_char(tradedate,'Mon-yyyy') as tradedate,sum(buyprice+sellprice)/2  as totturnover
from PAYRECEIVABLEHISTORY where  tradedate between '1-Jan-2020' and '31-Dec-2020' group by to_char(tradedate,'Mon-yyyy'))b
where a.tradedate=b.tradedate order by tradedate,investor


/*------ Broker wise TRADEDATE	CODE	NAME	BRK_BUYORDER	BRK_SELLORDER	DLR_BUYORDER	
DLR_SELLORDER	TOT_BKR_ORDER	TOT_DLR_ORDER	TOT_TREC_ORDER	NUMBEROFTRADE for given brokers
--------------------------------------Dt. Tue 6/8/2021 10:11 AM-----------------
----*/

--Detail Query:


select tradedate,c.code,name,brk_buyorder,brk_sellorder,dlr_buyorder,dlr_sellorder ,TOT_BKR_ORDER,
TOT_DLR_ORDER,TOT_TREC_ORDER,numberoftrade from(
select a.*,numberoftrade from (
select tradedate,code,brk_buyorder,brk_sellorder,dlr_buyorder,dlr_sellorder ,(brk_buyorder+brk_sellorder) TOT_BKR_ORDER,
(dlr_buyorder+dlr_sellorder) TOT_DLR_ORDER,
(brk_buyorder+brk_sellorder+dlr_buyorder+dlr_sellorder) TOT_TREC_ORDER
 from(
select tradedate,code,sum(brk_buyorder) as brk_buyorder,sum(brk_sellorder) brk_sellorder,sum(dlr_buyorder) dlr_buyorder,
sum(dlr_sellorder) dlr_sellorder from(
select tradedate,substr(code,4,3) as code,brk_buyorder,brk_sellorder,dlr_buyorder,
dlr_sellorder from(
select  tradedate,BUYERCODE as code,count(*) as brk_buyorder ,0 as brk_sellorder,0 as dlr_buyorder,0 as dlr_sellorder
from tradehistory where tradedate between '01-May-2021' and '31-May-2021' and
buyercode like '%DSE%' AND buyercode<>'DSEMGT'
group by tradedate,buyercode
union all
select  tradedate,BUYERCODE as code,0 as brk_buyorder,0 as brk_sellorder,count(*) as dlr_buyorder,0 as dlr_sellorder
from tradehistory where tradedate between '01-May-2021' and '31-May-2021' and
buyercode like '%DLR%'
group by tradedate,buyercode
union all
select  tradedate,sellercode as code,0 as brk_buyorder,count(*) as brk_sellorder,0 as dlr_buyorder,0 as dlr_sellorder
from tradehistory where tradedate between '01-May-2021' and '31-May-2021' and
sellercode like '%DSE%' AND sellercode<>'DSEMGT'
group by tradedate,sellercode
union all
select  tradedate,sellercode as code,0 as brk_buyorder,0 as brk_sellorder,0 as dlr_buyorder,count(*) as dlr_sellorder
from tradehistory where tradedate between '01-May-2021' and '31-May-2021' and
sellercode like '%DLR%'
group by tradedate,sellercode)) where code in ('LAN',
'UBR',
'ISL',
'IST',
'EPS',
'UFT',
'BAL',
'RCL',
'LRK',
'MTB'
)  group by tradedate,code)order by code,tradedate)a,
(select tradedate,count(*) as numberoftrade from tradehistory where tradedate between
'01-May-2021' and '31-May-2021' group by tradedate)b where b.tradedate=a.tradedate)c,member d where d.code = 'DSE'||c.code and d.ID<>333;


--Summary


select rownum as slno,x.* from (
select month,id,name,c.code,brk_buyorder,brk_sellorder,
dlr_buyorder,dlr_sellorder,tot_brkorder,tot_dlrorder,
tot_trec_order, numberoftrade,nooftradingday from (
select month,code,brk_buyorder,brk_sellorder,
dlr_buyorder,dlr_sellorder,tot_brkorder,tot_dlrorder,
tot_trec_order, numberoftrade,nooftradingday from (
select code,brk_buyorder,brk_sellorder,
dlr_buyorder,dlr_sellorder,tot_brkorder,tot_dlrorder,
tot_trec_order, numberoftrade from(
select code,brk_buyorder,brk_sellorder,
dlr_buyorder,dlr_sellorder,(brk_buyorder+brk_sellorder) as tot_brkorder,(dlr_buyorder+dlr_sellorder) as tot_dlrorder,
(brk_buyorder+dlr_buyorder+brk_sellorder+dlr_sellorder) as tot_trec_order from (
select code,sum(brk_buyorder) as brk_buyorder,sum(brk_sellorder) as brk_sellorder,
sum(dlr_buyorder) as dlr_buyorder,sum(dlr_sellorder) as dlr_sellorder from(
select substr(code,4,3) as code,brk_buyorder,brk_sellorder,dlr_buyorder,
dlr_sellorder from (
select distinct BUYERCODE as code,count(*) as brk_buyorder,0 as brk_sellorder,0 as dlr_buyorder,0 as dlr_sellorder
from tradehistory where tradedate between '01-Feb-2021' and '28-Feb-2021' and
buyercode like '%DSE%' AND buyercode<>'DSEMGT'
group by buyercode
union all
select distinct BUYERCODE as code,0 as brk_buyorder,0 as brk_sellorder,count(*) as dlr_buyorder,0 as dlr_sellorder
from tradehistory where tradedate between '01-Feb-2021' and '28-Feb-2021' and
buyercode like '%DLR%'
group by buyercode
union all
select distinct sellercode as code,0 as brk_buyorder,count(*) as brk_sellorder,0 as dlr_buyorder,0 as dlr_sellorder
from tradehistory where tradedate between '01-Feb-2021' and '28-Feb-2021' and
sellercode like '%DSE%' AND sellercode<>'DSEMGT'
group by sellercode
union all
select distinct sellercode as code,0 as brk_buyorder,0 as brk_sellorder,0 as dlr_buyorder,count(*) as dlr_sellorder
from tradehistory where tradedate between '01-Feb-2021' and '28-Feb-2021' and
sellercode like '%DLR%'
group by sellercode
)) group by code))a,
(select count(*) as numberoftrade from tradehistory where tradedate between '01-Feb-2021' and '28-Feb-2021'))b,
(select count(distinct tradedate) as nooftradingday,to_char(tradedate,'Mon-yyyy') as month from PAYRECEIVABLEHISTORY
where tradedate between '01-Feb-2021' and '28-Feb-2021' group by to_char(tradedate,'Mon-yyyy')
)order by tot_brkorder desc)c,member d where d.code = 'DSE'||c.code and d.ID<>333
)x where rownum <=10;


------------------------------Broker wise turnover for a given period  Dt. Wed 5/12/2021 12:39 PM------------------------

select * from (
select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,16-Apr,17') as duration,turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2016' and '30-Apr-2017' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<333

union all

select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,17-Apr,18') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2017' and '30-Apr-2018' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<333

union all

select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,18-Apr,19') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2018' and '30-Apr-2019' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<333

union all

select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,19-Apr,20') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2019' and '30-Apr-2020' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<333

union all

select m.id as memid,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,20-Apr,21') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2020' and '30-Apr-2021' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id<333)a where memid in (7,
22,
26,
27,
44,
63,
67,
81,
85,
99,
118,
131,
140,
150,
157,
160,
162,
163,
164,
170,
171,
181,
183,
185,
206,
207,
233,
234
) order by memid asc;


------------------Dealer---------------------------

select memid,"NAME OF THE MEMBER'S COMPANY",duration,turnover from (
select m.id as memid,n.code,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,16-Apr,17') as duration,turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory where tradedate
between '01-May-2016' and '30-Apr-2017' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id>333

union all

select m.id as memid,n.code,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,17-Apr,18') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2017' and '30-Apr-2018' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id>333

union all

select m.id as memid,n.code,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,18-Apr,19') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2018' and '30-Apr-2019' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id>333

union all

select m.id as memid,n.code,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,19-Apr,20') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2019' and '30-Apr-2020' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id>333

union all

select m.id as memid,n.code,decode(m.type,'B',m.id||' ','')||m.name||decode(m.type,'D',' (DEALER)','') AS "NAME OF THE MEMBER'S COMPANY",
TO_CHAR('May,20-Apr,21') as duration,
turnover from (
select code,sum(turnover) as turnover from (
select tradedate,membercode as code,sum((buyprice+sellprice)) as turnover from payreceivablehistory
where tradedate between '01-May-2020' and '30-Apr-2021' group by tradedate,membercode) group by code
) n, member m where n.code=m.code and m.id>333)a where a.code in ('DLRSNM',
'DLRARC',
'DLRLRK',
'DLRSAR',
'DLRMSL',
'DLRBAN',
'DLRSIN',
'DLRTMH',
'DLRDEM',
'DLRCSL',
'DLRSAA',
'DLRHSL',
'DLRHED',
'DLRNES',
'DLRGAT',
'DLRANW',
'DLRTAC',
'DLRUCS',
'DLRMFC',
'DLRFSL',
'DLRSAG',
'DLRUBR',
'DLRSHE',
'DLRMRA',
'DLRMEL',
'DLRUSB',
'DLRSJB',
'DLRAIB'
) order by memid asc;


------------Daily avg trade broker wise for mobile- Dt. Sun 4/25/2021 3:57 PM--------------------


select a.tradedate,buyamount as buy,round(buyamount/total*100,2) as "BUY %",sellamount as sell,round(sellamount/total*100,2) as "SELL %" from(
select tradedate,buyamount,sellamount from mis_data where tradedate between '22-Apr-2021' and '22-Apr-2021' and type='p' and title='Mobile') a,
(select tradedate,sum(buyprice) as total from payreceivable where tradedate between '22-Apr-2021' and '22-Apr-2021' group by tradedate) b where
a.tradedate=b.tradedate order by tradedate




---------------DTREC Holder Turnover in the month of March-2021 query including dealer -Sun 4/25/2021 3:57 PM-----------------------

--Query including dealer

select m.id AS TRECID,name AS
"TREC Name",membercode,dailyavgtrade from (
select membercode,dailyavgtrade from (
select membercode,round(turnover/totalTrade,2) as dailyavgtrade from(
select membercode,turnover,totalTrade from(
select membercode,turnover from(
select SUBSTR(membercode,4,3) as  membercode,sum((buyprice+sellprice)) as turnover from PAYRECEIVABLE where tradedate
between '01-Mar-2021' and '31-Mar-2021'  GROUP BY SUBSTR(membercode,4,3))a)b,
(select count(distinct tradedate) as totalTrade from PAYRECEIVABLE where tradedate
between '01-Mar-2021' and '31-Mar-2021'))c)d where dailyavgtrade<30000000)e,
member m where m.code='DSE'||e.membercode order by id;



--only broker


select m.id AS TRECID,name AS
"TREC Name",membercode,dailyavgtrade from (
select membercode,dailyavgtrade from (
select membercode,round(turnover/totalTrade,2) as dailyavgtrade from(
select membercode,turnover,totalTrade from(
select membercode,turnover from(
select membercode,sum((buyprice+sellprice)) as turnover from PAYRECEIVABLE where tradedate
between '01-Mar-2021' and '31-Mar-2021'  GROUP BY membercode)a where membercode like 'DSE%')b,
(select count(distinct tradedate) as totalTrade from PAYRECEIVABLE where tradedate
between '01-Mar-2021' and '31-Mar-2021'))c)d where dailyavgtrade<30000000)e,
member m where m.code=e.membercode order by id;


----------------G-sec trade (shofiq saheb)-------------

select tradedate,buyercode, buyername,sellercode,n.name sellername,tradevolume,tradevalue from (
select tradedate,buyercode,m.name buyername,sellercode,tradevolume,tradevalue from (
select tradedate,buyercode,sellercode,sum(tradevolume) tradevolume,sum(tradevolume*tradeprice) tradevalue from 
tradehistory where acc_interest>0 and tradedate between '1-OCT-22' and '09-Jul-23'  group by tradedate,buyercode,sellercode)a,member m 
where m.code=a.buyercode)b,member n where n.code=b.sellercode  order by tradedate;


select tradedate,instrumentcode,name instrumentname,tradevolume,tradevalue,buyercode, buyername,sellercode,sellername from (
select tradedate,buyercode, buyername,sellercode,n.name sellername,instrumentcode,tradevolume,tradevalue from (
select tradedate,buyercode,m.name buyername,sellercode,instrumentcode,tradevolume,tradevalue from (
select tradedate,buyercode,sellercode,instrumentcode,tradevolume,tradevolume*tradeprice tradevalue from 
tradehistory where acc_interest>0 and tradedate between '1-OCT-22' and '09-Jul-23')a,member m 
where m.code=a.buyercode)b,member n where n.code=b.sellercode)c,instrument i where i.code=c.instrumentcode  order by tradedate;



--------------------------------Surveillance Data Monthly---------------------


--foreign date wise

select trdate as "Date", buy as "Foreign Buy", sell as "Foreign Sell", (buy+sell) as "Total Foreign Turnover",round((buy+sell)/total_turnover*100,2) as "% to Total", (buy-sell) as "Net Buy/(Sell)" from(
                select trdate, SUM(buyonly) buy, SUM(sellonly) sell,total_turnover from(
                                SELECT TO_CHAR(tradedate,'dd.mm.yy') AS trdate, SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-12'
                                AND
                                ( SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
                               AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'dd.mm.yy')
                                UNION ALL
                                SELECT TO_CHAR(tradedate,'dd.mm.yy') AS trdate, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-12'
                                AND
                                ( SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'dd.mm.yy')
                ) a, (select tradedate,sum(buyprice+sellprice) as total_turnover from payreceivable where to_char(tradedate,'yyyy-mm') ='2020-12' group by tradedate)
                b where a.trdate=to_char(b.tradedate,'dd.mm.yy')  group by trdate,total_turnover
) order by trdate ASC;


--foreign broker wise

select trdate,code as "Broker Code", buy as "Foreign Buy", sell as "Foreign Sell", (buy+sell) as "Total Turnover", (buy-sell) as "Net Buy/(Sell)" from(
                select trdate, code,SUM(buyonly) buy, SUM(sellonly) sell from(
                                SELECT TO_CHAR(tradedate,'Mon-yyyy') AS trdate,  SUBSTR(buyercode,4,3) as code,SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND
                                ( SUBSTR(buyercode,4,3)||buyerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
                               AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'Mon-yyyy'),SUBSTR(buyercode,4,3)
                                UNION ALL
                                SELECT TO_CHAR(tradedate,'Mon-yyyy') AS trdate,  SUBSTR(sellercode,4,3) as code, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND
                                ( SUBSTR(sellercode,4,3)||sellerclient IN (SELECT membercode||trim(foreignclient) FROM marginforeignclient WHERE isdeleted='N') )
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'Mon-yyyy'),SUBSTR(sellercode,4,3)
                ) group by trdate,code
) order by code ASC;



---Inst_total

select trdate as "Date", buy as "Inst Buy", sell as "Inst Sell", (buy+sell) as "Total Inst Turnover",round((buy+sell)/total_turnover*100,2) as "% to Total", (buy-sell) as "Net Buy/(Sell)" from(
                select trdate, SUM(buyonly) buy, SUM(sellonly) sell,total_turnover from(
                                SELECT TO_CHAR(tradedate,'dd.mm.yy') AS trdate, SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND
                                ( SUBSTR(buyercode,4,3)||TRIM(UPPER(buyerclient)) IN (SELECT membercode||trim(UPPER(clientcode)) FROM inst_client WHERE isdeleted='N') )
                               AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'dd.mm.yy')
                                UNION ALL
                                SELECT TO_CHAR(tradedate,'dd.mm.yy') AS trdate, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND
                                ( SUBSTR(sellercode,4,3)||TRIM(UPPER(SELLERCLIENT)) IN (SELECT membercode||trim(UPPER(clientcode)) FROM inst_client WHERE isdeleted='N') )
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'dd.mm.yy')
                ) a, (select tradedate,sum(buyprice+sellprice) as total_turnover from payreceivable where to_char(tradedate,'yyyy-mm') ='2020-11' group by tradedate)
                b where a.trdate=to_char(b.tradedate,'dd.mm.yy')  group by trdate,total_turnover
) order by trdate ASC;


--inst broker wise

select trdate,code as "Broker Code", buy as "Inst Buy", sell as "Inst Sell", (buy+sell) as "Total Turnover", (buy-sell) as "Net Buy/(Sell)" from(
                select trdate, code,SUM(buyonly) buy, SUM(sellonly) sell from(
                                SELECT TO_CHAR(tradedate,'Mon-yyyy') AS trdate,  SUBSTR(buyercode,4,3) as code,SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND
                               ( SUBSTR(buyercode,4,3)||TRIM(UPPER(buyerclient)) IN (SELECT membercode||trim(UPPER(clientcode)) FROM inst_client WHERE isdeleted='N') )
                               AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'Mon-yyyy'),SUBSTR(buyercode,4,3)
                                UNION ALL
                                SELECT TO_CHAR(tradedate,'Mon-yyyy') AS trdate,  SUBSTR(sellercode,4,3) as code, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11' and
                               ( SUBSTR(sellercode,4,3)||TRIM(UPPER(SELLERCLIENT)) IN (SELECT membercode||trim(UPPER(clientcode)) FROM inst_client WHERE isdeleted='N') )
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'Mon-yyyy'),SUBSTR(sellercode,4,3)
                ) group by trdate,code
) order by code ASC;


--Dealer total

select trdate as "Date", buy as "Dealer Buy", sell as "Dealer Sell", (buy+sell) as "Total Dealer Turnover",round((buy+sell)/total_turnover*100,2) as "% to Total", (buy-sell) as "Net Buy/(Sell)" from(
                select trdate, SUM(buyonly) buy, SUM(sellonly) sell,total_turnover from(
                                SELECT TO_CHAR(tradedate,'dd.mm.yy') AS trdate, SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11' and buyercode like 'DLR%'
                                AND
                                isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'dd.mm.yy')
                                UNION ALL
                                SELECT TO_CHAR(tradedate,'dd.mm.yy') AS trdate, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND SELLERCODE like 'DLR%'
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'dd.mm.yy')
                ) a, (select tradedate,sum(buyprice+sellprice) as total_turnover from payreceivable where to_char(tradedate,'yyyy-mm') ='2020-11' group by tradedate)
                b where a.trdate=to_char(b.tradedate,'dd.mm.yy')  group by trdate,total_turnover
) order by trdate ASC;


-- Dealer broker wise
select trdate,code as "Broker Code", buy as "Dealer Buy", sell as "Dealer Sell", (buy+sell) as "Total Turnover", (buy-sell) as "Net Buy/(Sell)" from(
                select trdate, code,SUM(buyonly) buy, SUM(sellonly) sell from(
                                SELECT TO_CHAR(tradedate,'Mon-yyyy') AS trdate,  buyercode as code,SUM(tradevolume*tradeprice) AS buyonly, 0 as sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                AND buyercode like 'DLR%'
                               AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'Mon-yyyy'),buyercode
                                UNION ALL
                                SELECT TO_CHAR(tradedate,'Mon-yyyy') AS trdate, sellercode as code, 0 as buyonly, SUM(tradevolume*tradeprice) AS sellonly
                                FROM tradedata
                                WHERE to_char(tradedate,'yyyy-mm') ='2020-11'
                                and sellercode like 'DLR%'
                                AND isinvalid='N'
                                GROUP BY TO_CHAR(tradedate,'Mon-yyyy'),sellercode
                ) group by trdate,code
) order by code ASC;


/**********************************Payout check of suspended broker(like DSETMH on '30-Nov-2021')************************/

select a.*,c.id from(
select substr(data,25,16) as boid,substr(data,47,12) as isin, to_number(substr(data,59,12)) as qty from test1) a,temptradecloseprice b,instrument c 
where trim(b.instrumentcode)=c.code and b.isin=a.isin;

select tradedate, instrumentcode,id,buyercode,buyerclient,boidbuyer,sum(tradevolume) volume,scrippayout from tradedata a,instrument b 
where a.INSTRUMENTCODE=b.CODE and  buyercode='DSETMH' AND PAYOUT='30-Nov-2021' 
GROUP BY  tradedate, instrumentcode,buyercode,buyerclient,boidbuyer,scrippayout,id;



/**************************************CnS Tax Query*************************************/


select 0 as CONTRACT_NUMBER, TO_CHAR(SYSDATE,'dd/mm/yyyy') as PAYMENT_DATE, TIN AS DEDUCTEE_TIN, '53BBB' AS SECTION_NUMBER,
TURNOVER AS TOTAL_TURNOVER, 0 AS COMMISSION FROM (
select b.id as "TREC HOLDER NO",name AS "TREC HOLDER COMPANY",tin_new AS TIN, b.turnover-nvl(a.turnover,0) as TURNOVER,b.totaltax-nvl(a.tax,0) as tax from (
select member,sum(trades) trades,sum(turnover) as turnover,sum(tax) as tax from(
select buyercode as member, count(*) as trades,sum(tradevolume*tradeprice) as turnover,sum(tax) as tax from tradedata t,INSTrUMENT i
where T.INSTRUMENTCODE = i.code and  tradedate between '1-Jul-2022' and '31-Jul-2022' and instrumenttype = 'CB' group by buyercode
union all
select sellercode as member, count(*) as trades,sum(tradevolume*tradeprice) as turnover,sum(tax) as tax from tradedata t, instrument i
where T.INSTRUMENTCODE = i.code and  tradedate between  '1-Jul-2022' and '31-Jul-2022' and instrumenttype = 'CB'  group by sellercode
) group by member) a right outer join
(select id, membercode,name, turnover, totaltax,nvl(tin_new,'-') as tin_new  from taxreportdata
             where (id<=333 or id>200000) and mon='2022-07') b on a.member=b.membercode ORDER BY b.id
)
UNION ALL
select 0 as CONTRACT_NUMBER, TO_CHAR(SYSDATE,'dd/mm/yyyy') as PAYMENT_DATE, TIN AS DEDUCTEE_TIN, '53BBB' AS SECTION_NUMBER,
0 AS TOTAL_TURNOVER, COMMISSION FROM(
select id as "TREC HOLDER NO", NAME AS "TREC HOLDER NAME",b.tin_12_digit as tin,CHARGE AS TOTAL_TURNOVER,TRADES AS HOWLA, COMMISSION, TAX FROM (
select membercode,sum(howlacharge) as charge, sum(howlacharge)/50 as trades,(sum(howlacharge)/50 )*25  as commission,( (sum(howlacharge)/50 )*25)*0.1 as tax   
from payreceivable where 
tradedate between '1-Jul-2022' and '31-Jul-2022'   and howlacharge<>0 group by membercode) a,
member b where a.membercode=b.code  order by substr(lpad(to_char(id),6,'0'),4,6));


------------Foreign------------

select round(avg(turnover),2) avgturnoverForeign from(
select tradedate,sum(buyamount+sellamount) turnover from mis_data where tradedate between '01-Jul-2021' and '30-Jun-2022' and title='Foreign' group by tradedate);---216086794.55,.81%


------------Spot------------

select round(avg(turnover),2) avgturnoverSpot from(
select tradedate,sum(buyamount+sellamount) turnover from mis_data where tradedate between '01-Jul-2021' and '30-Jun-2022' and title='Spot' group by tradedate);--274048088.93,1.03%


------------Z group-----------

select round(avg(turnover),2) avgturnoverSpot from(
select tradedate,sum(buyamount+sellamount) turnover from mis_data where tradedate between '01-Jul-2021' and '30-Jun-2022' and title='Z' group by tradedate);--316111953.7,1.12%


------------Avg Turnover per date group-----------

select round(avg(turnover),2) avgturnover from(
select tradedate,sum(buyamount+sellamount) turnover from mis_data where tradedate between '01-Jul-2021' and '30-Jun-2022' and type='g' group by tradedate);

 -----------------------------------------TREC_OPER_CAT------------------------------------------------------

select * from CATEGORIES;
select * from TREC_OPER_CAT order by TREC_OPER_CAT_ID desc;
select TREC_OPER_CAT_STATUS, count(TREC_OPER_CAT_ID) as catid from TREC_OPER_CAT group by TREC_OPER_CAT_STATUS;

select * from TREC_OPER_CAT oc inner join CATEGORIES ct on ct.CATEGORIES_ID = oc.CATEGORIES_ID and oc.TREC_ID = 6295;

insert into TREC_OPER_CAT(TREC_OPER_CAT_ID,TREC_ID,CATEGORIES_ID, TREC_OPER_CAT_STATUS) values ((select max(TREC_OPER_CAT_ID)+1 from TREC_OPER_CAT), 6295,1, 'ACTIVE');
insert into TREC_OPER_CAT(TREC_OPER_CAT_ID,TREC_ID,CATEGORIES_ID, TREC_OPER_CAT_STATUS) values ((select max(TREC_OPER_CAT_ID)+1 from TREC_OPER_CAT), 6295,2, 'ACTIVE');
insert into TREC_OPER_CAT(TREC_OPER_CAT_ID,TREC_ID,CATEGORIES_ID, TREC_OPER_CAT_STATUS) values ((select max(TREC_OPER_CAT_ID)+1 from TREC_OPER_CAT), 6295,3, 'ACTIVE');
insert into TREC_OPER_CAT(TREC_OPER_CAT_ID,TREC_ID,CATEGORIES_ID, TREC_OPER_CAT_STATUS) values ((select max(TREC_OPER_CAT_ID)+1 from TREC_OPER_CAT), 6295,5, 'ACTIVE');


commit;


select * from TREC_OPER_CAT where TREC_ID = 6295 and TREC_OPER_CAT_ID =  734;
--delete from TREC_OPER_CAT where TREC_ID = 6295 and TREC_OPER_CAT_ID =  734;

------------------------------------------------------------------------------------------------------------

select TREC_ID, name,
(case when Full_Functional_Broker_Dealer = 1 and Wholesale_trading = 0  then 'insert into trec_oper_cat(trec_oper_cat_id, trec_id, categories_id, trec_oper_cat_status) values ((select max(trec_oper_cat_id)+1 from trec_oper_cat),'||TREC_ID||',1, ''ACTIVE'');' else ' ' end) as Wholesale_trading,
(case when Full_Functional_Broker_Dealer = 1 and Stock_Dealer = 0  then 'insert into trec_oper_cat(trec_oper_cat_id, trec_id, categories_id, trec_oper_cat_status) values ((select max(trec_oper_cat_id)+1 from trec_oper_cat),'||TREC_ID||',2, ''ACTIVE'');' else ' ' end) as Stock_Dealer,
(case when Full_Functional_Broker_Dealer = 1 and General_Stock_Broking = 0  then 'insert into trec_oper_cat(trec_oper_cat_id, trec_id, categories_id, trec_oper_cat_status) values ((select max(trec_oper_cat_id)+1 from trec_oper_cat),'||TREC_ID||',3, ''ACTIVE'');' else ' ' end) as General_Stock_Broking,
(case when Full_Functional_Broker_Dealer = 1 and Margin_Financing = 0  then 'insert into trec_oper_cat(trec_oper_cat_id, trec_id, categories_id, trec_oper_cat_status) values ((select max(trec_oper_cat_id)+1 from trec_oper_cat),'||TREC_ID||',4, ''ACTIVE'');' else ' ' end) as Margin_Financing,
(case when Full_Functional_Broker_Dealer = 1 and Dep_Prt_Clear_Part = 0  then 'insert into trec_oper_cat(trec_oper_cat_id, trec_id, categories_id, trec_oper_cat_status) values ((select max(trec_oper_cat_id)+1 from trec_oper_cat),'||TREC_ID||',5, ''ACTIVE'');' else ' ' end) as Dep_Prt_Clear_Part,
(case when Full_Functional_Broker_Dealer = 1 and Only_Stock_Dealer = 0  then 'insert into trec_oper_cat(trec_oper_cat_id, trec_id, categories_id, trec_oper_cat_status) values ((select max(trec_oper_cat_id)+1 from trec_oper_cat),'||TREC_ID||',6, ''ACTIVE'');' else ' ' end) as Only_Stock_Dealer
from (select TREC_ID, name,
sum(case when category ='Wholesale trading' then 1 else 0 end) as Wholesale_trading,
sum(case when category ='Stock Dealer' then 1 else 0 end) as Stock_Dealer,
sum(case when category ='General Stock Broking' then 1 else 0 end) as General_Stock_Broking,
sum(case when category ='Margin Financing' then 1 else 0 end) as Margin_Financing,
sum(case when category ='Depository Participant and Clearing Participant' then 1 else 0 end) as Dep_Prt_Clear_Part,
sum(case when category ='Only Stock Dealer' then 1 else 0 end) as Only_Stock_Dealer,
sum(case when category ='Full Functional Stock-Broker and Stock- Dealer' then 1 else 0 end) as Full_Functional_Broker_Dealer
from (SELECT T.TREC_ID as TREC_ID, T.name as NAME, c.categories_name as CATEGORY
FROM trec_oper_cat o join trec t on t.TREC_ID = o.TREC_ID join categories c on o.CATEGORIES_ID=c.CATEGORIES_ID)
group by TREC_ID, name
order by 1); 

------------------------------------------------------------------------------------------------------------


select trec_no, name,
(case when Wholesale_trading = 1 then 'Y' else 'N' end) as Wholesale_trading,
(case when Stock_Dealer = 1 then 'Y' else 'N' end) as Stock_Dealer,
(case when General_Stock_Broking  = 1 then 'Y' else 'N' end) as General_Stock_Broking,
(case when Margin_Financing = 1 then 'Y' else 'N' end) as Margin_Financing,
(case when Dep_Prt_Clear_Part = 1 then 'Y' else 'N' end) as Dep_Prt_Clear_Part,
(case when Only_Stock_Dealer = 1 then 'Y' else 'N' end) as Only_Stock_Dealer,
(case when Full_Functional_Broker_Dealer = 1 then 'Y' else 'N' end) as Full_Functional_Broker_Dealer
from (select trec_no, name,
sum(case when category ='Wholesale trading' then 1 else 0 end) as Wholesale_trading,
sum(case when category ='Stock Dealer' then 1 else 0 end) as Stock_Dealer,
sum(case when category ='General Stock Broking' then 1 else 0 end) as General_Stock_Broking,
sum(case when category ='Margin Financing' then 1 else 0 end) as Margin_Financing,
sum(case when category ='Depository Participant and Clearing Participant' then 1 else 0 end) as Dep_Prt_Clear_Part,
sum(case when category ='Only Stock Dealer' then 1 else 0 end) as Only_Stock_Dealer,
sum(case when category ='Full Functional Stock-Broker and Stock- Dealer' then 1 else 0 end) as Full_Functional_Broker_Dealer
from (SELECT T.TREC_NO as TREC_NO, t.name as NAME, c.categories_name as CATEGORY
FROM trec_oper_cat o join trec t on t.TREC_ID = o.TREC_ID join categories c on o.CATEGORIES_ID=c.CATEGORIES_ID)
group by trec_no, name
order by 1); 


 ------------------------------------------------------------------------------------------------------------

 
 
 
 
 
 
 

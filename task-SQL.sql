--task_SQL:

--1)


select count(P.ID) , 
       (select PRODUCTS.NAME
        from PRODUCTS
        where PRODUCTS.id=p.id)
from PRODUCTS P
join LOANS L 
on p.id=l.product_id
where p.is_active=1
and l.state=60
group by p.id

--2)

update PRODUCTS 
set PRODUCTS.name=TRIM(PRODUCTS.name)
where PRODUCTS.name like ' %'
or PRODUCTS.name like ' % '
or PRODUCTS.name like '% '

--3)

--disclaimer! : oracle-ის sql-ში მხოლოდ პირველი რიგის წამოღება ხდება ასე , mysql-ში კი უბრალოდ ბოლოს limit=1-ს დავუწერდით

select * from 
  (select TO_CHAR(L.REG_DATE,'YYYY')
   from LOANS L
   group by TO_CHAR(L.REG_DATE,'YYYY')
   order by count(L.LOAN_ID) desc)
where rownum=1

--4)

delete from LOANS 
       where LOANS.LOAN_ID in(select L.LOAN_ID
                              from LOANS L
                              join OPS O
                              on L.LOAN_ID=O.EXTRA_ID
                              where O.FOLDER_ID=0
                              and sysdate-L.REG_DATE >365)

--5)

select select L.CLIENT_ID ,C.LAST_NAME , C.CLIENT_TYPE , L.REG_DATE
from (select L.CLIENT_ID ,C.LAST_NAME , C.CLIENT_TYPE , L.REG_DATE 
      from LOANS L
      join CLIENTS C
      on L.CLIENT_ID=L.CLIENT_ID
      where L.STATE=60;
      and C.LAST_NAME like '%shvili')
where CLIENT_TYPE = 1
or REG_DATE > to_date('2021/01/01','YYYY/MM/DD')


--6)


select C.FIRST_NAME , C.LAST_NAME , L.LOAN_ID , P.NAME , O.AMOUNT
from CLIENTS C
join LOANS L
on C.CLIENT_ID = L.CLIENT_ID
join OPS O
on O.EXTRA_ID = L>LOAN_ID
join PRODUCTS P
on P.ID=L.PRODUCT_ID
where P.IS_ACTIVE=1
and L.LOAN_ID =(select LOAN_ID           --selects most recent single loan of given client
                from (select LOAN_ID
                     from LOANS L2
                     where L2.CLIENT_ID=L.CLIENT_ID
                     order by L2.REG_DATE desc)
                where rownum=1)
and L.LOAND_ID in(select O2.EXTRA_ID
                  from OPS O2                  
                  group by O2.EXTRA_ID
                  having count(O2.OP_ID)>1500)


 

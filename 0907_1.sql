-- 1-1
select bookname from BOOK where bookid = 1;

-- 1-2
select bookname from BOOK where price >= 20000;

-- 1-3
select sum(saleprice) as Total from ORDERS where ORDERS.custid = (select custid from CUSTOMER where name = '������');

-- 1-4
select count(bookid) as Total from ORDERS where ORDERS.custid = (select custid from CUSTOMER where name = '������');

-- 2-1
select count(bookname) as "������ �Ѽ�" from book;

-- 2-2
select count(distinct publisher)as "���ǻ� �Ѽ�" from BOOK;

-- 2-3
select name, address from CUSTOMER;

-- 2-4
select orderid from ORDERS where orderdate between '20/07/04' and '20/07/07';

-- 2-5
select orderid from ORDERS where orderdate not between '20/07/04' and '20/07/07';

-- 2-6
select name, address from CUSTOMER where name like '��%';

-- 2-7
select name, address from CUSTOMER where name like '��_��';
-- ���տ����� : ������(union), ������(minus), ������(intercept)
-- ������ �����ڸ� ����� ������ �ֹ����� ���� ���� �̸��� ���ÿ�
select name from CUSTOMER 
minus select name from CUSTOMER where custid in(select custid from ORDERS);

-- ������ ������ ������� ���� ���
select name from CUSTOMER where custid not in (select custid from ORDERS);

-- exists : ���������� ����� �����ϴ� ��쿡�� true
-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ����Ͻÿ�
-- in ������ ���
select name, address from CUSTOMER where custid in (select distinct custid from ORDERS);

-- �������ΰ� �ߺ��� ����
select distinct name, address from CUSTOMER c, ORDERS o
where c.custid = o.custid;

-- exists ����� ���
select name, address from CUSTOMER c
where exists(select * from ORDERS o where c.custid = o.custid);


-- 1-5
select count(distinct publisher) from BOOK b, ORDERS o, CUSTOMER c where b.bookid = o.bookid and o.custid = c.custid and c.name = '������';

-- 1-6
select bookname, o.saleprice, price - saleprice from BOOK b, ORDERS o, CUSTOMER c where b.bookid = o.bookid and o.custid = c.custid and c.name = '������';

-- 1-7
select distinct bookname from BOOK b, ORDERS o, CUSTOMER c where b.bookid = o.bookid and o.custid = c.custid and not c.name = '������';


-- 2-8
select name from CUSTOMER where custid not in (select custid from ORDERS);

-- 2-9
select sum(saleprice), avg(saleprice) from ORDERS;

-- 2-10
select name, sum(saleprice) from ORDERS o, CUSTOMER c
where c.custid = o.custid group by name;

-- 2-11
select name, bookname from CUSTOMER c, ORDERS o, BOOK b 
where c.custid = o.custid and o.bookid = b.bookid order by name;

-- 2-12
select max(price - saleprice) from BOOK b, ORDERS o where b.bookid = o.bookid;

-- 2-13 > �� �𸣰���
select name from CUSTOMER c, ORDERS o where c.custid = o.custid; 
select avg(saleprice) from ORDERS;
select name, avg(saleprice) from CUSTOMER c, ORDERS o where c.custid = o.custid group by name;

select name from CUSTOMER c, ORDERS o where c.custid = o.custid group by name having avg(saleprice) > (select avg(saleprice) from ORDERS);
-- 2
select cs.name, s 
from (select custid, avg(saleprice) s from ORDERS group by custid) od, customer cs
where cs.custid = od.custid;
-- �ֹ� ������ �ִ� ���� �̸��� ������ ���űݾ��� ����� s��� �̸��ٿ� ����Ѵ�.

-- 3
select sum(saleprice) "total" from ORDERS od
where exists(select * from customer cs where custid <= 3 and cs.custid = od.custid);
-- ����ȣ 3������ �� �� �ֹ� ������ �ִ� ���� ���űݾ��� �հ踦 total�̶�� �̸��ٿ� ����Ѵ�.

-- å �̸��� �����̶�� �ܾ ���Ե� ������� ����Ͻÿ�.
select * from BOOK where bookname like '%�౸%';
create view v_book as select * from BOOK where bookname like '%�౸%';

-- �ּҿ� �����̶�� �ܾ ���Ե� �並 �����Ͻÿ�.
select * from customer where address like '%���ѹα�%';
create view v_customer as select * from customer where address like '%���ѹα�%';

-- �ֹ� ���̺��� ���̸�, �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��. 
-- �迬�� ���� ������ ������ �ֹ���ȣ, ������, �ֹ����� ����Ͻÿ�.
create view v_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select orderid, c.custid, c.name, o.bookid, b.bookname, saleprice, orderdate 
    from ORDERS o, CUSTOMER c, BOOK b
    where o.custid = c.custid and o.bookid = b.bookid;
select * from v_orders;
select orderid, bookname, saleprice from v_orders where name = '�迬��';

-- v_customer�並 ���ѹα��� �ƴ� ������ �ּҷ� ���� ������ �����Ͻÿ�.
create or replace view v_customer(custid, name, address)
as select custid, name, address from CUSTOMER
where address like '%����%';

-- �ǸŰ����� 20,000�� �̻��� ������ ������ȣ, �����̸�, ���̸�, ���ǻ�, �Ǹ� ������ �����ִ� highorders �並 �����Ͻÿ�.
create view highorders(������ȣ, �����̸�, ���̸�, ���ǻ�, �ǸŰ���)
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and b.bookid = o.bookid and saleprice >= 20000;
select * from highorders;

-- ������ �並 �̿��Ͽ� �Ǹŵ� ������ �̸��� ���� �̸��� ����ϴ� sql���� �ۼ��Ͻÿ�.
select bookname, name from highorders;

-- highorders �並 �����ϰ��� �Ѵ�. �ǸŰ��� �Ӽ��� �����ϴ� ����� �����Ͻÿ�. ���� �� �� sql�� �ٽ� ����.
create or replace view highorders(������ȣ, �����̸�, ���̸�, ���ǻ�, �ǸŰ���)
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and b.bookid = o.bookid;
select bookname, name from highorders;                                                                        
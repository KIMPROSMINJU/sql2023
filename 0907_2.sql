-- ���� �̸�, �ֹ��� ���� �ǸŰ����� �˻��Ͻÿ�.
select name, saleprice from CUSTOMER c, ORDERS o
where c.custid = o.custid;

-- ������ �ֹ��� ��� ������ ���Ǹž��� ���ϰ�, ������ ����
select name, sum(saleprice) from CUSTOMER c, ORDERS o
where c.custid = o.custid
group by c.name order by c.name;

-- ���� �̸��� �ֹ��� ������ �̸��� ���Ͻÿ�.
-- 3���� ���̺� ���� ��������
select name, bookname from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and o.bookid = b.bookid;

-- ���� ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
select name, bookname from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and o.bookid = b.bookid and b.price = 20000;

-- ���������� �ϰԵǸ� ���� �������� ���� ���� ���õ����� 
-- �ܺ������� �ϰԵǸ� ������ �Ǵ� ���̺��� ���� �������� ���� ������ �൵ �����ؼ� ������ش�.

--������ �������� ���� ���� �����Ͽ� ���̸��� �ֹ��� ������ �ǸŰ����� ����Ͻÿ�
select CUSTOMER.name, ORDERS.saleprice 
from CUSTOMER left outer join ORDERS on CUSTOMER.custid = ORDERS.custid;

--suv query (�μ� ����) : main query �ȿ� �ִ� query
-- ���� ������ ���� ��� �����̸��� ����Ͻÿ�.
select bookname from BOOK where price = (select max(price) from BOOK);

-- ���� ������ ���� �� ������ �̸��� ������ ����Ͻÿ�.
select bookname, price from BOOK where price in (select min(price) from BOOK);

-- ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�
select name from CUSTOMER where custid in (select distinct custid from ORDERS);

-- ���ѹ̵��� ������ ������ ������ ���� �̸��� ���
select name from CUSTOMER where custid in (select custid from ORDERS where bookid in (select bookid from BOOK where publisher = '���ѹ̵��'));
select name from CUSTOMER c, BOOK b, ORDERS o where c.custid = o.custid and o.bookid = b.bookid and b.publisher = '���ѹ̵��';
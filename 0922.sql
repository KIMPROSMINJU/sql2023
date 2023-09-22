-- ���� �̸��� ��ȭ��ȣ�� ����Ͻÿ�. (��, ��ȭ��ȣ�� ���� ���� ����ó �������� ����Ͻÿ�)
select name �̸�, nvl(phone, '����ó ����') ��ȭ��ȣ from CUSTOMER;
select rownum ����, name �̸�, nvl(phone, '����ó ����') ��ȭ��ȣ from CUSTOMER;

-- ����Ͽ��� ����, ����ȣ, �̸�, ��ȭ��ȣ�� ���� �θ� ����Ͻÿ�.
select rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ from CUSTOMER where rownum <= 2;

-- MYBOOK ���̺� ����
create table MYBOOK(
    bookid number not null primary key,
    price number
);

-- ����Ǹűݾ� ������ �ֹ��� ���� �ֹ���ȣ�� �Ǹűݾ��� ����Ͻÿ�.
select orderid, saleprice from ORDERS where saleprice <= (select avg(saleprice) from ORDERS);

-- �ֹ� ���� ����Ǹűݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ��� �ֹ���ȣ, ����ȣ, �Ǹűݾ��� ����Ͻÿ�.
select orderid �ֹ���ȣ, custid ����ȣ, saleprice �Ǹűݾ� from ORDERS mo
where saleprice > (select avg(saleprice) from orders so where mo.custid = so.custid);

-- ���ѹα��� �����ϴ� ������ �Ǹ��� ������ ���Ǹűݾ��� ����Ͻÿ�.
select sum(saleprice) ���Ǹűݾ� from ORDERS o where custid in (select custid from CUSTOMER where address like '%����%');

-- 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ����Ͻÿ�.
select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from ORDERS
where saleprice > (select max(saleprice) from ORDERS where custid = 3);

-- ���￡ �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�. ��, exist ������ ���
select sum(saleprice) ���Ǹž� from ORDERS mo
where exists(select * from customer c where address like '%����%' and mo.custid = c.custid);

-- ���� �Ǹűݾ��� �հ踦 ����Ͻÿ� (����ȣ, �Ǹ��հ�)
select custid, sum(saleprice) from ORDERS group by custid;

-- ���� �Ǹűݾ��� �հ踦 ����Ͻÿ� (����ȣ, �Ǹ��հ�)
select name, sum(saleprice) from ORDERS o, CUSTOMER c where o.custid = c.custid group by name;

-- �ֹ���Ͽ� å�̸��� ������ �� �ִ� Į���� �߰��Ͻÿ�.
alter table ORDERS add bookname varchar2(40);

update orders o set bookname = (select bookname from book b where b.bookid = o.bookid);

-- ����ȣ�� 2 ������ ����ȣ�� �̸��� ����Ͻÿ�
select custid ����ȣ, name �̸� from CUSTOMER where custid <= 2;

-- ����ȣ�� 2 ������ ���� �Ǹűݾ��� ����Ͻÿ�. ( ���̸��� ���� �Ǹž� ���)
select name, sum(saleprice) from (select custid, name from CUSTOMER where custid <= 2) c, ORDERS o
where c.custid = o.custid
group by name;


-- ������ �� ����
insert into MYBOOK values(1, 10000);
insert into MYBOOK values(2, 10000);
insert into MYBOOK(bookid) values(3);

select * from MYBOOK;


-- ����Ǯ��
-- 1
select * from MYBOOK; -- 1	10000 2	20000 3	(null)

-- 2
select bookid, NVL(price, 0) from MYBOOK; -- 1 10000 2 20000 3 0

-- 3
select * from MYBOOK where price is null; -- 3 (null)

-- 4
select * from MYBOOK where price = ''; -- 

-- 5
select bookid, price + 100 from MYBOOK; -- 1 10100 2 20100 3 (null)	

-- 6
select sum(price), avg(price), count(*) from MYBOOK where bookid >= 4; -- (null) (null) 0

-- 7
select count(*), count(price) from MYBOOK; -- 3 2

-- 8
select sum(price), avg(price) from MYBOOK; -- 30000 15000


-- ����Ǯ�� 2
-- 1
select * from BOOK; -- 1	�౸�� ����	�½�����	7000
                    -- 10	Olympic Champions	Pearson	13000
                    -- 2	�౸ �ƴ� ����	������	13000
                    -- 3	�౸�� ����	���ѹ̵��	22000
                    -- 4	���� ���̺�	���ѹ̵��	35000
                    -- 5	�ǰ� ����	�½�����	8000
                    -- 6	���� �ܰԺ� ���	�½�����	6000
                    -- 7	�߱��� �߾�	�̻�̵��	20000
                    -- 8	�߱��� ��Ź��	�̻�̵��	13000
                    -- 9	�ø��� �̾߱�	�Ｚ��	7500
-- 2
select * from BOOK where rownum <= 5; -- 1	�౸�� ����	�½�����	7000
                                      -- 10	Olympic Champions	Pearson	13000
                                      -- 2	�౸ �ƴ� ����	������	13000
                                      -- 3	�౸�� ����	���ѹ̵��	22000
                                      -- 4	���� ���̺�	���ѹ̵��	35000
                                      
-- 3
select * from BOOK where rownum <= 5 order by price; -- 1	�౸�� ����	�½�����	7000
                                                      -- 10	Olympic Champions	Pearson	13000
                                                      -- 2	�౸ �ƴ� ����	������	13000
                                                      -- 3	�౸�� ����	���ѹ̵��	22000
                                                      -- 4	���� ���̺�	���ѹ̵��	35000

-- 4
select * from (select * from BOOK order by price) b where rownum <= 5; -- 6	���� �ܰԺ� ���	�½�����	6000
                                                                        -- 1	�౸�� ����	�½�����	7000
                                                                        -- 9	�ø��� �̾߱�	�Ｚ��	7500
                                                                        -- 5	�ǰ� ����	�½�����	8000
                                                                        -- 10	Olympic Champions	Pearson	13000

-- 5
select * from (select * from BOOK where rownum <= 5) b order by price; -- 1	�౸�� ����	�½�����	7000
                                                                        -- 10	Olympic Champions	Pearson	13000
                                                                        -- 2	�౸ �ƴ� ����	������	13000
                                                                        -- 3	�౸�� ����	���ѹ̵��	22000
                                                                        -- 4	���� ���̺�	���ѹ̵��	35000

-- 6
select * from (select * from BOOK where rownum <= 5 order by price) b; -- 1	�౸�� ����	�½�����	7000
                                                                        -- 10	Olympic Champions	Pearson	13000
                                                                        -- 2	�౸ �ƴ� ����	������	13000
                                                                        -- 3	�౸�� ����	���ѹ̵��	22000
                                                                        -- 4	���� ���̺�	���ѹ̵��	35000


-- ����Ǯ�� 3
-- 1
select custid, (select address from CUSTOMER cs where cs.custid = od.custid) address, sum(saleprice) total
from ORDERS od
group by od.custid;

-- ABS(-15)
select ABS(-15) from dual; -- ABS�� ������ ����ϴ� �Լ��� 15�� ����Ѵ�.

-- CEIL(15.7)
select CEIL(15.7) from dual; -- CEIL�� �ݿø��� ���� ����ϴ� �Լ��� 16�� ����Ѵ�.

-- COS(3.14159)
select COS(3.14159) from dual; -- COS�� �ڻ��� ���� ����ϴ� �Լ��� -0.999999...�� ����Ѵ�

-- FLOOR(15.7)
select FLOOR(15.7) from dual; -- FLOOR�� ������ ���� ����ϴ� �Լ��� 15�� ����Ѵ�.

-- LOG(10, 100)
select LOG(10, 100) from dual; -- LOG�Լ��� ���� ���� ���� ������ �α׿����� ���� ����ϴ� �Լ��� 2�� ����Ѵ�.

-- MOD(11, 4)
select MOD(11, 4) from dual;

-- POWER(3, 2)
select POWER(3, 2) from dual; -- POWER �Լ��� ���� ���� ���� ������ ������ ���� ����ϴ� �Լ��� 9�� ����Ѵ�.

-- ROUND(15.7)
select ROUND(15.7) from dual; -- ROUND �Լ��� m�ڸ��� �������� ���ڸ� �ݿø��ϴ� �Լ��� 16�� ����Ѵ�.

-- SIGN(-15)
select SIGN(-15) from dual; -- SIGN �Լ��� ������ -1��, ����� 1�� ����ϴ� �Լ��� -1�� ����Ѵ�.

-- TRUNC(15.7)
select TRUNC(15.7) from dual; -- TRUNC �Լ��� ������(������) ���� ����ϴ� �Լ��� 15�� ����Ѵ�.

-- CHR(67)
select CHR(67) from dual; -- CHR �Լ��� ���� �ش��ϴ� ���ڸ� ����ϴ� �Լ��� C�� ����Ѵ�.

-- CONCAT('HAPPY', 'Birthday')
select CONCAT('HAPPY', 'Birthday') from dual; -- CONCAT �Լ��� �Էµ� ���ڿ��� �ٿ� ����ϴ� �Լ��� HAPPYBirthday�� ����Ѵ�.

-- LOWER('Birthday')
select LOWER('Birthday') from dual; -- LOWER �Լ��� �Էµ� ���ڿ��� ��� �ҹ��ڷ� ����ϴ� �Լ��� birthday�� ����Ѵ�.

-- LPAD('Page 1', 15, '*.')
select LPAD('Page 1', 15, '*.') from dual; -- LPAD �Լ��� ���ڿ� ���� ���ʿ� ��� �ڸ�����ŭ ���ڿ��� ä���־� ����ϴ� �Լ��� *.*.*.*.*Page 1�� ����Ѵ�.

-- LTRIM('Page 1', 'ae')
select LTRIM('Page 1', 'ae') from dual; -- LTRIM �Լ��� ���ڿ� ���� ���ʺ��� �ش� ���ڿ��� ������ ���� ����ϴ� �Լ��� �̷л����δ� Pg 1�� ���;��ϴµ� Page 1�� ��µȴ�..

-- REPLACE('JACK', 'J', 'BL')
select REPLACE('JACK', 'J', 'BL') from dual; -- REPLACE �Լ��� ���ڿ����� �ش� ���ڿ��� �ٸ� ���ڿ��� �ٲ� ���� ����ϴ� �Լ��� BLACK�� ����Ѵ�.

-- RPAD('Page 1', 15, '*.')
select RPAD('Page 1', 15, '*.') from dual; -- RPAD �Լ��� ���ڿ� ���� �����ʿ� ��� �ڸ�����ŭ ���ڿ��� ä���־� ����ϴ� �Լ��� Page 1*.*.*.*.*�� ����Ѵ�.

-- RTRIM('Page 1', 'ae')
select RTRIM('Page 1', 'ae') from dual; -- RTRIM �Լ��� ���ڿ� ���� �����ʺ��� �ش� ���ڿ��� ������ ���� ����ϴ� �Լ��� �̷л����δ� Pg 1�� ���;��ϴµ� Page 1�� ��µȴ�..

-- SUBSTR('1BCDEFG', 3, 4)

-- TRIM(LEADING 0 FROM '00AA00')

-- UPPER('Birthday')

-- ASCII('A')

-- INSTR('CORPORATE FLOOR', 'OR', 3, 2)

-- LENGTH('Birthday')

-- ADD_MONTHS('14/05/21', 1)

-- LAST_DAY(SYSDATE)

-- NEXT_DAY(SYSDATE, 'ȭ')

-- ROUND(SYSDATE)

-- SYSDATE

-- TO_CHAR(SYSDATE)

-- TO_CHAR(123)

-- TO_DATE('12 05 2014', 'DD MM YYYY')

-- TO_NUMBER('12.3')

-- DECODE(1, 1, 'aa', 'bb')

-- NULLIF(123, 345)

-- NVL(NULL, 123)
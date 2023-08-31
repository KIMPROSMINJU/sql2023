insert into ORDERS values (1, 1, 1, 6000, to_date('2020-07-01', 'yyyy-mm-dd'));
insert into ORDERS values (2, 1, 3, 21000, to_date('2020-07-03', 'yyyy-mm-dd'));
insert into ORDERS values (3, 2, 5, 8000, to_date('2020-07-03', 'yyyy-mm-dd'));
insert into ORDERS values (4, 3, 6, 6000, to_date('2020-07-04', 'yyyy-mm-dd'));
insert into ORDERS values (5, 4, 7, 20000, to_date('2020-07-05', 'yyyy-mm-dd'));
insert into ORDERS values (6, 1, 2, 12000, to_date('2020-07-07', 'yyyy-mm-dd'));
insert into ORDERS values (7, 4, 8, 13000, to_date('2020-07-07', 'yyyy-mm-dd'));
insert into ORDERS values (8, 3, 10, 12000, to_date('2020-07-08', 'yyyy-mm-dd'));
insert into ORDERS values (9, 2, 10, 7000, to_date('2020-07-09', 'yyyy-mm-dd'));
insert into ORDERS values (10, 3, 8, 13000, to_date('2020-07-10', 'yyyy-mm-dd'));

insert into IMPORTED_BOOK values(21, 'Zen Golf', 'Pearson', 12000);
insert into IMPORTED_BOOK values(22, 'Soccer Skills', 'Human Kinetics', 15000);


select publisher, price from BOOK where bookname like '�౸�� ����';

select phone from CUSTOMER where name = '�迬��';

select * from CUSTOMER where name = '�迬��';


-- BOOK ���̺��� ���ݰ� �������� �˻��Ͻÿ�.
select price, bookname from BOOK;

-- BOOK ���̺��� ������� ������ �˻��Ͻÿ�.
select bookname, price from BOOK;

-- BOOK���̺��� ������ȣ, ������, ���ǻ�, ������ �˻��Ͻÿ�.
select * from BOOK;
-- BOOK���̺��� ��� ���ǻ縦 �˻��Ͻÿ�.
select distinct publisher from BOOK;


select * from BOOK where price < 10000;

-- BOOK���̺��� 10000�� �̻� 16000�� �̸��� ������ �˻�
select bookname from BOOK where price >= 10000 and price <= 16000;
select bookname from BOOK where price between 10000 and 16000;

-- BOOK���̺��� ���ǻ簡 �½����� �Ǵ� ���ѹ̵���� ������ �˻�, in ������ ���
select bookname from BOOK where publisher in ('�½�����', '���ѹ̵��');
select bookname from BOOK where publisher = '�½�����' or publisher = '���ѹ̵��';

select bookname from BOOK where publisher not in ('�½�����', '���ѹ̵��', '�̻�̵��');
select bookname from BOOK where publisher <> '�½�����' and publisher <> '���ѹ̵��' and publisher <> '�̻�̵��';

select bookname from BOOK where bookname like '%�౸%';
select bookname from BOOK where bookname like '_��%';
select bookname from BOOK where bookname like '%��%';

select * from BOOK where bookname like '___��%';
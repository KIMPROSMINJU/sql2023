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


select publisher, price from BOOK where bookname like '축구의 역사';

select phone from CUSTOMER where name = '김연아';

select * from CUSTOMER where name = '김연아';


-- BOOK 테이블에서 가격과 도서명을 검색하시오.
select price, bookname from BOOK;

-- BOOK 테이블에서 도서명과 가격을 검색하시오.
select bookname, price from BOOK;

-- BOOK테이블에서 도서번호, 도서명, 출판사, 가격을 검색하시오.
select * from BOOK;
-- BOOK테이블에서 모든 출판사를 검색하시오.
select distinct publisher from BOOK;


select * from BOOK where price < 10000;

-- BOOK테이블에서 10000원 이상 16000원 미만의 도서명 검색
select bookname from BOOK where price >= 10000 and price <= 16000;
select bookname from BOOK where price between 10000 and 16000;

-- BOOK테이블에서 출판사가 굿스포츠 또는 대한미디어인 도서명 검색, in 연산자 사용
select bookname from BOOK where publisher in ('굿스포츠', '대한미디어');
select bookname from BOOK where publisher = '굿스포츠' or publisher = '대한미디어';

select bookname from BOOK where publisher not in ('굿스포츠', '대한미디어', '이상미디어');
select bookname from BOOK where publisher <> '굿스포츠' and publisher <> '대한미디어' and publisher <> '이상미디어';

select bookname from BOOK where bookname like '%축구%';
select bookname from BOOK where bookname like '_구%';
select bookname from BOOK where bookname like '%이%';

select * from BOOK where bookname like '___의%';
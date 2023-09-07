-- 고객의 이름, 주문한 도서 판매가격을 검색하시오.
select name, saleprice from CUSTOMER c, ORDERS o
where c.custid = o.custid;

-- 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬
select name, sum(saleprice) from CUSTOMER c, ORDERS o
where c.custid = o.custid
group by c.name order by c.name;

-- 고객의 이름과 주문한 도서의 이름을 구하시오.
-- 3개의 테이블에 대한 동등조인
select name, bookname from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and o.bookid = b.bookid;

-- 도서 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select name, bookname from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and o.bookid = b.bookid and b.price = 20000;

-- 동등조인을 하게되면 값이 동등하지 않은 행은 무시되지만 
-- 외부조인을 하게되면 기준이 되는 테이블의 값이 동등하지 않은 데이터 행도 포함해서 출력해준다.

--도서를 구매하지 않은 고객도 포함하여 고객이름과 주문한 도서의 판매가격을 출력하시오
select CUSTOMER.name, ORDERS.saleprice 
from CUSTOMER left outer join ORDERS on CUSTOMER.custid = ORDERS.custid;

--suv query (부속 질의) : main query 안에 있는 query
-- 도서 가격이 가장 비싼 도서이름을 출력하시오.
select bookname from BOOK where price = (select max(price) from BOOK);

-- 도서 가격이 가장 싼 도서의 이름과 가격을 출력하시오.
select bookname, price from BOOK where price in (select min(price) from BOOK);

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오
select name from CUSTOMER where custid in (select distinct custid from ORDERS);

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력
select name from CUSTOMER where custid in (select custid from ORDERS where bookid in (select bookid from BOOK where publisher = '대한미디어'));
select name from CUSTOMER c, BOOK b, ORDERS o where c.custid = o.custid and o.bookid = b.bookid and b.publisher = '대한미디어';
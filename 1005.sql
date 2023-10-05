-- 2
select cs.name, s 
from (select custid, avg(saleprice) s from ORDERS group by custid) od, customer cs
where cs.custid = od.custid;
-- 주문 내역이 있는 고객의 이름과 고객별로 구매금액의 평균을 s라고 이름붙여 출력한다.

-- 3
select sum(saleprice) "total" from ORDERS od
where exists(select * from customer cs where custid <= 3 and cs.custid = od.custid);
-- 고객번호 3까지의 고객 중 주문 내역이 있는 고객의 구매금액의 합계를 total이라고 이름붙여 출력한다.

-- 책 이름에 과학이라는 단어가 포함된 결과행을 출력하시오.
select * from BOOK where bookname like '%축구%';
create view v_book as select * from BOOK where bookname like '%축구%';

-- 주소에 서울이라는 단어가 포함된 뷰를 생성하시오.
select * from customer where address like '%대한민국%';
create view v_customer as select * from customer where address like '%대한민국%';

-- 주문 테이블에서 고객이름, 도서이름을 바로 확인할 수 있는 뷰를 생성한 후. 
-- 김연아 고객이 구입한 도서의 주문번호, 도서명, 주문액을 출력하시오.
create view v_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select orderid, c.custid, c.name, o.bookid, b.bookname, saleprice, orderdate 
    from ORDERS o, CUSTOMER c, BOOK b
    where o.custid = c.custid and o.bookid = b.bookid;
select * from v_orders;
select orderid, bookname, saleprice from v_orders where name = '김연아';

-- v_customer뷰를 대한민국이 아닌 영국을 주소로 가진 고객으로 변경하시오.
create or replace view v_customer(custid, name, address)
as select custid, name, address from CUSTOMER
where address like '%영국%';

-- 판매가격이 20,000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매 가격을 보여주는 highorders 뷰를 생성하시오.
create view highorders(도서번호, 도서이름, 고객이름, 출판사, 판매가격)
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and b.bookid = o.bookid and saleprice >= 20000;
select * from highorders;

-- 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 sql문을 작성하시오.
select bookname, name from highorders;

-- highorders 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오. 삭제 후 위 sql문 다시 수행.
create or replace view highorders(도서번호, 도서이름, 고객이름, 출판사, 판매가격)
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice from CUSTOMER c, BOOK b, ORDERS o
where c.custid = o.custid and b.bookid = o.bookid;
select bookname, name from highorders;                                                                        
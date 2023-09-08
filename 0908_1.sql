-- 집합연산자 : 합집합(union), 차집합(minus), 교집합(intercept)
-- 차집합 연산자를 사용해 도서를 주문하지 않은 고객의 이름을 쓰시오
select name from CUSTOMER 
minus select name from CUSTOMER where custid in(select custid from ORDERS);

-- 집합자 연산자 사용하지 않은 경우
select name from CUSTOMER where custid not in (select custid from ORDERS);

-- exists : 서브쿼리의 결과가 존재하는 경우에만 true
-- 주문이 있는 고객의 이름과 주소를 출력하시오
-- in 연산자 사용
select name, address from CUSTOMER where custid in (select distinct custid from ORDERS);

-- 동등조인과 중복행 제거
select distinct name, address from CUSTOMER c, ORDERS o
where c.custid = o.custid;

-- exists 사용한 경우
select name, address from CUSTOMER c
where exists(select * from ORDERS o where c.custid = o.custid);


-- 1-5
select count(distinct publisher) from BOOK b, ORDERS o, CUSTOMER c where b.bookid = o.bookid and o.custid = c.custid and c.name = '박지성';

-- 1-6
select bookname, o.saleprice, price - saleprice from BOOK b, ORDERS o, CUSTOMER c where b.bookid = o.bookid and o.custid = c.custid and c.name = '박지성';

-- 1-7
select distinct bookname from BOOK b, ORDERS o, CUSTOMER c where b.bookid = o.bookid and o.custid = c.custid and not c.name = '박지성';


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

-- 2-13 > 잘 모르겠음
select name from CUSTOMER c, ORDERS o where c.custid = o.custid; 
select avg(saleprice) from ORDERS;
select name, avg(saleprice) from CUSTOMER c, ORDERS o where c.custid = o.custid group by name;

select name from CUSTOMER c, ORDERS o where c.custid = o.custid group by name having avg(saleprice) > (select avg(saleprice) from ORDERS);
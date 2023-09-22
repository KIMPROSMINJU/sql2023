-- 고객의 이름과 전화번호를 출력하시오. (단, 전화번호가 없는 고객은 연락처 없음으로 출력하시오)
select name 이름, nvl(phone, '연락처 없음') 전화번호 from CUSTOMER;
select rownum 순번, name 이름, nvl(phone, '연락처 없음') 전화번호 from CUSTOMER;

-- 고객목록에서 순번, 고객번호, 이름, 전화번호를 앞의 두명만 출력하시오.
select rownum 순번, custid 고객번호, name 이름, phone 전화번호 from CUSTOMER where rownum <= 2;

-- MYBOOK 테이블 생성
create table MYBOOK(
    bookid number not null primary key,
    price number
);

-- 평균판매금액 이하의 주문에 대해 주문번호와 판매금액을 출력하시오.
select orderid, saleprice from ORDERS where saleprice <= (select avg(saleprice) from ORDERS);

-- 주문 고객의 평균판매금액보다 큰 금액의 주문 내역에 대해서만 주문번호, 고객번호, 판매금액을 출력하시오.
select orderid 주문번호, custid 고객번호, saleprice 판매금액 from ORDERS mo
where saleprice > (select avg(saleprice) from orders so where mo.custid = so.custid);

-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매금액을 출력하시오.
select sum(saleprice) 총판매금액 from ORDERS o where custid in (select custid from CUSTOMER where address like '%서울%');

-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력하시오.
select orderid 주문번호, saleprice 판매금액 from ORDERS
where saleprice > (select max(saleprice) from ORDERS where custid = 3);

-- 서울에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오. 단, exist 연산자 사용
select sum(saleprice) 총판매액 from ORDERS mo
where exists(select * from customer c where address like '%서울%' and mo.custid = c.custid);

-- 고객별 판매금액의 합계를 출력하시오 (고객번호, 판매합계)
select custid, sum(saleprice) from ORDERS group by custid;

-- 고객별 판매금액의 합계를 출력하시오 (고객번호, 판매합계)
select name, sum(saleprice) from ORDERS o, CUSTOMER c where o.custid = c.custid group by name;

-- 주문목록에 책이름을 저장할 수 있는 칼럼을 추가하시오.
alter table ORDERS add bookname varchar2(40);

update orders o set bookname = (select bookname from book b where b.bookid = o.bookid);

-- 고객번호가 2 이하인 고객번호와 이름을 출력하시오
select custid 고객번호, name 이름 from CUSTOMER where custid <= 2;

-- 고객번호가 2 이하인 고객의 판매금액을 출력하시오. ( 고객이름과 고객별 판매액 출력)
select name, sum(saleprice) from (select custid, name from CUSTOMER where custid <= 2) c, ORDERS o
where c.custid = o.custid
group by name;


-- 데이터 행 삽입
insert into MYBOOK values(1, 10000);
insert into MYBOOK values(2, 10000);
insert into MYBOOK(bookid) values(3);

select * from MYBOOK;


-- 문제풀이
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


-- 문제풀이 2
-- 1
select * from BOOK; -- 1	축구의 역사	굿스포츠	7000
                    -- 10	Olympic Champions	Pearson	13000
                    -- 2	축구 아는 여자	나무수	13000
                    -- 3	축구의 이해	대한미디어	22000
                    -- 4	골프 바이블	대한미디어	35000
                    -- 5	피겨 교본	굿스포츠	8000
                    -- 6	역도 단게별 기술	굿스포츠	6000
                    -- 7	야구의 추억	이상미디어	20000
                    -- 8	야구를 부탁해	이상미디어	13000
                    -- 9	올림픽 이야기	삼성당	7500
-- 2
select * from BOOK where rownum <= 5; -- 1	축구의 역사	굿스포츠	7000
                                      -- 10	Olympic Champions	Pearson	13000
                                      -- 2	축구 아는 여자	나무수	13000
                                      -- 3	축구의 이해	대한미디어	22000
                                      -- 4	골프 바이블	대한미디어	35000
                                      
-- 3
select * from BOOK where rownum <= 5 order by price; -- 1	축구의 역사	굿스포츠	7000
                                                      -- 10	Olympic Champions	Pearson	13000
                                                      -- 2	축구 아는 여자	나무수	13000
                                                      -- 3	축구의 이해	대한미디어	22000
                                                      -- 4	골프 바이블	대한미디어	35000

-- 4
select * from (select * from BOOK order by price) b where rownum <= 5; -- 6	역도 단게별 기술	굿스포츠	6000
                                                                        -- 1	축구의 역사	굿스포츠	7000
                                                                        -- 9	올림픽 이야기	삼성당	7500
                                                                        -- 5	피겨 교본	굿스포츠	8000
                                                                        -- 10	Olympic Champions	Pearson	13000

-- 5
select * from (select * from BOOK where rownum <= 5) b order by price; -- 1	축구의 역사	굿스포츠	7000
                                                                        -- 10	Olympic Champions	Pearson	13000
                                                                        -- 2	축구 아는 여자	나무수	13000
                                                                        -- 3	축구의 이해	대한미디어	22000
                                                                        -- 4	골프 바이블	대한미디어	35000

-- 6
select * from (select * from BOOK where rownum <= 5 order by price) b; -- 1	축구의 역사	굿스포츠	7000
                                                                        -- 10	Olympic Champions	Pearson	13000
                                                                        -- 2	축구 아는 여자	나무수	13000
                                                                        -- 3	축구의 이해	대한미디어	22000
                                                                        -- 4	골프 바이블	대한미디어	35000


-- 문제풀이 3
-- 1
select custid, (select address from CUSTOMER cs where cs.custid = od.custid) address, sum(saleprice) total
from ORDERS od
group by od.custid;

-- ABS(-15)
select ABS(-15) from dual; -- ABS는 절댓값을 출력하는 함수로 15를 출력한다.

-- CEIL(15.7)
select CEIL(15.7) from dual; -- CEIL은 반올림한 값을 출력하는 함수로 16을 출력한다.

-- COS(3.14159)
select COS(3.14159) from dual; -- COS는 코사인 값을 출력하는 함수로 -0.999999...를 출력한다

-- FLOOR(15.7)
select FLOOR(15.7) from dual; -- FLOOR는 내림한 값을 출력하는 함수로 15를 출력한다.

-- LOG(10, 100)
select LOG(10, 100) from dual; -- LOG함수는 뒤의 값을 앞의 값으로 로그연산한 값을 출력하는 함수로 2를 출력한다.

-- MOD(11, 4)
select MOD(11, 4) from dual;

-- POWER(3, 2)
select POWER(3, 2) from dual; -- POWER 함수는 앞의 값을 뒤의 값으로 제곱한 값을 출력하는 함수로 9를 출력한다.

-- ROUND(15.7)
select ROUND(15.7) from dual; -- ROUND 함수는 m자리를 기준으로 숫자를 반올림하는 함수로 16을 출력한다.

-- SIGN(-15)
select SIGN(-15) from dual; -- SIGN 함수는 음수면 -1을, 양수면 1을 출력하는 함수로 -1을 출력한다.

-- TRUNC(15.7)
select TRUNC(15.7) from dual; -- TRUNC 함수는 내림한(절삭한) 값을 출력하는 함수로 15를 출력한다.

-- CHR(67)
select CHR(67) from dual; -- CHR 함수는 값에 해당하는 문자를 출력하는 함수로 C를 출력한다.

-- CONCAT('HAPPY', 'Birthday')
select CONCAT('HAPPY', 'Birthday') from dual; -- CONCAT 함수는 입력된 문자열을 붙여 출력하는 함수로 HAPPYBirthday를 출력한다.

-- LOWER('Birthday')
select LOWER('Birthday') from dual; -- LOWER 함수는 입력된 문자열을 모두 소문자로 출력하는 함수로 birthday를 출력한다.

-- LPAD('Page 1', 15, '*.')
select LPAD('Page 1', 15, '*.') from dual; -- LPAD 함수는 문자열 기준 왼쪽에 비는 자릿수만큼 문자열을 채워넣어 출력하는 함수로 *.*.*.*.*Page 1을 출력한다.

-- LTRIM('Page 1', 'ae')
select LTRIM('Page 1', 'ae') from dual; -- LTRIM 함수는 문자열 기준 왼쪽부터 해당 문자열을 제거한 값을 출력하는 함수로 이론상으로는 Pg 1이 나와야하는데 Page 1이 출력된다..

-- REPLACE('JACK', 'J', 'BL')
select REPLACE('JACK', 'J', 'BL') from dual; -- REPLACE 함수는 문자열에서 해당 문자열을 다른 문자열로 바꾼 값을 출력하는 함수로 BLACK을 출력한다.

-- RPAD('Page 1', 15, '*.')
select RPAD('Page 1', 15, '*.') from dual; -- RPAD 함수는 문자열 기준 오른쪽에 비는 자릿수만큼 문자열을 채워넣어 출력하는 함수로 Page 1*.*.*.*.*을 출력한다.

-- RTRIM('Page 1', 'ae')
select RTRIM('Page 1', 'ae') from dual; -- RTRIM 함수는 문자열 기준 오른쪽부터 해당 문자열을 제거한 값을 출력하는 함수로 이론상으로는 Pg 1이 나와야하는데 Page 1이 출력된다..

-- SUBSTR('1BCDEFG', 3, 4)

-- TRIM(LEADING 0 FROM '00AA00')

-- UPPER('Birthday')

-- ASCII('A')

-- INSTR('CORPORATE FLOOR', 'OR', 3, 2)

-- LENGTH('Birthday')

-- ADD_MONTHS('14/05/21', 1)

-- LAST_DAY(SYSDATE)

-- NEXT_DAY(SYSDATE, '화')

-- ROUND(SYSDATE)

-- SYSDATE

-- TO_CHAR(SYSDATE)

-- TO_CHAR(123)

-- TO_DATE('12 05 2014', 'DD MM YYYY')

-- TO_NUMBER('12.3')

-- DECODE(1, 1, 'aa', 'bb')

-- NULLIF(123, 345)

-- NVL(NULL, 123)
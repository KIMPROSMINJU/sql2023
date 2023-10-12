set serveroutput on;
exec interest;

create table Book_log(
    bookid_l number,
    bookname_l varchar2(40),
    publisher_l varchar2(40),
    price_l number);

insert into book values(15, '스포츠 과학 1', '이상미디어', 25000);
select * from book where bookid = '15';
select * from book_log where bookid_l = '15';

select custid, orderid, saleprice, fnc_interest(saleprice) interest from ORDERS;

select bookid 도서번호, bookname 도서명 from book order by bookid asc;

select b.bookname from book b, customer c, orders o where b.bookid = o.bookid and o.custid = c.custid and b.bookname like '%야구%';
select b.bookid, b.bookname, o.saleprice, c.name from book b, customer c, orders o where b.bookid = o.bookid and o.custid = c.custid;
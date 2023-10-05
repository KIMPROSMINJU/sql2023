create or replace PROCEDURE INSERTBOOK(
    myBookId in number,
    myBookName in varchar2,
    myPublisher in varchar2,
    myPrice in number)
AS 
BEGIN
  insert into book(bookid, bookname, publisher, price)
  values (myBookId, myBookName, myPublisher, myPrice);
END;

create or replace PROCEDURE INSERTORUPDATE(
    myBookId number,
    myBookName varchar2,
    myPublisher varchar2,
    myPrice int)
AS
    myCount number;
BEGIN
    select count(*) into myCount from book
    where bookname like myBookName;
  
    if myCount != 0 then
        update book set price = myPrice
        where bookname like myBookName;
    else
        insert into book(bookid, bookname, publisher, price)
        values(myBookId, myBookName, myPublisher, myPrice);
    end if;
END INSERTORUPDATE;

create or replace PROCEDURE AVERAGEPRICE(
    averageval out number)
AS 
BEGIN
  select avg(price) into averageVal from book
  where price is not null;
END AVERAGEPRICE;

-- insertbook 프로시저 실행
exec insertbook(13, '스포츠과학', '마당과학서적', 25000);

select * from BOOK;

exec insertorupdate(14, '스포츠즐거움', '마당과학서적', 30000);

exec insertorupdate(14, '스포츠즐거움', '마당과학서적', 20000);

set serveroutput on;
declare
    averageVal number;
begin
    averagePrice(averageVal);
    dbms_output.put_line('도서평균가격 : '||round(averageVal, 2));
end;
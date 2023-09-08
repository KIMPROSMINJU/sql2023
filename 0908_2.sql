-- DDL : 데이터 정의어
-- creat table/ alter table/ drop table
-- 테이블 생성 연습 1
create table NEWBOOK1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
    );
    
-- 테이블 생성 연습 2
-- primary key 설정 방법m1
create table NEWBOOK2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid)
    );
    
-- primary key 설정 방법 2
create table NEWBOOK3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
    );
    
-- bookname 컬럼 : null값 가질 수 없음
-- publisher 컬럼 : 동일 값 가질 수 없음
-- price 컬럼 : 가격이 입력되어 있지 않으면 기본값을 10000으로 하고 입력될 때는 1000 초과로 함
-- primary key 설정 방법 3
create table NEWBOOK4(
    bookid number,
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check (price > 1000),
    primary key(bookname, publisher)
    );
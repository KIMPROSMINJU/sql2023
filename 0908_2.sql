-- DDL : ������ ���Ǿ�
-- creat table/ alter table/ drop table
-- ���̺� ���� ���� 1
create table NEWBOOK1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
    );
    
-- ���̺� ���� ���� 2
-- primary key ���� ���m1
create table NEWBOOK2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid)
    );
    
-- primary key ���� ��� 2
create table NEWBOOK3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
    );
    
-- bookname �÷� : null�� ���� �� ����
-- publisher �÷� : ���� �� ���� �� ����
-- price �÷� : ������ �ԷµǾ� ���� ������ �⺻���� 10000���� �ϰ� �Էµ� ���� 1000 �ʰ��� ��
-- primary key ���� ��� 3
create table NEWBOOK4(
    bookid number,
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check (price > 1000),
    primary key(bookname, publisher)
    );
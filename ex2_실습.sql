-- 테이블 생성 실습

USE testdb;
CREATE TABLE member(
member_no int primary key,
member_id varchar(20) ,
member_pw varchar(20),
member_name varchar(20),
member_gender varchar(1),
member_point int,
member_reg_date datetime
);

SELECT * FROM member;

CREATE TABLE book(
book_no int primary key,
book_kind varchar(3),
book_title varchar(100),
book_price int,
book_count int,
book_author varchar(40),
book_publishing_com varchar(30),
book_publishing_date varchar(15),
book_image varchar(16),
book_content varchar(500),
book_discount_rate int,
book_reg_date datetime
);
SELECT * FROM book;

CREATE table cart(
cart_no int,
buyer varchar(50),
buy_price int,
buy_count int,
book_no int,
book_title varchar(100),
book_image varchar(16)
);
SELECT * FROM book;

-- drop table member; 
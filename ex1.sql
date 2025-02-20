-- 주석
# 주석
-- 한 줄 실행 ctrl+enter

CREATE DATABASE testdb;
-- CREATE TABLE testdb; 명령어 기본 베이스는 대문자
-- create table testdb; window에서는 명령어를 소문자로 해도 된다. (맥, 리눅스 불가능)

-- 데이터 베이스 사용
USE testdb;

-- 자료형 => 자바랑 비교하기
-- mysql  /  java
-- int       int
-- varchar   string
-- data      data
-- datetime  datetime

CREATE TABLE sample(
num int(2) primary key,
name varchar(5) default '무명이',
-- 컬럼이름 컬럼속성(길이) 값
brith date not null,
address varchar (255)
);

-- alter 변경
-- 컬럼 이름 변경
alter table sample rename column brith to birth;
-- 컬럼 자료형 변경
alter table sample modify birth varchar(10);

-- 보통은 수정이 번거롭기 때문에 테이블을 수정하지 않고 drop(버리기)후 다시 생성
drop table sample;

-- 위 쪽 가서 다시 수정한 테이블로 ctrl+enter 해서 재생성
CREATE TABLE sample(
num int(2) primary key,
name varchar(5) default '무명이',
birth date not null,
address varchar (255)
);

-- 테이블의 값 추가하기 
INSERT INTO sample VALUES(1,'둘리','2025-02-20',"주소1"); 
-- ctrl + d 한줄 복사
INSERT INTO sample(name,birth,num) VALUES('또치' , '1990-10-10','2'); 
INSERT INTO sample(birth,num) VALUES('2000-10-10','3'); 
INSERT INTO sample(name,birth,num) VALUES(null , '1990-10-10','4'); 

-- 테이블 값 출력하기 
SELECT * FROM sample;
-- 이걸 실행해야 테이블 그리드에 보인다

insert into sample(brith, address , num ) values('2024-02-01','서울 특별시 강남' , 13);

insert into sample values(2,'홍길동','2024-02-01','서울 특별시 압구정')
,(3,'테스트1','1991-01-01' , '서울특별시 강남')
,(4,'테스트2','1992-01-01' , '서울특별시 역삼')
,(5,'테스트3','1993-01-01' , '서울특별시 신사')
,(6,'테스트4','1994-01-01' , '경기도 아무개')
,(7,'테스트5','1995-01-01' , '강원도 아무개')
,(8,'테스트6','1996-01-01' , '경기도 수원')
,(10,'테스트7','1997-01-01' , '경기도 용인')
,(11,'테스트8','1997-01-01' , '경기도 용인')
,(12, '테스트9','1997-01-01' , '경기도 용인');

-- 산술연산자 사용 가능
select 20+30, 20-10, 20*10, 10/3;

select*from sample where num = 1;
-- 위 코드 해석: sample 테이블에서 num 이 1과 같니? 같으면 모든 컬럼 출력
select*from sample where num = '1';
-- 문자로 쳐도 동일하게 출력됨

INSERT INTO sample VALUES(13,'test','2024-02-01',null); 

select*from sample where address = null;
-- null 운 없는 값이므로 = 으로는 답이 나오지 않는다.
select*from sample where address is null;
-- is null 키워드로 검색
select*from sample where address is not null;

select*from sample where address <>'경기도 용인';
select*from sample where address !='경기도 용인';
-- 주소에서 경기도 용인이 아닌 자료만 뽑아줘

select*from sample where birth >= '1997-01-01';
-- 1997 1 1 이후 데이터 뽑아줘
select*from sample where birth >= '1997-01-01' and num=5;
-- and or 사용가능
-- 1997 1 1 이후 이면서 num이 5인 데이터 뽑아줘
select*from sample where birth >= '1997-01-01' or num=5;
-- 1997 1 1 이후 이거나 num이 5인 데이터 뽑아줘

select*from sample where name like '%3';
-- 이름에 무조건 글자수 상관없이 끝에 3이 있는 데이터만 가져와
select*from sample where name not like '%3';
-- 이름에 무조건 글자수 상관없이 끝이 3이 아닌 데이터만 가져와
select*from sample where num>=1 and num<=3;
-- num 이 1에서 3사이인 것만 가져와
select*from sample where num in(1,2,3);
-- num 이 1, 2, 3인 것만 가져와
select*from sample where num between 1 and 3;
-- num 이 1에서 3사이인 것만 가져와
select*from sample where num not between 1 and 3 and address is not null;
-- num 이 1에서 3사이가 아니고 주소가 null이 아닌 것만 가져와

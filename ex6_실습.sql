
USE testdb;
CREATE TABLE employee (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64),
  salary INT,
  office_worker VARCHAR(64)
);

INSERT INTO employee VALUES(1,'허사장',20000000,'사장');

INSERT INTO employee (name,salary,office_worker) VALUES('유부장',10000000,'부장');
INSERT INTO employee (name,salary,office_worker) VALUES('박차장',5000000,'차장');
INSERT INTO employee (name,salary,office_worker) VALUES('정과장',4000000,'과장');
INSERT INTO employee (name,salary,office_worker) VALUES('정대리',3895000,'대리');
INSERT INTO employee (name,salary,office_worker) VALUES('노사원',2500000,'사원');
INSERT INTO employee (name,salary,office_worker) VALUES('하사원',2000000,'사원');
INSERT INTO employee (name,salary,office_worker) VALUES('길인턴',1000000,'인턴');

select * from employee;


select * from employee;

-- 대리인 사람을 구하시요 
select * from employee where office_worker="대리";

-- 노사원라는 사람의 직급을 구하시요
-- 1 노사원있니?
-- 2 노사원 직급 구하는것 

select name ,office_worker from employee
where name="노사원" and office_worker="사원";

select name ,office_worker from employee
where office_worker = (select office_worker from employee where name="노사원"); 

-- 정대리보다 급여가 높은 사람들을 구하시오 
select * from employee
where salary > (select salary from employee where name='정대리');

select salary from employee where office_worker='사원';

-- any all : 여러행 의 비교연산자 사용 
-- 중첩쿼리 
select * from employee
where salary > (select salary from employee where office_worker='사원');  -- 서브쿼리 비교연산자는 값한개만 리턴되야한다


select * from employee where office_worker='사원';

-- 직급이 사원 사람들의 이름과 급여를 구하시요 
-- from 절 안에 있는 서브쿼리 : 인라인뷰 
select ex1.name , ex1.salary from (select * from employee where office_worker='사원') ex1;

-- 정대리의 급여와 테이블 전체 평균 급여를 구하시요 
-- 스칼라 서브쿼리 
select name, salary , (select round(avg(salary)) from employee) as '평균급여' from employee where name='정대리';

select*from sample;
-- update, delete 는 where 조건을 주지 않으면 모든 행에 영향을 미친다

-- update 테이블이름 set 변경내용
update sample  set name='무명이', address='테스트' -- set은 여러개로 하고 싶으면 ,로 연결
where num=2;

delete from sample where name='테스트2';

-- C(create)R(read)U(update)D(delete)
-- select : 읽기 
-- insert : 추가 
-- update : 수정 
-- delete : 삭제

CREATE TABLE temp_emp (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64),
  salary INT,
  office_worker VARCHAR(64)
);

insert into temp_emp (select*from employee);
-- 값복사
select*from temp_emp;

-- 부장의 정보를 구해와서 급여를 10만원 인상한다
update temp_emp set salary = salary+100000
where id=(select id from employee where office_worker='부장');

-- 인턴의 정보를 가져와서 인턴을 삭제
delete from temp_emp
where id=(select id from employee where office_worker='인턴');

-- 서브쿼리는 쿼리 안에 쿼리가 있는 것이다
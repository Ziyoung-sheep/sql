use testdb;
select * from t_product;
select * from t_region;
select * from t_sales;
select * from t_customer;

-- 1. 쇼핑몰 값 추가후 진행 (use testdb)
-- 문제1] 제품별로 구매된 총 수량과 총 가격을 계산하여 출력하세요
select product_name, sum(s.qty) as '총 판매 갯수' , sum(s.qty)*p.price as '총 매출'
from t_product p
inner join t_sales s
on p.product_code=s.product_code
group by p.product_code;

-- 문제2] 각 지역별로 로고 개수를 계산하여 출력하시오. (서울 특별시 1)
select region_name, ifnull(count(c.customer_name), 0) as '고객 수(명)'
from t_region r
left join t_customer c
on r.region_code=c.region_code
group by r.region_name;

-- 문제3] 특정 고객(id=3)이 구매한 제품의 이름을 출력하세요
select s.customer_id, p.product_name
from t_sales s
inner join t_product p
on s.product_code=p.product_code
where s.customer_id=3;


-- 문제 4) 고객이 속한 지역 별 총 판매량을 출력하세요. → 난이도 상 (조인, 서브쿼리)
-- 1단계 먼저 고객별 총 판매랑 구하기 
-- 2단계 해당 지역코드를 이름으로 받아오기
select region_name, sum(qty)
from t_customer c
inner join t_sales s
inner join t_region r
on c.customer_id=s.customer_id
where c.region_code=r.region_code
group by r.region_code;





-- 문제 5) 제품의 평균 가격 보다 높은 가격을 가진 제품의 이름과 가격을 출력하세요.
select product_name, price
from t_product
where price> (select avg(price) from t_product);

-- 문제 6)  고객별 구매한 총 제품 수를 출력하세요.
select c.customer_id, customer_name, count(qty)
from t_customer c
inner join t_sales s
on c.customer_id=s.customer_id
group by customer_id;

use academydb;

-- 2. 학과시스템 값 추가후 진행 (use academydb)
-- 문제 7) 학생번호, 학생이름, 키, 학과번호, 학과명정보를 출력하세요.
select student_id, student_name, student_height, s.department_code, department_name
from student s
inner join department d
on s.department_code=d.department_code
group by student_id;

-- 문제 8) 교수의 학과 정보를 출력하세요.(교수이름, 학과명)
select professor_name, department_name
from professor p
inner join department d
on p.department_code=d.department_code
group by professor_code;

-- 문제 9 ) 학과 별 교수의 수를 출력하세요
select department_name, count(professor_code) as '교수 수(명)'
from department d
inner join professor p
on p.department_code=d.department_code
group by d.department_code;

-- 문제10) 수학 통계학의 학생 정보를 출력하세요
select student_id, student_name, student_height, s.department_code, department_name
from student s
inner join department d
on s.department_code=d.department_code
where department_name='수학통계학'
group by student_id;

-- 문제 11) 학생중 성이‘바’ 인 학생이 속한 학과 이름과 학생 이름을 출력하세요
select student_name, department_name
from student s
inner join department d
on s.department_code=d.department_code
where student_name like "바%"
group by student_name;

-- 문제 12) 학과별키의최고값과, 평균값을출력하세요.
select department_name, max(student_height), round(avg(student_height),2)
from department d
inner join student s
on d.department_code=s.department_code
group by d.department_code;

-- 문제 13) ‘다학생’ 과 같은 학과에 속한 학생의 이름을 출력하세요.
select student_name, department_name
from student s
inner join department d
on d.department_code=s.department_code
where s.department_code=(select department_code from student where student_name='다학생');

-- 문제 14)  ‘교양영어’ 과목을수강신청한학생의이름을출력하세요. [난이도 상 ]
-- 교양영어의 코드값을 가져와서
-- 스튜던트 커리에서 그 코드값을 가진 스튜던트 코드를 가져와서
-- 학생코드를 가진 학생이름을 출력한다
select student_name
from student s
inner join course c
inner join student_course sc
on s.student_id=sc.student_id
where sc.course_code=(select course_code from course where course_name='교양 영어')
group by s.student_id;

-- 문제 15) ‘가교수’ 교수의과목을수강신청한학생수를출력하세요 [난이도 상 ]
select sc.course_code, course_name, count(student_id)
from course c
inner join student_course sc
on c.course_code=sc.course_code
where sc.course_code=(select course_code
					from course c
					inner join professor p
					where c.professor_code=(select p.professor_code from professor p where professor_name='가교수')
					group by course_code)
group by course_code;


select * from course;
select * from department;
select * from professor;
select * from student;
select * from student_course;
-- 문제 16)  ‘사학생’ 학생과같은과목을수강신청한학생이름을출력하세요. [난이도 상]

-- # 사학생의 스튜던트id
-- select student_id
-- from student
-- where student_name='사학생';
-- #사학생이 수강한 과목코드
-- select course_code
-- from student_course
-- where student_id=(select student_id
-- from student
-- where student_name='사학생')
-- group by course_code;
# 사학생이 수강한 과목 코드를 수강한 학생 id 목록
select sc.student_id, s.student_name
from student_course sc
inner join student s
on sc.student_id=s.student_id
where sc.course_code=(select course_code
from student_course
where student_id=(select student_id
from student
where student_name='사학생')
group by course_code)
group by sc.student_id;

-- 문제 17)  ‘사학생’ 이 수강신청한과목의과목이름과시작일자를출력하세요 [난이도 상]
-- #사학생이 수강한 과목코드
-- select course_code
-- from student_course
-- where student_id=(select student_id
-- from student
-- where student_name='사학생')
-- group by course_code;

select course_name, start_date
from course
where course_code=(select course_code
from student_course
where student_id=(select student_id
from student
where student_name='사학생')
group by course_code)
group by course_code;

-- 문제 18)  개설과목 이름별 수강자 수를 출력하세요.
select course_name, count(student_id)
from course c
inner join student_course sc
on c.course_code=sc.course_code
group by c.course_code;
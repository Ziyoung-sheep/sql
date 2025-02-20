
#like 부분검색 연습
#문제1] book테이블에서 책 제목에 'java'가 포함되어 있는 책 정보 가녀오기
select*from book where book_title like '%java%';
#문제2] book테이블에서 책 제목에 'java' 또는 '자바' 가 포함되어 있는 책 정보 가녀오기
select*from book where book_title like '%java%' or book_title like '%자바%';
#문제3] book테이블에서 책 제목이 '나'로 시작되는 책 정보 가녀오기
select*from book where book_title like '나%';
#문제4] book테이블에서 책 제목이 '외국어'로 끝나는 책 정보 가녀오기
select*from book where book_title like '%외국어';
#문제5] member테이블에서 이름이 4글자인 회원정보 가져오기
select*from member where member_name like '____';

select count(*) as'총 회원 수' from member;
select count(*) as'총 남성 회원 수' from member where member_gender='m';

#문제1] book 테이블에서 전체 도서 가격의 총 합 가져오기
select sum(book_price) as '전체 도서 가격 총 합' from book;
#문제1] book 테이블에서 전체 도서 가격의 평균 가져오기
select round(avg(book_price),2)  as '전체 도서 가격 평균' from book;
#[조건] 소수점 이하 2자리까지 출력
#문제3] book 테이블에서 도서 가격을 10% 인상했을 때의 총합 가져오기
select round((sum(book_price))*1.1) as '전체 도서 가격 10퍼센트 인상 총합' from book;
#문제3] book 테이블에서 도서 가격이 가장 높은 도서 가격 가져오기
select book_price as '가장 가격이 높은 도서' from book order by book_price desc limit 1;

-- 구매자를 기준으로 구매자 아이디, 총 산 책 갯수를 출력
select buyer, count(*) as'총 구매한 책 갯수' from cart group by buyer;
select buyer, count(buyer) as'총 구매한 책 갯수' from cart group by buyer;

-- select buyer, sum(buyer_price), count(*) as'총 구매한 책 갯수' from cart group by buyer;

-- select buyer, sum(buyer_price), count(*)
-- from cart
-- group by buyer
-- having 


select count(*) from member where member_gender = 'm';
select count(*) from member where member_gender = 'w';
select member_gender from member group by member_gender;
select count(*) from member group by member_gender;

select * from cart;

-- 구매자를 기준으로 책을 구매자 아이디와 총 산 책 갯수를 출력
-- select buyer, sum(buy_price)  ,count(*) as '구매한 책 갯수' from cart where count(*) >= 2 group by buyer;
-- group by로 출력할때 그루핑이 되지 않는 컬럼을 출력 하지 말자!!! -> 논리적인 오류 발생 
-- select cart_no, buyer, sum(buy_price)  ,count(*) as '구매한 책 갯수' from cart group by buyer;

select buyer , sum(buy_price) , count(*) 
from cart
group by buyer
having count(*) >= 2;



#[문제] book 테이블에서 2015년에서 2019년 사이에 출간한 도서 중에 재고 수량이 3개 이하인 도서를 종류별 개수 가져오기

# 1단계: 2015~2019년 사이의 출판 도서의 책분야, 책 제목, 책재고량, 책 츨판일
select book_kind, book_title, book_count, book_publishing_date from book where book_publishing_date>='2015-01-01' and book_publishing_date<='2019-12-31';
# 2단계: 분야별 재고 수량이 3개 이하인 도서로 출약
select book_kind, book_title, book_count, book_publishing_date
from book
where book_publishing_date>='2015-01-01' and book_publishing_date<='2019-12-31' and book_count<=3;
# 3단계: 책 분야별로 그룹해서 총 갯수
select book_kind, count(book_kind) as '총 갯수'
from book
where book_publishing_date>='2015-01-01' and book_publishing_date<='2019-12-31' and book_count<=3
group by book_kind;

-- 뭔가 쓰면 깃허브에 바뀌려나?
-- 바뀌넹ㅋㅋ 깃허브 최고
 

-- join 두개의 테이블 합쳐준다 

-- cart에서 바이어 id 와 바이어 이름을 출력해라 
select member_name, buyer
from member
inner join cart 
on member.member_id = cart.buyer;

-- 이렇게도 inner join 구할수있지만 비추 !!! 
select member_name, buyer 
from member m , cart c
where m.member_id = c.buyer;



select book_count, buyer , book.book_title
from cart
inner join book
on cart.book_no = book.book_no;

select book_count, buyer , b.book_title
from cart c
inner join book b
on c.book_no = b.book_no;

-- 구매이력이 없는 회원 이름

select member_name as '구매이력이 없는 회원 이름'
from member m left join cart c 
on m.member_id = c.buyer
where cart_no is null;




INSERT INTO cart VALUES(7, 'haha', 34200, 5, 3006, '은노기의 JSP 2.3 웹 프로그래밍', 'nothing.jpg');
INSERT INTO cart VALUES(8, 'tiger', 13500, 2, 1001, '나미야 잡화점의 기적', 'nothing.jpg');
select*from cart;
#[문제1] cart 테이블에서 회원이 구매한 도서의 할인되기 전의 가격과 할인율 가져오기
select c.book_title, b.book_price, c.buy_price, book_discount_rate
from cart c
inner join book b
on c.book_title=b.book_title
group by c.book_title;


#[문제2] cart 테이블에서 회원이 구매한 도서의 할인되기 전의 가격이 2만원 이상인 도서정보와 할인율 가져오기
select c.book_title, b.book_price, c.buy_price, book_discount_rate
from cart c
inner join book b
on c.book_title=b.book_title
where b.book_price>=20000
group by c.book_title;

#[문제3] cart 테이블에서 회원이 구매한 도서
-- 구매한 회원의 회원 번호, id, 이름, 구매 횟수, 구매 책 수량 출력
select member_no, member_id, member_name, count(c.buyer) as '구매횟수',  sum(c.buy_count) as '구매수량'
from cart c
inner join member m
on c.buyer=m.member_id
group by c.buyer;

-- [조건1] 구매 책 수량이 총 3권 이상만 출력
select member_no, member_id, member_name, count(c.buyer) as '구매횟수',  sum(c.buy_count) as '구매수량'
from cart c
inner join member m
on c.buyer=m.member_id
group by c.buyer
having sum(c.buy_count)>=3;

-- [조건2] 구매 책 수량으로 내림차순 출력
select member_no, member_id, member_name, count(c.buyer) as '구매횟수',  sum(c.buy_count) as '구매수량'
from cart c
inner join member m
on c.buyer=m.member_id
group by c.buyer
having sum(c.buy_count)>=3
order by sum(c.buy_count) desc;


#[문제4] 구매한 회원의 회원번호, 회원id, 회원이름, 책 이름, 저자 제목 => 3개 조인



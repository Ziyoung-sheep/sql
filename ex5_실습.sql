
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
 


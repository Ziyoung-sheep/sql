# 숫자 함수 
# ABS()			절대값
# CEIL()		소수점 올림
# FLOOR()		소수점 버림
# ROUND()		소수점 반올림(자리수 지정 가능)
# TRUNCATE()	소수점 버림(자리수 지정 가능)
# POW()			x의 y승 : 거듭제곱 
# MOD()			나머지값  자바 % 
# GREATEST()	max
# LEAST()		min
# sql은 자바와 다르게 인덱스번호가 1부터 시작한다 !!!! 0부터 아님! 
select ABS(100), ABS(-100); -- 100 100 출력
select round(3.5), round(3.1);
select ceil(3.5), ceil(3.1);
select floor(3.5), floor(3.1);

select round(123.12345,-1), round(123.12345,1) ,round(123.54321,2); -- 1의 자리까지 출력, 소숫점 2번째 자리까지 출력 
select truncate(123.12345,-1), truncate(123.54321,1),truncate(123.54521,2); -- 소숫점 그냥 버림 

select pow(2,3); -- 2의 3승 2*2*2 : 거듭제곱
select mod(10,3); -- 10%3 == > 1 : 나머지값 

select greatest(10,3,4,5,-3,6); -- 10 max 
select least(10,3,4,5,-3,6); -- -3 min 

-- 문자함수 : 자바와 다르게 인덱스 1부터 시작 sql -> 0 (x) 1부터 시작한다 
 # CONCAT(), INSERT(), REPLACE(), INSTR()
 #concat: 문자열 이어붙이기 
select concat('010','-','1234','-','1234');  -- 010-1234-1234
-- sql은 시작값이 index 의 0이 아니라 1이다!! 
select insert('abcde', 2, 3 ,'zzz'); -- 2번째부터 3개를 삭제한 후에 마지막 인자값 삽입 abbbe
select replace('aabbcc', 'b','ff'); -- aaffcc
select instr('안녕하세요','하세'); -- 3 : indexString => instr : 인덱스 시작값이 1 
select instr('안녕하세요','방갑'); -- 해당 문자열이 업으면 0을 리턴 

-- # 문자열 부분 짤라내는 함수 LEFT, RIGHT, MID 
select left('abcedf' , 3); -- 왼쪽에서부터 3개를 제외한 나머지를 삭제 abc
select right('abcedf' , 3);-- 오른쪽에서부터 3개를 제외한 나머지를 삭제 edf
select mid('abcedfg',2,3); -- 2번째 인덱스에서 3개 가져와 bce 

-- # LTRIM, RTRIM, TRIM : 문자열을 기준으로 앞뒤 공백 제거 주의! 문자열 사이의 공백은 취급 안함 
select concat('[','     abc      ',']'); -- [   abc   ]
select concat('[',rtrim('     abc      '),']'); -- [   abc]
select concat('[',ltrim('     abc      '),']'); -- [abc   ]
select concat('[',trim('     abc      '),']'); -- [abc]
select replace('   a    bc         ' , ' ','');

-- 소문자 변환 
select lcase('abCDEfg'); -- 소문자로 변환 
select lower('abCDEfg'); -- 소문자로 변환 
-- 대문자변환 
select ucase('abCDEfg'); -- 대문자로 변환 
select upper('abCDEfg'); -- 대문자로 변환 

-- 반전 
select reverse('abCDEfg'); -- 'gfEDCba'

-- 날짜 관련된 함수 
-- 시스템 날짜 받아오는 3가지 방법 ( 년-월-일 시:분:초)
select now() , sysdate() , current_timestamp();
-- 날짜
select current_date() , curdate();
-- 시간
select current_time(), current_time();

select year(now()) , month(now()) , day(now());
select concat(year(now()),'년',month(now()) ,'월',day(now()),'일');

# 날짜 포멧 
select now() , date_format(now() ,'%Y년 %m월 %d일, %H시 %i분 %s초 ' ); -- Y 2023 H 15시
select now() , date_format(now() ,'%y년 %m월 %d일, %h시 %i분 %s초 ' ); -- y 23년 h 03시 
#요일 
select now() ,dayofweek(now()); -- 일요일 1 ~ 7 토요일 
# 올해의 몇번째의 날 
select now() ,dayofyear(now());
# 올해의 몇번째 주 
select now() ,week(now());

# 두 날짜의 차이 값 가져오기 
select datediff('2021-02-01','2021-05-30'); -- 118
select datediff('2021-05-30', '2021-04-20'); -- 40 

select member_name, member_pw from member where member_id='qwer';
#문제1] member 테이블의 회원가입 일자를 한글날짜 형식 2020년 2월 20일 출력하기
select date_format(member_reg_date, "%y년 %m월 %d일")as '회원가입 날짜' from member ;
-- 대문자로 M월 D일 영어형식
#문제2] book 테이블에서 책이름과 가격 출력 가격에 만원 더한 값을 출력하기
select book_title, book_price, (book_price+10000) as '만원 인상가' from book;
#문제3] book 테이블에서 책 이름과 가격 출력 10% 인하된 가격
select book_title, book_price, truncate(book_price/100*90,-1) as '10%인하가격' from book;
#문제4] book 테이블에서 책 이름과 할인율 가격 전, 할인율, 할인율 적용 후 가격 출력
select book_title, book_price, book_discount_rate, truncate(book_price/100*(100-book_discount_rate),-1) as '할인율 적용가' from book;

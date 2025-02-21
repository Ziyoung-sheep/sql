-- 어카운트 정보테이블 
CREATE TABLE account(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    amount DECIMAL(19, 4) NOT NULL
);
-- 거래내역 기록테이블 
CREATE TABLE transferHistory(
	id INT AUTO_INCREMENT PRIMARY KEY,
    from_id INT NOT NULL,
    to_id INT NOT NULL,
    amount DECIMAL(19, 4) NOT NULL,   -- demimal(정수길이, 소숫점길이 )
    trans_date DATETIME
);
delete from account;
delete from transferhistory;
insert into account (name, amount) values('조지영', 100000),('김나경', 5000);

select * from account;
select * from transferhistory;

-- 트렌지션
start transaction;
-- 입금
update account set amount = amount-50000 where id = 3;
update account set amount = amount+50000 where id = 4;

insert into transferhistory (from_id , to_id, amount, trans_date) values (3,4, 50000, now());

select * from account;
select * from transferhistory;

-- if(실패)
rollback; -- 시작 지점으로 돌아간다 
-- else(성공)
commit; -- 완전히 db 값을 저장한다 

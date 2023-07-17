-- root 화면

create database boarddb;

drop database boarddb;

create database bbsdb;

use bbsdb;

create table tbl_bbs (
	b_seq		bigint		PRIMARY KEY	auto_increment,
	b_pseq		bigint,
	b_date		varchar(10),
	b_time		varchar(10),
	b_username	varchar(125),
	b_nickname	varchar(125),
	b_subject	varchar(125),
	b_content	text,	
	b_count		int	,
	b_update	datetime
);

select count(*) from tbl_bbs;
select * from tbl_bbs;



select b_username, b_nickname
from tbl_bbs
group by b_username, b_nickname;

create table tbl_user (
	username	varchar(125)		PRIMARY KEY,
	nickname	varchar(125) NOT NULL,
	tel			varchar(20)
);

-- tbl_bbs로 부터 user 정보 정규화로 분해하기
insert into tbl_user(username, nickname)
values('callor@callor.com', '내멋으로');

insert into tbl_user(username, nickname, tel)
values('hong', '홍길동', '090-1111-1111');
insert into tbl_user(username, nickname, tel)
values('lee', '이몽룡', '090-2222-2222');
insert into tbl_user(username, nickname, tel)
values('seoung', '성춘향', '090-3333-3333');

select * from tbl_user;

alter table tbl_bbs
add CONSTRAINT f_username
foreign key(b_username)
REFERENCES tbl_user(username);

-- FK 설정이 되면
-- 두 Table 간에
-- INSERT, UPDATE, DELETE 에서 이상현상을
-- 방지하여 참조무결성 관계를 유지한다.
insert into tbl_bbs(b_username, b_nickname)
values('aaa','임꺽정');
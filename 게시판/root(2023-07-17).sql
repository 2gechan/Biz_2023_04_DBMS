use bbsdb;

desc tbl_bbs;

-- tbl_bbs 테이블에 대표이미지를 저장하는 칼럼 추가
-- tbl_bbs 테이블에 b_image 라는 칼럼을 추가하는데
-- 데이터 타입은 VARCHAR(125) 로 하고
-- b_count 다음에 (b_update) 앞에 위치하도록
-- ALTER TABLE 사용하여 새로운 칼럼을 추가하는 경우
-- 제약사항(NOT NULL 등)을 동시에 추가할수 없다
ALTER TABLE tbl_bbs
ADD b_image VARCHAR(125)
AFTER b_count;

-- Table 을 DROP 하고 
-- 다시 같은 구조로 CREATE TABLE
TRUNCATE tbl_bbs;

ALTER TABLE tbl_bbs
DROP b_nickname;

ALTER TABLE tbl_bbs
DROP CONSTRAINT f_username;

INSERT INTO tbl_bbs(
	b_pseq,		b_date,		b_time,		b_username,
	b_subject,	b_content,	b_count,	b_image
) VALUES (
	1,1,1,1,1,1,1,1
);    
SELECT * FROM tbl_bbs;

CREATE TABLE tbl_images (
	i_seq	bigint	PRIMARY KEY	AUTO_INCREMENT,
	i_bseq	bigint	NOT NULL,
	i_originalName	VARCHAR(125),			
	i_uploadName	VARCHAR(255)			
);

insert into tbl_bbs(b_username)
values('callor');
-- auto_increment 속성을 통해 자동으로 seq 값이 생성되는데
-- 마지막에 insert한 데이터의 id값을 가져온다.
select last_insert_id();

insert into tbl_bbs(b_username)
values('callor1'),
('callor2'),
('callor3'),
('callor4'),
('callor5');

select * from tbl_bbs;

select * from tbl_user;
insert into tbl_user (username, nickname, tel) values ("test", "테스트", "010-1234-1234");
SELECT *  FROM tbl_bbs, tbl_user WHERE b_username = username AND b_seq = 15;

select * from tbl_images;

truncate tbl_bbs;
truncate tbl_images;

select * from tbl_bbs;
select * from tbl_images
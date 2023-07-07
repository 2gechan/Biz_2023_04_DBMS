-- scoreDB 화면
use scoreDB;

-- 일반(엑셀)성적표를 저장하기 위한 Table 생성
create table tbl_scoreV1 (
	sc_stnum	VARCHAR(5)		PRIMARY KEY,
	sc_kor		INT,
	sc_eng		INT,
	sc_math		INT,
	sc_music	INT,
	sc_art		INT,
	sc_software	INT,
	sc_database	INT
);

show tables;

desc tbl_scorev1;
drop table tbl_scorev1;
select * from tbl_scorev1;

create view view_scorev1 as
(
	select *, sc_kor + sc_eng + sc_math + sc_music + sc_art + sc_software + sc_database AS 총점,
	(sc_kor + sc_eng + sc_math + sc_music + sc_art + sc_software + sc_database) / 7 AS 평균
	from tbl_scorev1
    );
    
select * from view_scorev1;

-- 국어성적이 50점 이상인 학생들 리스트
-- where selection
select * from view_scorev1
where sc_kor >= 50;

-- 평균점수가 60점 미만인 학생들
select * from view_scorev1
where 평균 < 70;

-- SQL을 사용한 간이 통계
-- 전체학생의 각 과목별 성적총점계산
-- 국어성적의 총점계산
-- SUM() : ANSI SQL의 총합계를 계산하는 통계함수
-- AVG() : ANSI SQL의 평균을 계산하는 통계함수
-- MAX(), MIN() : ANSI SQL의 최대값, 최소값을 계산하는 통계함수
-- COUNT() : ANSI SQL의 개수를 계산하는 통계함수
select sum(sc_kor), avg(sc_kor)
from view_scorev1;

select
sum(sc_kor) as 국어,
sum(sc_eng) as 영어,
sum(sc_math) as 수학,
sum(sc_music) as 음악,
sum(sc_art) as 미술
from view_scorev1;

select
avg(sc_kor) as 국어,
avg(sc_eng) as 영어,
avg(sc_math) as 수학,
avg(sc_music) as 음악,
avg(sc_art) as 미술
from view_scorev1;

-- MySQL8의 전용함수
select *
from view_scorev1
order by 평균 desc;

-- over( order by 평균 desc ) : 평균을 오름차순한 것을 기준으로
-- RANK() : 순위를 계산하라
select *,
RANK() over(order by 평균 desc) 랭킹
from view_scorev1
order by 평균 desc;

-- DENSE_RANK() : 동점자 처리를 하되 석차를 건너뜀 없이
select *,
DENSE_RANK() over(order by 평균 desc) 랭킹
from view_scorev1
order by 평균 desc;

-- sub query : sql 결과를 사용하여 다른 sql을 실행하는 것

select * from
(
	select *,
	RANK() over(order by 평균 desc) 랭킹
	from view_scorev1
) as sub
where sub.랭킹 < 5;

select sub.과목코드, sub.과목명 from
(
	select sc_stnum, 'B001' AS 과목코드, '국어' AS 과목명, sc_kor from tbl_scorev1
	UNION ALL
	select sc_stnum, 'B002', '영어', sc_eng from tbl_scorev1
	UNION ALL
	select sc_stnum, 'B003', '수학', sc_math from tbl_scorev1
	UNION ALL
	select sc_stnum, 'B004', '음악', sc_music from tbl_scorev1
	UNION ALL
	select sc_stnum, 'B005', '미술', sc_art from tbl_scorev1
	UNION ALL
	select sc_stnum, 'B006', '소프트웨어', sc_software from tbl_scorev1
	UNION ALL
	select sc_stnum, 'B007', '데이터베이스', sc_database from tbl_scorev1
) as sub
group by sub.과목코드, sub.과목명;

-- 학생정보 제3정규화 데이터 테이블
-- 학번과 과목코드를 복합키(슈퍼키) PK 생성
create table tbl_score (
	sc_stnum	VARCHAR(5)	NOT NULL,
	sc_bcode	VARCHAR(4)	NOT NULL,
	sc_score	INT	NOT NULL,
	PRIMARY KEY(sc_stnum, sc_bcode)
);

-- 과목정보 테이블
create table tbl_subject(
	b_code	VARCHAR(4)		PRIMARY KEY,
	b_name	VARCHAR(20)
);

-- 과목정보 Excel 데이터를 tbl_subject에 insert해 보기
insert into tbl_subject(b_code, b_name) values ('B001', '국어');
insert into tbl_subject(b_code, b_name) values ('B002', '영어');
insert into tbl_subject(b_code, b_name) values ('B003', '수학');
insert into tbl_subject(b_code, b_name) values ('B004', '음악');
insert into tbl_subject(b_code, b_name) values ('B005', '미술');
insert into tbl_subject(b_code, b_name) values ('B006', '소프트웨어');
insert into tbl_subject(b_code, b_name) values ('B007', '데이터베이스');

select * from tbl_subject;

show tables;
desc tbl_score;

select * from tbl_score;

-- 성적표와 과목정보를 JOIN 하여
-- 학번, 과목코드, 과목명, 점수를 Projection 하여 출력
select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score
	left join tbl_subject
		on b_code = sc_bcode;

-- 완전 참조관계 확인
-- 다음의 left join을 사용하여 확인
-- 여기에서 결과가 하나도 없어야 한다.
select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score
	left join tbl_subject
		on b_code = sc_bcode
where b_name is null;

-- 성적표와 과목정보가 완전 참조 관계일때는 EQ JOIN을
-- 사용할 수 있다.
select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score, tbl_subject
where sc_bcdoe = b_code;

-- 성적표와 과목정보가 앞으로도 계속 완전 참조 관계가 되도록
-- FK 설정(완전참조 무결성 관계 설정)
-- ANSI SQL(표준)
alter table tbl_score
add CONSTRAINT f_bcode
FOREIGN KEY(sc_bcode)
REFERENCES tbl_subject(b_code);

alter table tbl_score drop FOREIGN KEY f_bcode;

-- MySQL (CONSTRAINT 생략 가능)
alter table tbl_score
add FOREIGN KEY(sc_bcode)
REFERENCES tbl_subject(b_code);

-- ON DELETE, ON UPDATE
-- ON DELETE : Master(tbl_score) table의 키가 삭제될 때
/*
CASCADE : Master 삭제 -> sub도 모두 삭제
SET NULL : Master 삭제 -> Sub는 NULL, 
		만약 Sub 칼럼이 NOT NULL이면 오류 발생
NO ACTION : Master 삭제 -> Sub에는 변화 없이
SET DEFAULT : Master 삭제 -> Sub Table 생성할 때
		Default 옵션으로 지정한 값으로 세팅
RESTRICT : 아무 것도 하지마, 삭제하지마
*/
-- ON UDPATE : Master(tbl_score) table의 키가 변경될 때
alter table tbl_score
add CONSTRAINT f_bcode
FOREIGN KEY(sc_bcode)
REFERENCES tbl_subject(b_code)
on delete cascade;

select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score, tbl_subject
where sc_bcode = b_code AND b_name = '국어';

-- 학생별 총점 계산하기
select sc_stnum, sum(sc_score)
from tbl_score
group by sc_stnum;

-- 과목별 총점 계산하기
select sc_bcode, sum(sc_score) 총점, AVG(sc_score) 평균
from tbl_score
group by sc_bcode;

-- 제 3정규화된 데이터를 PIVOT 펼쳐서 보고서 형식으로 출력
-- 세로방향으로 펼쳐진 데이터를 가로방향으로 펼쳐서 보기
select
	sum(if(sc_bcode = 'B001', sc_score, 0)) 국어,
    sum(if(sc_bcode = 'B002', sc_score, 0)) 영어,
    sum(if(sc_bcode = 'B003', sc_score, 0)) 수학,
    sum(if(sc_bcode = 'B004', sc_score, 0)) 음악,
    sum(if(sc_bcode = 'B005', sc_score, 0)) 미술,
    sum(if(sc_bcode = 'B006', sc_score, 0)) 소프트웨어,
    sum(if(sc_bcode = 'B007', sc_score, 0)) 데이터베이스
from tbl_score;

-- 제 3정규화가 되어 있는 데이터를 PIVOT 보고서 형식으로 출력하기
select
sc_stnum 학번,
	sum(if(sc_bcode = 'B001', sc_score, 0)) 국어,
    sum(if(sc_bcode = 'B002', sc_score, 0)) 영어,
    sum(if(sc_bcode = 'B003', sc_score, 0)) 수학,
    sum(if(sc_bcode = 'B004', sc_score, 0)) 음악,
    sum(if(sc_bcode = 'B005', sc_score, 0)) 미술,
    sum(if(sc_bcode = 'B006', sc_score, 0)) 소프트웨어,
    sum(if(sc_bcode = 'B007', sc_score, 0)) 데이터베이스,
    sum(sc_score) 총점,
    avg(sc_score) 평균
from tbl_score
group by sc_stnum; 

select sc_stnum, sum(sc_score)
from tbl_score
group by sc_stnum;

-- 통계 함수로 학생별 총점을 계산하고
-- 계산된 총점에 대하여 조건을 부여하여 selection 하기
select sc_stnum, sum(sc_score) as 총점
from tbl_score
group by sc_stnum
having sum(sc_score) > 500;

/*
1. from절의 테이블 찾기
2. group by절 조건에 따라 묶기
3. select의 조건에 따라 조회하기
4. having의 조건에 따라 필터링
*/
select sc_stnum, sum(sc_score) as 총점
from tbl_score
group by sc_stnum
having 총점 > 500;

-- 학번이 S0010 보다 작은 학생들의 총점 계산
select sc_stnum, sum(sc_score) as 총점
from tbl_score
group by sc_stnum
having sc_stnum < 'S0010';

select sc_stnum, sum(sc_score) as 총점
from tbl_score
where sc_stnum < 'S0010'
group by sc_stnum;

-- S0010인 학생보다 총점이 작은 학생들 총점 리스트
-- 조건절(where, having)에 sub query 적용하기
-- 조건절에 적용하는 sub query는 결과가 반드시
-- 한개 이하여야 한다.
select sc_stnum as 학번, sum(sc_score) as 총점
from tbl_score
group by sc_stnum
having 총점 < (select sum(sc_score) from tbl_score where sc_stnum = 'S0001');

/*
오라클
	TableSpace 생성하기
		create tablespace addrDB
		datafile 'c:/app/data/addr.dbf'
		size 1M AUTOEXTEND on NEXT 1K;
		
    User 생성하기
		create user addr IDENTIFIED by 12341234
		default tablespace addrDB;
    
MySQL
	권한부여하기
		grant all PRIVILEGES on todoDB.* to todo@localhost;

공통
	주요 select 문장
		sum(), avg() 함수 : group by 사용
    create table : 테이블 명세를 보고 빈칸 채우기 후 테이블 만들기
		create table '테이블명' (
			'칼럼명' '타입' '필요시PK',
            '칼럼명' '타입', 
            '칼럼명' '타입',
            ...
        )
    insert 명령
		insert into '테이블명' (칼럼1, 칼럼2...) values(값1, 값2...)
    update 명령
		주소록에서 홍길동인 사람의 전화번호가 010-1111.* 이다
        이 전화번호를 010-222 으로 바꾸어라
        select * from 'table명' where name="홍길동" AND tel like "010-1111%";
        update 'table명' set tel = '010-222' where pk = '홍길동pk';
*/
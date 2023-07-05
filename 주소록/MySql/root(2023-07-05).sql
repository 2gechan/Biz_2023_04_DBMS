-- 이 화면은 root 화면
/*
MySQL은 DataBase 라는 Scheme를 통하여 물리적인 DB를 관리한다
Oracle은 TableSpace라는 물리적 저장소와 연결한 사용자를 통하여 DB를 관리한다

현업에서 가장 많이 사용하는 2가지 DBMS를 서로 비교하므로써
데이터베이스에 대한 이론을 정리해보기 바람

Oracle에서는 사용자가 Scheme가 되며
MySQL 사용자는 DBMS, 물리적저장소 등에 접근하는 권한을 가진 사용자 개념이다.
*/

-- 프로젝트 시작을 하기 위하여 Database를 생성
create database addrDB;
show databases;

-- MySQL 에서는 사용자로 로그인한 후
-- Scheme(Database)에 접속하는 절차가 필요하다
use addrDB;
-- addrDB에 접속한 상태가 된다

create table tbl_address(
    a_id	VARCHAR(5)		PRIMARY KEY,
    a_name	nVARCHAR(20)	NOT NULL,
    a_tel	VARCHAR(15)	NOT NULL,
    a_addr	nVARCHAR(125)	NOT NULL
 );
 
 desc tbl_address;
 
 /*
 BIGINT type의 PK 칼럼
	보통 기본 데이터로 PK를 생성할 수 없을 경우
    별도의 칼럼을 생성하고 그 칼럼에 일련번호 속성을 부여하여
    PK로 만든다 이때 PK의 값은 무한히 커질 수 있으므로
    INT 형보다 상당히 큰 BIGINT type으로 설정한다.

AUTO_INCREMENT 속성
	MySQL에서는 일련번호 칼럼에 대하여 자동값 증가 생성 속성이 있다.
    PK 칼럼에만 이 속성을 부여할 수 있고
    이 속성을 가진 PK 칼럼은 Insert가 수행될 때
    자동으로 1씩 증가되는 일련번호를 생성하여 칼럼에 데이터에 대입한다.
 */
 create table tbl_addr_hobby(
 ah_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
 ah_aid	VARCHAR(5)	NOT NULL,
 ah_hbcode	VARCHAR(5)	NOT NULL
);

insert tbl_addr_hobby (ah_aid, ah_hbcode)
values('A0001', 'H0001');

select * from tbl_addr_hobby;

create table tbl_hobby(
hb_code	VARCHAR(5)		PRIMARY KEY,
hb_name	VARCHAR(30)	NOT NULL,
hb_descrip	VARCHAR(400)	
);

-- 현재 시스템의 database(SCHEME) 리스트 확인
show databases;
-- 현재 DB(addrDB)에 생성된 Table 리스트 확인
show tables;

-- Table의 구조 확인
describe tbl_address;
desc tbl_address;

select * from tbl_address;

delete from tbl_address
where a_id = '';

select count(*) from tbl_address;

select * from tbl_addr_hobby;
select count(*) from tbl_addr_hobby;

select * from tbl_hobby;

SELECT '주소록 Entity' AS 제목, count(*) AS 개수 FROM tbl_addres
UNION ALL
SELECT '취미 Entity', count(*) FROM tbl_hobby
UNION ALL
SELECT '취미 Relation', count(*) FROM tbl_addr_hobby;
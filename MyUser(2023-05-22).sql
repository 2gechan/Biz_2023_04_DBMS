 -- 여기는 DBA 권한을 갖는 MyUser 화면입니다.
 
 -- table 생성하기
 CREATE TABLE tbl_buyer(
    buId	VARCHAR2(5)	NOT NULL	PRIMARY KEY,
    buName	nVARCHAR2(20)	NOT NULL,
    buTel	VARCHAR2(20),
    buAddr	nVARCHAR2(125),
    buBirth	VARCHAR2(10),
    buJob	nVARCHAR2(20)
 );
 
 -- 테이블에 column 별로 데이터 삽입
 INSERT INTO tbl_buyer (buId, buName, buTel, buAddr, buBirth, buJob)
 VALUES ('0001', '이몽룡', '010-111-1111', '서울특별시', '1999-01-01', '직장인');
 
 -- tbl_buyer table의 전체 데이터 조회
 SELECT * FROM tbl_buyer;
 
 -- buid,buname은 NOT NULL을 설정했기 때문에 최소한의 정보 입력이 필요
 INSERT INTO tbl_buyer (buid,buname) VALUES('0002','성춘향');
 
 SELECT * FROM tbl_buyer;
 
 -- buid가 '0002'인 데이터의 butel 값을 '010-222-2222'로 업데이트
 update tbl_buyer set butel = '010-222-2222' where buid='0002';
 
 SELECT * FROM tbl_buyer;
 
 -- where = '조건'이 없는 경우 table의 전체 데이터가 변경된다
 update tbl_buyer set buaddr = '전라남도 남원시' where buname = '성춘향';
 
 SELECT * FROM tbl_buyer;
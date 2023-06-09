 -- 여기는 student 사용자로 접속한 화면
 -- student 사용자는 현재 DBA 권한을 가지고 있다.
 -- DBA 권한은 테이블 생성, 수정, 삭제, 데이터의 CRUD, COMMIT, ROLLBACK 등의 
 --     명령을 수행할 수 있다.
 
 -- 사용자 입장에서 데이터 저장소 생성
 -- 실제 논리적인 데이터를 관리하는 객체
 -- TABLE
 
 /*
 RDBMS(Relation DataBase Management System)에서 데이터 취급하기
 
       1. 물리적인 저장소를 생성하기 = Oracle 에서는 TableSpace = CREATE TABLESPACE
       2. Table 저장소 생성 : 논리적 개념 -> table = CREATE TABLE
       3. CRUD 구현하기
 */
 
 -- 데이터를 추가하기전에 Table 생성 오류가 발견되면, 제거하고 다시 생성할 수 있다
 -- DROP TABLE tbl_student; --> TABLE 제거하기
 CREATE TABLE tbl_student(
    st_num	    VARCHAR2(10)	    PRIMARY KEY,
    st_name	    nVARCHAR2(20)	NOT NULL,
    st_dept	    nVARCHAR2(20),
    st_grade	NUMBER,
    st_tel	    VARCHAR2(20)	NOT NULL
 );
 
 -- 이미 데이터가 추가되었는데 Table 구조의 문제를 발견했다
 -- Table을 변경(수정)하기
 -- st_tel 칼럼의 데이터 타입 변경
 -- Table의 구조를 변경하는 명령은 매우 비용이 크기 때문에
 -- 사용할 때 항상 주의를 해야 한다.
 -- 특히 칼럼의 크기(길이)를 변경하거나 타입을 변경할 때는
 -- 데이터 손상이 될 수 있기 때문에 매우 조심해야 한다.
 -- alter table tbl_student modify (st_tel VARCHAR2(20));
 
 -- CRUD 실습
 -- 1. 데이터 추가
 -- st_num 칼럼은 PK 로 선언되어 있기 때문에 데이터는 필수이며, 중복될 수 없다
 -- st_num 칼럼은 PK 로 선언되어 있기 때문에 NOT NULL, UNIQUE 성질을 갖는다.
 
 insert into tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
 values('230001', '홍길동', '정보통신', 3, '010-111-1111');
 
 insert into tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
 values('230002', '성춘향', '법학과', 1, '010-222-2222');
 
 insert into tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
 values('230003', '이몽룡', '생명공학', 4, '010-333-3333');
 
 -- 2. 데이터 조회
 
 -- 아무 조건 없이 모든 데이터 보이기
 select * from tbl_student;
 
 -- Projection
 -- 칼럼을 원하는 순서대로 나열하여 모든 데이터 보이기
 select st_num, st_name, st_dept, st_grade, st_tel 
 from tbl_student;
 
 -- Projection
 -- 전체 칼럼(속성)중에서 학번(st_num), 이름(st_name)만 보이도록
 select st_num, st_name
 from tbl_student;
 
 -- Selection
 -- 데이터 중에서 이름(st_name) 값이 홍길동인 데이터들을 보여라
 -- 조건부여 검색, 조건부여 select, 조건부여 조회
 select st_num, st_name, st_dept, st_grade, st_tel 
 from tbl_student
 where st_name = '홍길동';
 
 -- 전체 데이터를 select 하되
 -- 학생이름(st_name)을 기준으로 오름차순 정렬하여 보여라
 select st_num, st_name, st_dept, st_grade, st_tel 
 from tbl_student 
 order by st_name;
 
 -- 학생이름으로 정렬하고, 같은 이름이 있으면 그 범위내에서
 -- 전화번호로 한번더 정렬하여 보여라
 select st_num, st_name, st_dept, st_grade, st_tel 
 from tbl_student 
 order by st_name, st_tel;
 
 -- 3. 데이터 수정(Update)
 -- Update를 수행할 때는 내가 변경하는 데이터가 정말 변경하고자 하는 데이터인가 ?
 -- 홍길동 학생의 전화번호가 010-111-1111 에서 010-111-1234로 변경되엇다
 -- 데이터를 수정하라
 
 -- 일반적인 update 명령은 다음과 같다. 문법적으로는 아무런 문제가 없으나
 -- 결과적으로 심각한 문제를 발생 안고 있다
 -- 홍길동 이라는 이름이 동명이인이 있을 경우, 원하지 않는 데이터각 변경될 수 있다
 -- 이 코드를 실행하면 원하지 않는 홍길동 학생의 전화번호가 변경될 수 있다
 -- 이러한 현상을 "수정 이상", "변경 이상" 이라고 한다
 update tbl_student
 set st_tel = '010-111-1234'
 where st_name = '홍길동';
 
 -- update 절차
 -- 1. 변경하고자 하는 데이터를 조회한다
 select * from tbl_student
 where st_name = '홍길동';
 
 -- 2. 조회된 데이터 중에서 변경하고자 하는 데이터의 PK가 무엇인지 확인한다
 --     여기서는 230001 임이 확인되엇다
 
 -- 3. PK 를 기준으로 데이터 변경하기
 update tbl_student
 set st_tel = '010-111-1234'
 where st_num = '230001';
 
 -- 4. 데이터 삭제 : 효용이 없어진 데이터를 Table 로 부터 삭제하기
 select * from tbl_student;
 
 -- 이몽룡(전화번호가 010-333-3333인) 학생이 자퇴를 하고 이민을 갔다
 -- 이몽룡 학생의 데이터를 table 에서 삭제하고자 한다
 
 -- 아래의 다음 코드는 학생 테이블에서 동일한 이름을 가진 
 -- 이몽룡 학생의 데이터가 삭제되는 문제가 있다
 -- 원하지 않는 데이터가 삭제되는 현상을 "삭제 이상" 이라고 한다
 -- 이러한 코드도 매우 신중하게 사용해야 한다.
 delete from tbl_student 
 where st_name = '이몽룡';
 
 -- 이몽룡 학생의 데이터를 삭제하는 절차
 -- 1. 먼저 내가 삭제하고자 하는 이몽룡 데이터를 조회
 select * from tbl_student
 where st_name = '이몽룡';
 
 -- 2. 삭제하고자 하는 데이터의 PK를 확인
 --    여기서는 230003인 PK를 확인하였다
 
 -- 3. PK를 기준으로 데이터를 삭제한다
 delete from tbl_student 
 where st_num = '230003';
 
 commit;
 
 select * from tbl_student;
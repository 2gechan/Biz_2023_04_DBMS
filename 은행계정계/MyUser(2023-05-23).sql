 -- 여기는 MyUser SCHEME 화면
 -- 여기는 MyUser 로 접속한 화면
 
 show tables;
 
 DESCRIBE tbl_buyer;
 
 /* 
 SELECT 명령
 SQL의 DML 명령중에 가장 많이 사용하는 명령
 DB>TABLE에 보관(저장)중인 데이터를 조회하는 명령
 
 tbl_buyer TABLE에 저장된 데이터를 아무 조건 없이
 모두 조회하여 보여줘라
 */
 select * from tbl_buyer;
 
 -- tbl_buyer TABLE에 저장된 데이터를 "아무 조건 없이" 보이되
 -- buid, buname column(field, 속성)만 보여줘라
 -- 저장된 데이터 중에서 id와 이름 항목만 보여줘라
 select buid, buname from tbl_buyer;
 
 -- 이름과 전화번호 column만 보여달라
 select buname, butel from tbl_buyer;
 
 -- tbl_buyer TABLE의 buname이 '성춘향'인 데이터의 모든 column을 보여줘라
 -- WHERE 절 : 조건을 부여할 때 사용
 select * from tbl_buyer where buname = '성춘향';
 select * from tbl_buyer where buname = '이몽룡';
 
 -- tbl_buyer TABLE의 buname이 '홍길동'인 데이터를 찾으려했지만
 -- 등록된 데이터가 없기 때문에 아무것도 나오지 않는다. 결과가 empty 상태
 select * from tbl_buyer where buname = '홍길동';
 
 /*
 buname column을 기준으로 조건 설정하였다
 buname column에 어떤 값을 조건으로 데이터를 조회 한 것
 buname column은 데이터가 추가될 때 같은 이름의 데이터가 중복되어 저장될 수 있다
 buname column을 기준으로 조회한 데이터가 비록 현재는 1개만 보이더라도
 이 데이터는 0개 이상의 데이터가 조회될 것이다 라는 것을 반드시 예상해야 한다.
 */
 insert into tbl_buyer(buid, buname)
 values('0003', '성춘향');
 
 select * from tbl_buyer;
 
 -- '성춘향'이라는 이름을 가진 두개의 데이터가 나오게 된다
 select * from tbl_buyer where buname='성춘향';
 
 /*
 buid 칼럼을 기준으로 조회하기
 buid column은 TABLE을 create 할 때 PK(PRIMARY KEY) 성질을 설정하였다
 PK로 설정된 column은 유일성, NOT NULL 속성을 갖게 된다
 
 만약 이 column에 이미 있는 데이터를 또 다시 추가하려고 하면 
 다음과 같은 오류가 발생한다.
 ***ORA-00001: 무결성 제약 조건(C##MYUSER.SYS_C008316)에 위배됩니다***
 PK column에 0001이라는 값을 갖는 데이터가 있는데 또 다시 0001 이라는 데이터를
 추가하려고 했기 때문에 발생하는 오류
 */
 
 select * from tbl_buyer where buid = '0001';
 
 -- 무결성 제약조건 오류
 -- 중복데이터 추가 오류
 insert into tbl_buyer(buid, buname)
 values('0001', '임꺽정');
 
 /*
 ORA-01400: NULL을 ("C##MYUSER"."TBL_BUYER"."BUID") 안에 삽입할 수 없습니다
 ORA-01400: NULL을 ("C##MYUSER"."TBL_BUYER"."BUNAME") 안에 삽입할 수 없습니다
 현재 INSERT 명령을 수행하면서 buid 그리고 bunamedp 해당하는 값을 지정(저장)하지 않았다
 buid와 buname은 TABLE을 생성할 때 NOT NULL 성질을 주었기 때문에
 새로운 데이터를 추가(INSERT)할 때 필수적으로 값이 필요하다.
 이러한 설정을 "제약조건" 설정 이라고 한다.
 데이터를 추가할 때 조금이라도 문제가 있는 데이터를 추가하여
 전체 데이터베이스에 문제가 발생하는 것을 방지하는 목적이다.
 => "무결성 유지" 라고 한다.
 */
 insert into tbl_buyer(buname)
 values('임꺽정');
 
 insert into tbl_buyer(buid)
 values('0004');
 
 insert into tbl_buyer(buid, buname)
 values('0004', '임꺽정');
 
 select * from tbl_buyer;
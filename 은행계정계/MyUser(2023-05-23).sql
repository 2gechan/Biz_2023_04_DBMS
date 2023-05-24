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
 
 /*
 TABLE : Entity를 물리적으로 구현한 상태
 데이터를 보관, 관리하는 기본적인 frame(형틀)이다.
 DBMS 소프트웨어 마다 데이터를 저장하는 방법은 각각 고유한 기술적 부분이다
 이러한 부분을 DB 개발자, 사용자가 알 필요는 없다
 DMBS 에서는 개발자, 사용자가 바라보는 모든 데이터는 TABLE(표) 형식이다
 
 TABLE을 작성하기 앞서, 개념적, 논리적 모델링을 수행하는데 이 단계에서는
 TABLE을 Entity라고 한다.
 
 프로그래밍(Java 등) 에서는 TABLE을 객체, 개체 등으로 취급한다.
 Java의 데이터 클래스가 여기에 해당한다.
 */
 
 -- 계좌정보
 
 create table tbl_acc (
	acNum	VARCHAR2(10)		PRIMARY KEY,
    acDiv	VARCHAR2(1)	NOT NULL,
    buId	VARCHAR2(5)	NOT NULL,
	acBalance	NUMBER	DEFAULT 0
 );
 
 select * from tbl_buyer;
 
 update tbl_buyer set butel='010-333-3333' where buid='0003';
 
 select * from tbl_buyer;
 
 -- update, delete 를 수행할 때는 PK 가 아닌 column을 기준으로 하지마라
 -- 만약 PK가 아닌 column을 기준으로 할 때는 매우 신중하게 명령을 수행해야 한다
 update tbl_buyer set butel='010-444-4444' where buname='임꺽정';
 
 /*
 tbl_buyer 테이블에 성춘향 데이터 중에서 전화번호가 없는 데이터가 있다
 전화번호가 없는 성춘향 데이터의 전화번호를 010-333-333으로변경하고자 한다
 
 1. buname column의 데이터가 성춘향인 리스트를 조회
 select * from tbl_buyer where buname='성춘향';
 
 2. 전화번호가 없는(null) 데이터의 buid 값을 확인한다 : 0003
 
 3. buid(PK coulmn)을 기준으로 update를 실시
 update tbl_buyer set butel = '010-333-333' where buid='0003';
 */
 
 -- buid column명 acBuID로 변경
 ALTER TABLE tbl_acc RENAME COLUMN buid TO acBuId;
 
 /*
 1. 전체 고객 데이터를 조회
 이몽룡의 주소가 현재 서울특별시 이다
 그런데 이몽룡이 전라북도 익산시로 이사했다
 2. 이몽룡의 주소를 서울특별시에서 전라북도 익산시로 변경하고자 한다.
 */
 
 select * from tbl_buyer where buname='이몽룡';
 
 update tbl_buyer set buaddr='전라북도 익산시' where buid='0001';
 
 select * from tbl_buyer;
 
 -- 불필요한 데이터 삭제하기
 delete from tbl_buyer
 where buid = '0004';
 
 select * from tbl_buyer;
 
 -- 데이터 추가
 -- 칼럼목록 개수, 순서 = 데이터목록 개수, 순서가 일치해야한다.
 INSERT INTO [table] (칼럼목록) VALUES(데이터목록);
 
 -- 데이터 조회
 SELECT 칼럼목록 FROM [table] WHERE 칼럼 = 값;
 
 -- 데이터 수정
 UPDATE [table] SET 칼럼 = 값 --> 변경할 변수와 값
                WHERE 칼럼 = 값 --> 변경할 조건
                
 -- 데이터 삭제
 DELETE FROM [table] WHERE 칼럼 = 값 --> 삭제할 조건
 
  -- 계좌정보
 
 create table tbl_acc (
	acNum	VARCHAR2(10)		PRIMARY KEY,
    acDiv	VARCHAR2(1)	NOT NULL,
    acBuId	VARCHAR2(5)	NOT NULL,
	acBalance	NUMBER	DEFAULT 0
 );
 
 insert into tbl_acc(acNum, acDiv, acBuId, acBalance)
 values('2023052301', '1', '0003', 10000);
 
 insert into tbl_acc(acNum, acDiv, acBuId, acBalance)
 values('2023052302', '1', '0001', 50000);
 
 insert into tbl_acc(acNum, acDiv, acBuId, acBalance)
 values('2023052303', '1', '0002', 10000);
 
 select * from tbl_acc;
 
 /*
 현재 계좌정보를 조회했는데
 계좌정보가 고객ID 뿐이어서 고객에 대한 이름, 전화번호 등을 알 수가 없다
 고객정보와 계좌정보를 연계하여 함께 볼 수 있도록 해야한다.
 
 Table JOIN
 2개(이상)의 Table을 서로 연계하여 하나의 리스트로 보기
 
 tbl_acc와 tbl_buyer 테이블을 연계하여 하나의 리스트로 보여라
 이 때 tbl_acc의 acbuid와 tbl_buyer의 buid 칼럼의 데이터를 비교하여
 같은 데이터는 한 라인에 보여라
 */
 
 select * from tbl_acc, tbl_buyer
 where acbuid = buid;
 
 -- join을 하되 4개의 컬럼만 화면에 나타내고 싶다
 select acnum, acbuid, buname, butel 
 from tbl_acc, tbl_buyer
 where acbuid = buid;
 
 select * from tbl_buyer;
 
 -- Projection : select 조회를 할 때 별표(*)를 사용하지 않고 column을 나열하는 것
 select buid, buname, butel, buaddr, bubirth, bujob
 from tbl_buyer
 order by buid;
 
 select buid, buname, butel, buaddr, bubirth, bujob
 from tbl_buyer
 order by buname, butel;
 
 insert into tbl_buyer(buid, buname, butel)
 values('0004', '임꺽정', '010-444-4444');
 
 /*
 SQL Developer와 Java 코드에서 DB를 서로 연동하여 처리하는 경우 발생하는 문제
 SQD 에서 데이터를 INSER, UPDATE, DELETE 를 수행하는 경우
        추가, 수정, 삭제된 정보는 아직 storage에 반영되지 않고
        메모리에 임시 저장된 상태이다
 이 상태일 때 JAVA 에서 SELECt 를 수행하면 INSER, UPDATE, DELETE 된 데이터가
 아닌 이전 상태의 데이터가 조회된다
 간혹 이 상황에서 DBMS가 Connection에서 무한정 응답하지 않는 경우도 있다
 java는 DBMS 가 응답하기를 기다리면서 무한정 기다리고 마치 프로젝트가 멈춘(Down)
 상태가 되어 버린다.
 
 SQD 에서 INSERT, UPDATE, DELETE 를 수행한 다음에는
 강제로 storage에 Commit을 해 주어야 한다.
 그래야만 Java 프로젝트에서 데이터를 조회할 수 있다.
 */
 COMMIT;
 
 select * from tbl_buyer;
 
 insert into tbl_buyer(buid, buname)
 values('0005', '장길산');
 
 -- commit 이 되기 전의 데이터를 취소하는 명령
 ROLLBACK;
 
 select * from tbl_buyer;
 
 -- PK 칼럽을 기준으로 조건을 설정하여 조회하기
 -- PK 칼럼을 기준으로 조회를 하면 데이터가 없거나 한개만 조회된다
 select buid, buname, butel, buaddr, bubirth, bujob
 from tbl_buyer
 where buid = '0001';
 
 insert into tbl_buyer(buid, buname, butel)
 values('0001', '이몽룡', '010-111-1111');
 
 update tbl_buyer
 set buname = '',
     butel = '',
     buaddr = '',
     bubirth = '',
     bujob = '',
 where buid = '';
 
 select buid, buname, butel, buaddr, bubirth, bujob
 from tbl_buyer;
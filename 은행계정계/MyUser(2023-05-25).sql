 -- 여기는 MyUser로 접속한 화면
 
 drop table tbl_accList;
 
 create table tbl_accList (
     aioSEQ	    NUMBER		PRIMARY KEY,
     acNum	    VARCHAR2(20)	NOT NULL,	
     aioDate	VARCHAR2(10)	NOT NULL,
     aioTime	VARCHAR2(10)	NOT NULL,
     aioDiv	    VARCHAR2(1)	NOT NULL,
     aioInput	NUMBER	DEFAULT 0,
     aioOutput	NUMBER	DEFAULT 0,
     aioREM	    VARCHAR2(30)
 );
 
 /*
 DBMS table의 일련번호 문제
 Table에 PK를 임의의 일련번호로 설정했을 경우
 데이터를 insert 할 때 마다 새로운 일련번호를 생성하여 값을 추가해야 한다
 
 DBMS 엔진에 따라 insert를 할 때 자동으로 일련번호를 생성하는 기능이 있는데
 오라클에는 없다(11이하 버전), 오라클도 12이상에서는 자동생성하는 기능이 있는데
 다른 DBMS에 비하여 상당히 불편하다
 
 오라클에서는 일련번호를 자동으로 생성해주는 도구를 만들어야 한다.
 */
 drop sequence seq_accList;
 create sequence seq_accList
 start with 1 increment by 1;
 
 select seq_accList.nextval from dual;
 
 insert into tbl_accList(aioseq, acnum, aiodate, aiotime, aiodiv, aioinput, aiooutput)
 values(seq_accList.nextval, '2023052401', '2023-05-24', '11:10:00', '1', 10000, 0);
 
 select * from tbl_accList order by aioseq;
 
 select * from tbl_acc;
 
 
 
 
 
 
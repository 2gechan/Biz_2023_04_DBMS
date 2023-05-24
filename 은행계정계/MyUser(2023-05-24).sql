 -- 여기는 MyUser(C##myuser) 로 접속한 화면
 
 select * from tbl_acc;
 
 insert into tbl_acc(acnum, acdiv, acbuid, acbalance)
 values('2023052401','1','0001',10000);
 
 insert into tbl_acc(acnum, acdiv, acbuid, acbalance)
 values('2023052402','2','0003',10000);
 
 select * from tbl_acc;
 
 commit;
 
 select * from tbl_acc where acbuid = '0001' order by acnum;
 
 -- 고객 id가 0001인 고객의 계좌정보를 잔액이 적은 순으로 정렬하여 보이기(오름차순)
 -- asc(오름차순 정렬)은 defalut 값이라 명시하지 않아도 됨
 select * from tbl_acc where acbuid = '0001' order by acbalance asc;
 
 -- 고객 id가 0001인 고객의 계좌정보를 잔액이 많은 순으로 정렬하여 보이기(내림차순)
 select * from tbl_acc where acbuid = '0001' order by acbalance desc;
 
 -- id가 0001 이거나 0003인 데이터 찾기
 select * from tbl_acc where acbuid = '0001' or acbuid = '0003';
 
 select * from tbl_acc where acbalance >= 20000;
 
 -- 1개의 칼럼에 다수의 조건 검색이 필요한 경우
 -- or 연산일 경우 in 키워드를 사용할 수 있다
 select * from tbl_acc where acbuid in ('0001', '0003');
 
 -- 잔액이 10000 ~ 20000 인 데이터 조회
 select * from tbl_acc where acbalance >= 10000 and acbalance <= 20000;
 
 -- 각각 범위 값이 포함관계(>=, <=) 인 경우
 -- between 키워드로 검색 가능
 select * from tbl_acc where acbalance between 10000 and 20000;
 
 -- where 절 뒤에 not 키워드를 붙히면 조건의 부정하는 데이터를 찾아낼 수 있다
 select * from tbl_acc where not acbuid in ('0001', '0003');
 
 -- 위와 같은 결과 값을 얻는 코드   !=    <>
 select * from tbl_acc where acbuid != '0001' and acbuid <> '0003';
 
 describe tbl_acc;
 
 -- table의 구조 변경(DDL 명령을 사용)
 -- table의 구조를 변경하는 것은 상당히 많은 비용이 소요된다
 -- 초기에 설계가 잘못된 경우 구조 변경을 실시하는데 상당한 주의를 기울여야 한다
 -- 구조 변경 과정에서 문제가 발생하면 데이터가 손상되는 문제가 있다
 -- 구조 변경 할 때 칼럼의 크기는 절대 줄여서 변경하면 안된다
 
 -- tbl_acc의 acNum 칼럼의 길이가 VARCHAR2(10) 인데
 -- 이 칼럼의 길이를 VARCHAR2(20)으로 변경
 alter table tbl_acc modify (acnum varchar2(20));
 desc tbl_acc;
 
 select * from tbl_acc;
 
 -- SQL 에는 기본적으로 여러 기능을 수행하는 함수들이 내장되어 잇다
 -- substr(칼럼,시작,개수) : 칼럼의 문자열을 시작 위치부터 개수 만큼 잘라내기
 -- max(칼럼) : 전체 리스트(조건에 맞는 데이터) 중에서 해당 칼럼의 가장 큰 값을 찾기
 -- min(칼럼) : 전체 리스트(조건에 맞는 데이터) 중에서 해당 칼럼의 가장 작은 값을 찾기
 select max(acnum)
 from tbl_acc 
 where substr(acNum,0,8) = '20230524';
 
 select substr(max(acnum),9)
 from tbl_acc 
 where substr(acNum,0,8) = '20230524';
 
 select * from tbl_acc;
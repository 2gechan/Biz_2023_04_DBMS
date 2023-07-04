 -- addr 사용자 화면
 
 -- 주소록 + 취미정보가 있는 데이터를 정규화 하여 Relation 설정하기
 
 create table tbl_temp_hb (
    hb_aid	VARCHAR2(5),
    hb_name1	nVARCHAR2(30),
    hb_name2	nVARCHAR2(30),
    hb_name3	nVARCHAR2(30)
 );
 
 
 select * from tbl_temp_hb;
 
 select count(*) from tbl_temp_hb;
 
 /*
 가로로 나열된 데이터를 세로로 배치하기
 
 제1정규화가 된 취미 데이터는 취미1, 취미2, 취미3 칼럼이 만들어진 table 이다
 이 테이블에 만약 4번째 취미를 추가하고 싶으면,
    새로운 칼럼을 추가하거나
    4번째 취미를 다른 취미항목으로 교체해야 한다.
    
    만약 취미항목이 늘어나 칼럼을 추가하게 되면
    Table 구조를 변경해야 하고, 상당히 많은 비용이 요구된다.(시간 등)
    또한 Table 구조를 변경하는 것은 매우 신중하게 처리해야 한다.
    다른 어플리케이션과 연동되는 Table의 구조를 변경하면
    아주 많은 부분에서 변경을 해야하는 경우도 있다.
    
    만약 취미 항목이 3개 미만인 경우는 데이터가 저장되지 않은 칼럼이 발생하고
    이 칼럼들은 보통 null 값으로 채워진다.
    
    Table의 칼럼에 null값이 많은 것은 별로 좋은 현상이 아니다.
 */
 select hb_aid, hb_name1 from tbl_temp_hb
 UNION ALL
 select hb_aid, hb_name2 from tbl_temp_hb
 where hb_name2 is not null
 UNION ALL
 select hb_aid, hb_name3 from tbl_temp_hb
 where hb_name3 is not null
 order by hb_aid;
 
 create table tbl_hobby (
    hb_seq	NUMBER		Primary key,
    hb_aid	VARCHAR2(5)	NOT NULL,
    hb_name	nVARCHAR2(30)	NOT NULL
 );
 
 select * from tbl_hobby order by hb_seq;
 
 -- 취미정보 제3정규화
 /*
 DDL 명령 : DBA가 사용하는 명령들, 물리적 객체 생성, 제거, 변경을 수행하는 명령
 CREATE : 객체 생성, 최초 프로젝트 시작할 때
 DROP : 객체 제거, 최초 프로젝트 시작할 때 잘못 생성된 객체를 다시 만들고자 할 때
 ALTER : 객체 변경, 사용중에 중요한 변경사항이 발생했을 때
                    구조 변경을 수행하는 명령
                    구조 변경은 매우 신중하게 수행해야 한다.
 */
 -- tbl_hobby table의 이름 변경
 alter table tbl_hobby
 RENAME TO tbl_addr_hobby;
 
 select * from tbl_addr_hobby;
 
 /*
 주소 취미 Relation Table의 제3정규화
 제2정규화가 되어 있는 tbl_addr_hobby Table에는
 주소록의 id(hb_aid)와 취미이름(hb_name)이 저장되어 있다.
 hb_aid 칼럼은 주소 테이블과 연계되어 있지만
 hb_name 칼럼은 평범한 문자열로 구성되어 있다.
 
 만약 어떤 취미의 명칭을 변경하고자 할때는
 update tbl_addr_hobby
 set hb_name = '변경할이름'
 where hb_name = '원래이름'
 
 과 같은 sql을 사용해야 한다.
 이 SQL은 table의 데이터를 다수 변경하는 명령이 된다.
 update 명령은 기본적으로 PK를 기준으로 1개의 데이터만 변경되도록 하는 것이 좋다.
 하지만 이 명령은 이러한 원칙에 위배된다.
 
 이때 업데이트, 삭제를 수행하는 과정에서
 이 테이블에는 수정이상, 삭제이상 현상이 발생할 수 있다.
 또한 취미정보를 추가하는 과정에서 유사한 취미가 다른 형식으로 등록되는 경우도 있다.
 
 이러한 여러가지 문제를 방지하기 위하여 table을 분리하여 제3정규화를 수행한다.
 
 1. 기존의 table에서 일반문자열로 되어있는 부분을 떼어 새로운 table에 옮긴다.
 2. 기존 table과 새로운 table간에 Relation 설정을 한다.
 */
 
 -- 1. tbl_hobby table의 이름변경 : Entity를 Relation으로 이름 변경
 alter table tbl_hobby
 RENAME TO tbl_addr_hobby;
 
 select * from tbl_addr_hobby;
 
 -- 2. 취미 Relation에서 취미이름 항목을 중복데이터 없이 추출하기
 --     중복 없이 데이터를 모으기
 -- hb_name 칼럼의 데이터를 같은 데이터끼리 그룹(묶어)지어 리스트를 만든다.
 -- GROUP BY : 중복 데이터 없이 항목 묶기
 select hb_name
 from tbl_addr_hobby
 group by hb_name
 order by hb_name;
 
 -- 3. 제3정규화 데이터 import
 -- 주의! 기존 제2정규화 데이터를 엑셀로 보내서 제3정규화 데이터가 완료된 후
 -- 다음을 진행할 것
 -- 기존 table이였던 tbl_addr_hobby table을 드롭하고 새로운 구조로 생성하기
 DROP TABLE tbl_addr_hobby;
 create table tbl_addr_hobby (
 ah_seq	NUMBER		PRIMARY KEY,
 ah_aid	VARCHAR2(5)	NOT NULL,
 ah_hbcode	VARCHAR2(5)	NOT NULL	
);

 desc tbl_addr_hobby;
 
 select count(*) from tbl_addr_hobby;
 
 select * from tbl_addr_hobby
 order by ah_hbcode;
 
 select ah_hbcode from tbl_addr_hobby
 group by ah_hbcode
 order by ah_hbcode;
 
 -- 4. 취미 Entity import
 create table tbl_hobby(
    hb_code	VARCHAR2(5)		PRIMARY KEY,
    hb_name	nVARCHAR2(30)	NOT NULL,
    hb_descrip	nVARCHAR2(400)
);

 select count(*) from tbl_hobby;
 
 select * from tbl_hobby
 order by hb_code;
 
 /*
 -- table JOIN
 정규화(2,3정규화) 된 table의 정보를 select(조회)하면
 단순히 1개 table만으로는 어떤 정보를 보여주고 있는지 알 수가 없다.
 2,3 정규화된 table은 필연적으로 table 간의 JOIN이 되어야만 정보를
 명확히 알 수 있다.
 JOIN은 2개 이상의 Table을 서로 연계하여 필요한 정보를 확인하는 것이다.
 */
 select *
 from tbl_addr_hobby, tbl_address;
 
 -- tbl_addr_hobby 곱하기 tbl_address
 -- 카티션곱
 select count(*)
 from tbl_addr_hobby, tbl_address;
 
 -- addr_hobby Relation과 address Entity 테이블을 나열하되
 -- 두 테이블의 칼럼 ah_aid와 a_id의 데이터가 일치한 정보만 나열하라
 -- EQ JOIN
 -- EQ JOIN은 모든 JOIN 방식중에 가장 빠르다. 단 참조무결성 제약조건이
 -- 완벽해야 한다.
 
 -- EQ JOIN은 연계하는 Table간에 참조무결성 제약조건이 완벽할때는
 -- 아무런 문제가 없이 결과를 조회할 수 있다.
 -- 하지만 연계하는 Table간에 참조무결성 제약조건이 위배되면
 -- 조회된 데이터를 신뢰할 수 없다.
 select *
 from tbl_addr_hobby, tbl_address
 where ah_aid = a_id;
 
 select ah_aid, a_name, a_tel, a_addr, ah_hbcode
 from tbl_addr_hobby, tbl_address
 where ah_aid = a_id;
 
 select count(*)
 from tbl_addr_hobby, tbl_address
 where ah_aid = a_id;
 
 select count(*)
 from tbl_addr_hobby;
 
 -- LEFT JOIN
 -- JOIN을 실행하는 Table간에 참조무결성이 의심스럽거나 위배될지 모른다는
 -- 전제하에 데이터를 확인하는 JOIN
 -- FROM [table1] LEFT JOIN [table2]
 -- 왼쪽(LEFT)의 table1 데이터는 무조건 전부 select하고
 -- 오른쪽의 table2 데이터는 on 에서 설정한 조건에 맞는 것만 가져오기
 -- 오른쪽의 Table2의 조건에 맞는 데이터가 있으면 보여주고,
 --      없으면 null로 표현하기
 -- 1. select한 데이터의 누락이 발생하지 않는다.
 -- 2. 참조 무결성 제약 조건이 완벽하게 성립하는지 확인하는 용도
 select ah_aid, a_name, a_tel, a_addr, ah_hbcode
 from tbl_addr_hobby
    left join tbl_address
        on ah_aid = a_id
 order by ah_aid;
 
 -- 주소취미 Relation과 주소 Entity간의 참조 무결성 검사
 -- 이 결과에서 list가 한개도 나오지 않아야 한다.
 select ah_aid, a_name, a_tel, a_addr, ah_hbcode
 from tbl_addr_hobby
    left join tbl_address
        on ah_aid = a_id
    where a_name is Null;
 order by ah_aid;
 
 select ah_aid, ah_hbcode, hb_name
 from tbl_addr_hobby
        left join tbl_hobby
            on ah_hbcode = hb_code;
            
 -- 주소취미 Relation과 취미 Entity간의 참조 무결성 검사
 -- 이 결과도 리스트가 한개도 나오지 않아야 한다.
 select ah_aid, ah_hbcode, hb_name
 from tbl_addr_hobby
        left join tbl_hobby
            on ah_hbcode = hb_code
 where hb_name is null;
 
 -- 현재 tbl_address table의 데이터가 테스트 과정에서 문제가 생겼다.
 -- 저장된 데이터를 모두 clear하고, 엑셀의 데이터로 다시 import하자
 
 -- 기존의 테이블을 drop하고 다시 create table 하라
 truncate table tbl_address;
 select * from tbl_address;
 
 select ah_aid, ah_hbcode, a_name, a_tel, a_addr
 from tbl_addr_hobby
    left join tbl_address
        on ah_aid = a_id
 where ah_aid < 'A0020'
 order by ah_aid;
 
 select ah_aid, ah_hbcode, hb_name, hb_descrip
 from tbl_addr_hobby
    left join tbl_hobby
        on ah_hbcode = hb_code;
        
        
 -- view의 생성
 -- 물리적 table에 sql을 적용하여 작성하였더니 다소 복잡한 sql이 완성되었다
 -- 이후 이 sql을 사용할 일이 많을 것 같다.
 -- 그래서 이 sql을 view로 생성하였다.
 -- view는 일반적으로 Read Only(Select만 가능하다.)
 CREATE VIEW view_addr_hobby
 AS(
 select ah_aid, ah_hbcode, hb_name, a_name, a_tel, a_addr
 from tbl_addr_hobby
    left join tbl_address
        on ah_aid = a_id
    left join tbl_hobby
        on ah_hbcode = hb_code
 );
 
 select * from view_addr_hobby;
 
 select * from view_addr_hobby
 where ah_aid = 'A0002';
 
 
 drop view view_addr_hobby;
 CREATE VIEW view_addr_hobby
 AS(
 select ah_aid AS 아이디, ah_hbcode AS 취미코드, hb_name AS 취미,
 a_name AS 이름, a_tel AS 전화번호, a_addr AS 주소
 from tbl_addr_hobby
    left join tbl_address
        on ah_aid = a_id
    left join tbl_hobby
        on ah_hbcode = hb_code
 );
 
 select * from view_addr_hobby;
 
 -- 참조 무결성 설정하기 : FOREIGN KEY 설정하기
 -- 연계된 Entity, Relation 간에 참조관계가 잘 유지되도록,
 -- Table에 제약조건을 설정하는 것
 -- 1. FK는 Relation Table에 설정한다.
 -- 2. FK 는 1:N 관계 Table에서 N의 Table에 설정한다.
 
 -- addr_hobby와 address 간의 FK 설정
 ALTER TABLE tbl_addr_hobby -- tbl_addr_hobby table(Relation table)
 add constraint f_addr -- f_addr 이름으로 제약조건을 추가하겠다.
 FOREIGN KEY (ah_aid) -- tbl_addr_hobby의 ah_aid 칼럼을
 REFERENCES tbl_address(a_id); -- tbl_address의 a_id 칼럼과 연계
 
 delete from tbl_address where a_id = 'A0001';
 
 -- addr_hobby와 hobby 간의 FK 설정하기
 ALTER TABLE tbl_addr_hobby -- tbl_addr_hobby table(Relation table)
 add constraint f_hobby -- f_hobby 이름으로 제약조건을 추가하겠다.
 FOREIGN KEY (ah_hbcode) -- tbl_addr_hobby의 ah_hbcode 칼럼을
 REFERENCES tbl_hobby(hb_code); -- tbl_hobby의 hb_code 칼럼과 연계
 
 
 /*
 table의 FK 연계조건
 ----------------------------------------------------
 tbl_address        tbl_hobby       tbl_addr_hobby
 ----------------------------------------------------
   코드가 있다 >>                   코드가 있을 수 있다
                    코드가 있다 >>  코드가 있을 수 있다
   
 ----------------------------------------------------
   코드가 없다 >>                   절대 없다
                    코드가 없다 >>  절대 없다
 ----------------------------------------------------
   반드시 있어야 한다               << 코드가 있다
                 반드시 있어야 한다 << 코드가 있다
 ----------------------------------------------------
   삭제할 수 없다                   << 코드가 있다
                   삭제할 수 없다   << 코드가 있다
 ----------------------------------------------------
 */
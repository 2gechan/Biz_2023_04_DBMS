 -- 여기는 addr USER 화면
 /*
 tbl_address table 에 대하여 다음 결과를 확인하는 SQL을 작성
 1. table에 저장된 전체 데이터의 개수는 몇 개 인가
 2. table에 저장된 전체 리스트를 전화번호 순으로 정렬하여 확인하기
 3. table에 저장된 전체 리스트를 이름 순으로 정렬하여 확인하기
 4. table에 저장된 전체 리스트중에 성씨가 "김"으로 시작되는 리스트 확인하기
 5. table에 저장된 전체 리스트중에 전화번호가 국번 (090-222-1234 중에 두번째 구역)
    이 3으로 시작되는 리스트의 개수는 몇 개 인가
 */
 
 -- 1번
 select count(*) from tbl_address;
 
 -- 2번
 -- order by의 ASC는 오름차순으로 default 값이다 desc는 내림차순
 select * from tbl_address order by a_tel ASC;
 select * from tbl_address order by a_tel desc;
 
 -- 3번
 select * from tbl_address order by a_name;
 
 -- ID 순으로 정렬하고 같은 ID가 있으면 그 그룹내에서 이름순으로 정렬
 select * from tbl_address order by a_id, a_name;
 
 -- ID 순으로 오름차순 정렬하고 
 -- 같은 ID가 있으면 그 그룹내에서 이름순으로 내림차순 정렬
 select * from tbl_address order by a_id, a_name desc;
 
 -- 4번
 select * from tbl_address where a_name like '이%';
 
 -- 5번
 select count(*) from tbl_address where a_tel like '090-3%';
 
 select count(*) from tbl_address where substr(a_tel, 5,1) = '3' order by a_tel;
 
 -- 전화번호가 국번이 3으로 시작되는 전화 번호 중에서
 -- ID가 가장 큰 데이터와, ID가 가장 작은 데이터를 찾으시오
 select max(a_id), min(a_id) from tbl_address where substr(a_tel, 5,1) = '3';
 
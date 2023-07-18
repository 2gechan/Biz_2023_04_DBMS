-- MyCar root 화면
create database mycardb;
use mycardb;

create table tbl_carmanager (
c_seq		BIGINT		PRIMARY KEY	AUTO_INCREMENT,
c_carnum	VARCHAR(15)	NOT NULL,
c_qty		VARCHAR(10)	NOT NULL,
c_username	VARCHAR(20)	NOT NULL,	
c_sdate		VARCHAR(10)	NOT NULL,
c_stime		VARCHAR(10)	NOT NULL,
c_goal		VARCHAR(30),
c_edate		VARCHAR(10),
c_etime		VARCHAR(10),
c_skm		INT,
c_ekm		INT,
c_cost		INT
);
insert into 
tbl_carmanager(c_carnum, c_qty, c_username, c_sdate, c_stime, c_skm, c_ekm)
values('001', '출근', 'gechan', '2023-07-01', '07:00:00', 3000, 3010);
insert into 
tbl_carmanager(c_carnum, c_qty, c_username, c_sdate, c_stime, c_skm, c_ekm)
values('001', '출근', 'gechan', '2023-07-01', '18:00:00', 3010, 3020);

insert into 
tbl_carmanager(c_carnum, c_qty, c_username, c_sdate, c_stime, c_skm, c_ekm)
values('002', '서울출장', 'gechan', '2023-07-01', '07:00:00', 10000, 10300);
insert into 
tbl_carmanager(c_carnum, c_qty, c_username, c_sdate, c_stime, c_skm, c_ekm)
values('002', '출장복귀', 'gechan', '2023-07-01', '18:00:00', 10300, 10600);

commit;

select * from tbl_carmanager
where c_carnum = '001'
order by c_sdate desc, c_stime desc
LIMIT 1;


 -- shop 화면
 
 drop table tbl_product;
 create table tbl_product (
 pCode	VARCHAR2(13)		PRIMARY KEY,
 pName	nVARCHAR2(50)	NOT NULL,
 pItem	nVARCHAR2(10)	NOT NULL,
 pIPrice	NUMBER	DEFAULT 0,
 pOPrice	NUMBER	DEFAULT 0
 );
 
 drop table tbl_buyer;
 create table tbl_buyer (
 buId	VARCHAR2(10)		PRIMARY KEY,
 buName	nVARCHAR2(20)	NOT NULL	,
 buTel	VARCHAR2(12)		,
 buAddr	nVARCHAR2(125)		
 );
 
 create table tbl_iolist (
 ioSEQ	NUMBER		PRIMARY KEY,
 ioDate	VARCHAR2(10)	NOT NULL,	
 ioTime	VARCHAR2(10)	NOT NULL,	
 ioBuId	VARCHAR2(10)	NOT NULL,	
 ioPCode	VARCHAR2(13)	NOT NULL	,
 ioQuan	NUMBER	NOT NULL	,
 ioPrice	NUMBER	NOT NULL	
 );
 
 create sequence seq_shop
 start with 1 increment by 1;
 
 /*
 insert into tbl_iolist(ioSEQ, ioDate, ioTime, ioBuId, ioPCode, ioQuan, ioPrice)
 values(seq_shop.nextval, '2023-05-30', '10:22:00', '고객ID', '상품코드', 1, 10000);
 */
 
 insert into tbl_product(pcode, pname, pitem, piprice, poprice)
 values('0000000000001', '오이', '야채', 3000, 3300);
 
 select * from tbl_product;
 commit;
 
 select * from tbl_ioList;
 
 
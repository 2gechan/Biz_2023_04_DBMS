 -- 2023-05-30 관리자 화면
 
  -- Shopping Cart
 CREATE TABLESPACE shop
 DATAFILE 'C:/app/data/shop.dbf'
 SIZE 1M AUTOEXTEND ON NEXT 1K;
 
  alter session set "_ORACLE_SCRIPT" = true;
 
 create user shop IDENTIFIED BY 12341234
 default tablespace shop;
 
 grant dba to shop;
 
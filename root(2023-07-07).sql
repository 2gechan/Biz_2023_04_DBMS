-- 여기는 root 화면

-- 유저 삭제
DROP USER 'todo'@'localhost';
DROP USER 'todo'@'192.168.4.%';
DROP USER 'todo'@'%';

-- 사용자 생성
drop user todo@localhost;
create user todo@localhost IDENTIFIED By '88888888';
-- 권한 부여
grant all PRIVILEGES on todoDB.* to todo@localhost;
-- 권한 적용
flush PRIVILEGES;

-- MySQL의 SCHEME 생성
create database scoreDB;

grant all PRIVILEGES on scoreDB.* to todo@localhost;
flush PRIVILEGES;
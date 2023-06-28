 -- DBA 권한을 부여 받은 MEMO 사용자 접속 화면
 
 drop table memo;
 
 create table tbl_memo(
    m_seq	    NUMBER		    PRIMARY KEY,
    m_writer	nVARCHAR2(20)	NOT NULL,
    m_date	    VARCHAR2(10),
    m_subject	nVARCHAR2(20),
    m_content	nVARCHAR2(400)
 );
 
 create sequence seq_memo
 start with 1 increment by 1;
 
 -- insert into tbl_memo(m_seq, m_writer, m_date, m_subject, m_content)
 -- values(seq_memo.nextval, '김길동', '2023-05-26', '제목', '내용');
 
 -- select * from tbl_memo;
 
 -- update tbl_memo set ? = ? where m_seq = ?;
 
 -- delete from tbl_name where m_seq = ?;
 
 insert into tbl_memo(m_seq, m_writer, m_date, m_subject, m_content)
 values(seq_memo.nextval, '김길동', '2023-05-26', '제목', '내용');
 
 select * from tbl_memo;
 
 commit;
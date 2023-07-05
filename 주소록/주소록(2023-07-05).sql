 -- addr User
 
 select * from tbl_addr_hobby;
 
 -- addr_hobby Relation Table과 hobby Entity Table을 Left Join 하여
 -- 주소ID, 취미코드, 취미이름, 취미설명 항목을 Projection 하도록
 
 select * from tbl_hobby;
 
 select ah_aid, ah_hbcode, hb_name, hb_descrip
 from tbl_addr_hobby
    left join tbl_hobby
        on ah_hbcode = hb_code;
        
 -- 특정한 주소ID가 지정되었을 때 해당 주소ID의 값만 selection 하기
 select ah_aid, ah_hbcode, hb_name, hb_descrip
 from tbl_addr_hobby
    left join tbl_hobby
        on ah_hbcode = hb_code
 where ah_aid = 'A0001';
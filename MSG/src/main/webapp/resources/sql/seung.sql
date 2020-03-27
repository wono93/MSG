insert into JSTREE_TB values('ajson1', '', '마케팅', '');
insert into JSTREE_TB values('ajson2', '', '경영지원부', '');
insert into JSTREE_TB values('ajson3', 'ajson2', '인사과', '');
insert into JSTREE_TB values('ajson4', 'ajson2', '총무부', '');
insert into JSTREE_TB values('ajson5', 'ajson4', '과장 장그래', 'jstree-file');
insert into JSTREE_TB values('ajson6', 'ajson4', '사원 김그래', 'jstree-file');
insert into JSTREE_TB values('ajson7', 'ajson2', '부장 천관웅', 'jstree-file');

commit;
select * from jstree_tb;


insert into jstree_mem_tb values('경영지원부', '부장 천관웅');
insert into jstree_mem_tb values('총무부', '과장 장그래');
insert into jstree_mem_tb values('총무부', '사원 김그래');

select * from jstree_mem_tb where name = '부장 천관웅';




select E.*, l.type_cd from edoc_tb E join leave_ltt_tb L on E.edoc_id = L.edoc_id;
select E.*, l.type_cd from edoc_tb E join ofc_ltt_tb L on E.edoc_id = L.edoc_id;

-- stored view : EDOC_ALL_TB
select * from (select E.*, O.type_cd from edoc_tb E join leave_ltt_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join ofc_ltt_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join invoice_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join cost_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join edoc_exp_tb O on E.edoc_id = O.edoc_id);

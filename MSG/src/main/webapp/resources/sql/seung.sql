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


select * from conf_rsvn_view;

select E.*, l.type_cd from edoc_tb E join leave_ltt_tb L on E.edoc_id = L.edoc_id;
select E.*, l.type_cd from edoc_tb E join ofc_ltt_tb L on E.edoc_id = L.edoc_id;

-- stored view : EDOC_ALL_TB
select * from edoc_all_tb;


select A."EDOC_ID",A."SECU_CD",A."PRSV_CD",A."EMP_NO",A."EMP_MOD_NO",A."EDOC_TITLE",A."EDOC_VER",A."EDOC_ORG_ID",A."EDOC_DT",A."EDOC_END",A."EDOC_END_DT",A."TYPE_CD", t.form_nm, p.prsv_amt, s.secu_nm, U.emp_name, F.flow_cd, C.flow_nm, F.emp_no flow_emp_no, F.flow_ord, F.flow_st
from 
(select * from (select E.*, O.type_cd from edoc_tb E join leave_ltt_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join ofc_ltt_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join invoice_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join cost_tb O on E.edoc_id = O.edoc_id)
union (select E.*, O.type_cd from edoc_tb E join edoc_exp_tb O on E.edoc_id = O.edoc_id)) A
join edoc_type_tb T on A.type_cd = T.type_cd
join preserv_tb P on A.prsv_cd = P.prsv_cd
join sec_lv_tb S on A.secu_cd = S.secu_cd
join emp_tb U on A.emp_no = U.emp_no
right join flow_exe_tb F on A.edoc_id = F.edoc_id
join flow_cd_tb C on F.flow_cd = C.flow_cd
where A.edoc_org_id is null;
and edoc_end = 'y';


select * from ((select * from car_rsvn_view) union (select * from conf_rsvn_view)) order by "res_use_date" desc;

select count(*) from edoc_tb where edoc_org_id is null;


-- SEQ_EDOC_ID 초기화용 프로시저 등록
CREATE OR REPLACE PROCEDURE PROC_SEQ_EDOC_ID_RESET(SEQ_EDOC_ID IN VARCHAR2)
IS
    L_VAL NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_EDOC_ID ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_EDOC_ID ||' INCREMENT BY -'|| L_VAL ||' MINVALUE 0';
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_EDOC_ID ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_EDOC_ID ||' INCREMENT BY 1 MINVALUE 0';
END;
/

--문서번호 예시, 아쉽게도 칼럼 default로 seq와 같은 의사 칼럼을 주는 것은 불가능하다
select 'ED-'||to_char(sysdate + 9/24,'yymmdd')||'-'||seq_edoc_id.NEXTVAL from dual;

select * from emp_tb join job_tb using(job_cd) join dept_tb using(dept_cd);
select * from job_tb;
select * from dept_tb;
--더미데이터 생성 / 일단 보류
select * from edoc_all_tb WHERE flow_emp_no = 13 order by edoc_dt desc;

-- flow 여기서부터 다시
select to_char(emp_no) id, dept_cd parent, job_name||' '||emp_name text, 'jstree-file' icon from emp_tb E join job_tb J on E.job_cd=J.job_cd
union
select dept_cd id, super_dept parent, dept_name text, '' icon from dept_tb;


-------------시퀀스 매일 초기화 하기------------------
-- 시퀀스 초기화 프로시저
create or replace PROCEDURE PROC_SEQ_EDOC_ID_RESET(SEQ_EDOC_ID IN VARCHAR2)
IS
    L_VAL NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_EDOC_ID ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_EDOC_ID ||' INCREMENT BY -'|| L_VAL ||' MINVALUE 0';
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_EDOC_ID ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_EDOC_ID ||' INCREMENT BY 1 MINVALUE 0';
END;
/
-- 시퀀스 nextval 값 늘리기
select seq_edoc_id.nextval from dual;
--프로시저 실행하기
EXEC PROC_SEQ_EDOC_ID_RESET();

EXEC proc_insert_work_clock;
select * from temp_work_tb;
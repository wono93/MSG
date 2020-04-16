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

select * from emp_tb;

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


-- 휴가 테이블
select * from absent_tb;


-----

select*from ch_member_tb M join;
(select*from ch_info_tb I left join
(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no)) R
on I.ch_no = R.ch_no);
on M.ch_no = ch_no
where M.emp_no = 1;

-- 사번, 채널명, 메시지 온 순서
select * from ch_msg_tb;
select * from ch_info_tb;
select * from ch_member_tb;

select A.*, M.emp_no, E.emp_name from
(select I.ch_no ch_no, I.ch_name ch_name, I.ch_ex ch_ex, M.msg_date msg_date, m.msg_content msg_content
from ch_info_tb I join
(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no)) M on I.ch_no=M.ch_no) A join ch_member_tb M on A.ch_no = M.ch_no left join emp_tb E on M.emp_no = E.emp_no
where M.emp_no = 1;

(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no));

select * from emp_tb;
select * from edoc_tb join leave_ltt_tb using(edoc_id);


select "EDOC_ID","SECU_CD","PRSV_CD","EMP_NO","EMP_MOD_NO","EDOC_TITLE","EDOC_VER","EDOC_ORG_ID","EDOC_DT","EDOC_END","EDOC_END_DT","VCTN_CD","START_DT","END_DT","LEAVE_AMT","LEAVE_PURPOSE","LEAVE_CONTACT","TYPE_CD","SUR_EMP_NO" from edoc_tb join leave_ltt_tb using(edoc_id);
select * from edoc_tb join leave_ltt_tb using(edoc_id);
select * from edoc_tb;
select * from leave_ltt_tb;
select * from emp_tb;


select * from leave_ltt_view;
select * from edoc_tb;
select * from leave_ltt_tb;

insert into
				edoc_tb
			values
				('ED-200404-3', 'S3','P4', 1, NULL, '테스트용', 0, NULL, sysdate, NULL, NULL)
    		into
				leave_ltt_tb
			values 
				('ED-200404-3', 'P4', to_date('2020-04-01', 'YYYY-MM-DD HH24:MI:SS'), to_date('2020-04-02', 'YYYY-MM-DD HH24:MI:SS'), 2, '테스트', '123', 'D5', 2)
select * from dual;


begin
    insert into edoc_tb values ('ED-200404-3', 'S3','P4', 1, NULL, '테스트용', 0, NULL, sysdate, NULL, NULL);
    insert into leave_ltt_tb values ('ED-200404-3', 'P4', to_date('2020-04-01', 'YYYY-MM-DD HH24:MI:SS'), to_date('2020-04-02', 'YYYY-MM-DD HH24:MI:SS'), 2, '테스트', '123', 'D5', 2);
    commit;
end;
/



select
			*
		from
			
 (select
				*
			from
				edoc_all_tb
			 WHERE NULL like '%' ||  NULL || '%' 
			)
		 WHERE 
				(emp_no = 1
				and edoc_end != 'y')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st != 'y'
				and flow_NM = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st = 'y'
				and edoc_end != 'y'
				and flow_NM = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_NM = '참조') 
		order by edoc_dt desc;
        
        
select A."EDOC_ID",A."SECU_CD",A."PRSV_CD",A."EMP_NO",A."EMP_MOD_NO",A."EDOC_TITLE",A."EDOC_VER",A."EDOC_ORG_ID",A."EDOC_DT",A."EDOC_END",A."EDOC_END_DT",A."TYPE_CD", t.form_nm, p.prsv_amt, s.secu_nm, U.emp_name, F.flow_cd, F.emp_no flow_emp_no, F.flow_ord, F.flow_st
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
left join flow_exe_tb F on A.edoc_id = F.edoc_id
join flow_cd_tb C on F.flow_cd = C.flow_cd
where A.edoc_org_id is null;




-- myList 페이지 쿼리문 논리
select distinct edoc_id, secu_cd, prsv_cd, emp_no, emp_mod_no, edoc_title, edoc_ver, edoc_org_id, edoc_dt, edoc_end, edoc_end_dt, type_cd, form_nm, prsv_amt, secu_nm, emp_name, flow_cd, flow_nm, flow_emp_no, flow_ord, flow_st
from
(select
			*
		from
			
 (select
				*
			from
				edoc_all_tb
			 WHERE edoc_title like '%' ||  NULL || '%'
					or
					emp_name like '%' ||  NULL || '%'
					or
					form_nm like '%' ||  NULL || '%'
					or
					edoc_id like '%' ||  NULL || '%' 
			)
		 WHERE 
				(emp_no = 1
				and edoc_end is NULL)
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st is NULL
				and flow_nm = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st = 'y'
				and edoc_end = 'y'
				and flow_nm = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_nm = '참조') 
)		order by edoc_dt desc;



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

select * from emp_tb;

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


-- 휴가 테이블
select * from absent_tb;


-----

select*from ch_member_tb M join;
(select*from ch_info_tb I left join
(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no)) R
on I.ch_no = R.ch_no);
on M.ch_no = ch_no
where M.emp_no = 1;

-- 사번, 채널명, 메시지 온 순서
select * from ch_msg_tb;
select * from ch_info_tb;
select * from ch_member_tb;

select A.*, M.emp_no, E.emp_name from
(select I.ch_no ch_no, I.ch_name ch_name, I.ch_ex ch_ex, M.msg_date msg_date, m.msg_content msg_content
from ch_info_tb I join
(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no)) M on I.ch_no=M.ch_no) A join ch_member_tb M on A.ch_no = M.ch_no left join emp_tb E on M.emp_no = E.emp_no
where M.emp_no = 1;

(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no));

select * from emp_tb;
select * from edoc_tb join leave_ltt_tb using(edoc_id);


select "EDOC_ID","SECU_CD","PRSV_CD","EMP_NO","EMP_MOD_NO","EDOC_TITLE","EDOC_VER","EDOC_ORG_ID","EDOC_DT","EDOC_END","EDOC_END_DT","VCTN_CD","START_DT","END_DT","LEAVE_AMT","LEAVE_PURPOSE","LEAVE_CONTACT","TYPE_CD","SUR_EMP_NO" from edoc_tb join leave_ltt_tb using(edoc_id);
select * from edoc_tb join leave_ltt_tb using(edoc_id);
select * from edoc_tb;
select * from leave_ltt_tb;
select * from emp_tb;


select * from leave_ltt_view;
select * from edoc_tb;
select * from leave_ltt_tb;

insert into
				edoc_tb
			values
				('ED-200404-3', 'S3','P4', 1, NULL, '테스트용', 0, NULL, sysdate, NULL, NULL)
    		into
				leave_ltt_tb
			values 
				('ED-200404-3', 'P4', to_date('2020-04-01', 'YYYY-MM-DD HH24:MI:SS'), to_date('2020-04-02', 'YYYY-MM-DD HH24:MI:SS'), 2, '테스트', '123', 'D5', 2)
select * from dual;


begin
    insert into edoc_tb values ('ED-200404-3', 'S3','P4', 1, NULL, '테스트용', 0, NULL, sysdate, NULL, NULL);
    insert into leave_ltt_tb values ('ED-200404-3', 'P4', to_date('2020-04-01', 'YYYY-MM-DD HH24:MI:SS'), to_date('2020-04-02', 'YYYY-MM-DD HH24:MI:SS'), 2, '테스트', '123', 'D5', 2);
    commit;
end;
/



select
			*
		from
			
 (select
				*
			from
				edoc_all_tb
			 WHERE NULL like '%' ||  NULL || '%' 
			)
		 WHERE 
				(emp_no = 1
				and edoc_end != 'y')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st != 'y'
				and flow_NM = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st = 'y'
				and edoc_end != 'y'
				and flow_NM = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_NM = '참조') 
		order by edoc_dt desc;
        
        
select A."EDOC_ID",A."SECU_CD",A."PRSV_CD",A."EMP_NO",A."EMP_MOD_NO",A."EDOC_TITLE",A."EDOC_VER",A."EDOC_ORG_ID",A."EDOC_DT",A."EDOC_END",A."EDOC_END_DT",A."TYPE_CD", t.form_nm, p.prsv_amt, s.secu_nm, U.emp_name, F.flow_cd, F.emp_no flow_emp_no, F.flow_ord, F.flow_st
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
left join flow_exe_tb F on A.edoc_id = F.edoc_id
join flow_cd_tb C on F.flow_cd = C.flow_cd
where A.edoc_org_id is null;




-- myList 페이지 쿼리문 논리
select *
from
(select
			*
		from
			
 (select
				*
			from
				edoc_all_tb
			 WHERE edoc_title like '%' ||  NULL || '%'
					or
					emp_name like '%' ||  NULL || '%'
					or
					form_nm like '%' ||  NULL || '%'
					or
					edoc_id like '%' ||  NULL || '%' 
			)
		 WHERE 
				(emp_no = 1
				and edoc_end is NULL)
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st is NULL
				and flow_nm = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_st = 'y'
				and edoc_end = 'y'
				and flow_nm = '결재')
			
			
				or
				(flow_emp_no = 1
				and flow_ord != 1
				and flow_nm = '참조') 
);


-- 
			insert
				into
					edoc_tb
				values
					('E200410-11', 'S3','P4', 1, NULL, 'asfadf', 0, NULL, sysdate, NULL, NULL);
                    commit;
			insert
				into
					leave_ltt_tb
				values 
					('E200410-11', 'P4', to_date('2020-04-01', 'YYYY-MM-DD HH24:MI:SS'), to_date('2020-04-03', 'YYYY-MM-DD HH24:MI:SS'), 2, 'asd', '2', 'F1', 0 );
                    
insert into
			edoc_att_tb
		values
			(seq_attach_id.NEXTVAL, 'E200410-14', 'KakaoTalk_20200301_140136786.jpg', '20200409_171238653_830.jpg', sysdate, NULL, NULL);
            
            
-- attachId 입력하여 edocAtt 객체 가져오기

select * from edoc_att_tb where attach_id = 1;
select * from edoc_tb join leave_ltt_tb using(edoc_id);


-- 
select * from leave_ltt_view;
select * from edoc_tb;
select * from flow_exe_tb where edoc_id = 'E200412-1' order by flow_ord desc;
select * from leave_ltt_tb;
select edoc_id, flow_cd, emp_no flow_emp_no, emp_name flow_nm, flow_ord, flow_st, flow_cmt, flow_dt from flow_exe_tb join emp_tb using(emp_no) where edoc_id = 'E200405-1' order by flow_ord desc;
select * from edoc_att_tb;
delete from edoc_att_tb where edoc_pdf_st = 'Y';
select * from emp_tb;
commit;


select * from edoc_tb join leave_ltt_tb using(edoc_id) join SEC_LV_TB using(secu_cd) join PRESERV_tb using(prsv_cd);

select A."EDOC_ID",A."EMP_NO",A."EMP_NAME",A."EMP_MOD_NO",A."EDOC_TITLE",A."EDOC_VER",A."EDOC_ORG_ID",A."EDOC_DT",A."EDOC_END",A."EDOC_END_DT",A."VCTN_CD", A."VCTN_NM",A."START_DT",A."END_DT",A."LEAVE_AMT",A."LEAVE_PURPOSE",A."LEAVE_CONTACT",A."TYPE_CD",A."SUR_EMP_NO",A."SECU_CD",A."PRSV_CD", E.emp_name sur_emp_name from
(select "EDOC_ID","EMP_NO", "EMP_NAME","EMP_MOD_NO","EDOC_TITLE","EDOC_VER","EDOC_ORG_ID","EDOC_DT","EDOC_END","EDOC_END_DT","VCTN_CD", "VCTN_NM","START_DT","END_DT","LEAVE_AMT","LEAVE_PURPOSE","LEAVE_CONTACT","TYPE_CD","SUR_EMP_NO" sur_emp_no,"SECU_NM" SECU_CD,"PRSV_AMT" PRSV_CD from edoc_tb join leave_ltt_tb using(edoc_id) join SEC_LV_TB using(secu_cd) join PRESERV_tb using(prsv_cd) join emp_tb using(emp_no) join vctn_type_tb using(vctn_cd)) A join emp_tb E on sur_emp_no = E.emp_no;

--

select * from edoc_flow_ex_view where edoc_id = 'E200412-4';

select * from flow_exe_tb;


select * from edoc_all_tb;
where 
    flow_emp_no = 1
--	and flow_ord != 1
    and flow_st is
    NULL
    and flow_nm = '결재';
    
    
(select*from ch_info_tb I left join
(select ch_no,msg_date,msg_content from ch_msg_tb where rowid in
(select max(rowid) from ch_msg_tb group by ch_no)) R
on I.ch_no = R.ch_no);
on M.ch_no = ch_no
where M.emp_no = 1;


--
select
		*
		from
		edoc_all_tb
		 WHERE (edoc_title like '%' || NULL || '%'
				or
				emp_name like
				'%' || NULL || '%'
				or
				form_nm like '%' || NULL || '%'
				or
				edoc_id like '%' || NULL || '%') 
		order by edoc_dt desc;

select A."EDOC_ID",A."SECU_CD",A."PRSV_CD",A."EMP_NO",A."EMP_MOD_NO",A."EDOC_TITLE",A."EDOC_VER",A."EDOC_ORG_ID",A."EDOC_DT",A."EDOC_END",A."EDOC_END_DT", A."TYPE_CD", t.form_nm, p.prsv_amt, s.secu_nm, U.emp_name
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
where A.edoc_org_id is null;

select * from emp_tb;
select * from edoc_tb;


--


select *
			from
			(
			 
			 
			select
				A.edoc_id, A.secu_cd, A.prsv_cd, A.emp_no, A.emp_mod_no, A.edoc_title, A.edoc_ver, A.edoc_org_id, A.edoc_dt, A.edoc_end, A.edoc_end_dt, A.type_cd, A.form_nm, A.prsv_amt, A.secu_nm, A.emp_name, A.flow_exe_no, A.flow_cd, A.flow_nm, A.flow_emp_no, A.flow_ord, A.flow_st
			from
				
 (select
					*
				from
					edoc_all_tb
 where (flow_st is null or flow_st = 'N')
 and flow_cd in ('F1','F2')) A
					join
					
 (select
						edoc_id, min(flow_ord) flow_ord
					from
					
 (select *
 from edoc_all_tb
					where
						(flow_st is null or flow_st = 'N')
 and flow_cd in ('F1','F2'))group by edoc_id) B
					 	on A.edoc_id = B.edoc_id
 and A.flow_ord = B.flow_ord
		 	where
		 		emp_no = 5			 
			 
			)
			 WHERE edoc_title like '%' || '' || '%'
					or
					emp_name like '%' || '' || '%'
					or
					form_nm like '%' || '' || '%'
					or
					edoc_id like '%' || '' || '%' 
			order by edoc_dt desc;
            
--
select A.edoc_id, A.secu_cd, A.prsv_cd, A.emp_no, A.emp_mod_no, A.edoc_title, A.edoc_ver, A.edoc_org_id, A.edoc_dt, A.edoc_end, A.edoc_end_dt, A.type_cd, A.form_nm, A.prsv_amt, A.secu_nm, A.emp_name, A.flow_exe_no, A.flow_cd, A.flow_nm, A.flow_emp_no, A.flow_ord, A.flow_st
from
    (select
            *
    from
        edoc_all_tb
    where (flow_st is null or flow_st = 'N')
        and flow_cd in ('F1','F2')) A
        join
    (select edoc_id, min(flow_ord) flow_ord
    from    (select *
            from edoc_all_tb
            where (flow_st is null or flow_st = 'N')
                and flow_cd in ('F1','F2')) group by edoc_id) B
                    on A.edoc_id = B.edoc_id
                and A.flow_ord = B.flow_ord
		 	where
		 		flow_emp_no = 5;

select *

from
(select
            *
    from
        edoc_all_tb
    where (flow_st is null or flow_st = 'N')
        and flow_cd in ('F1','F2')) A
        join
    (select edoc_id, min(flow_ord) flow_ord
    from    (select *
            from edoc_all_tb
            where (flow_st is null or flow_st = 'N')
                and flow_cd in ('F1','F2')) group by edoc_id) B
                on A.edoc_id = B.edoc_id
                and A.flow_ord = B.flow_ord
                ;

select
            *
    from
        edoc_all_tb
    where (flow_st is null or flow_st = 'N')
        and flow_cd in ('F1','F2');
        
select edoc_id, min(flow_ord) flow_ord
    from    (select *
            from edoc_all_tb
            where (flow_st is null or flow_st = 'N')
                and flow_cd in ('F1','F2')) group by edoc_id;
                
                
--
select *
			from
			(
			 
			select *
 from edoc_all_tb
			where 
				emp_no = 1
				and flow_ord = 1
				and flow_cd in ('F1', 'F2')
				and edoc_end is NULL
			 
			 
			 
			 
			 
			)
			 WHERE edoc_title like '%' || '' || '%'
					or
					emp_name like '%' || '' || '%'
					or
					form_nm like '%' || '' || '%'
					or
					edoc_id like '%' || '' || '%' 
			order by edoc_dt desc;
            
-- 결재 요청

select *
			from
			(
			 
			 
			select
				A.edoc_id, A.secu_cd, A.prsv_cd, A.emp_no, A.emp_mod_no, A.edoc_title, A.edoc_ver, A.edoc_org_id, A.edoc_dt, A.edoc_end, A.edoc_end_dt, A.type_cd, A.form_nm, A.prsv_amt, A.secu_nm, A.emp_name, A.flow_exe_no, A.flow_cd, A.flow_nm, A.flow_emp_no, A.flow_ord, A.flow_st
			from
				
 (select
					*
				from
					edoc_all_tb
 where (flow_st is null or flow_st = 'N')
 and flow_cd in ('F1','F2')) A
					join
					
 (select
						edoc_id, min(flow_ord) flow_ord
					from
					
 (select *
 from edoc_all_tb
					where
						(flow_st is null or flow_st = 'N')
 and flow_cd in ('F1','F2'))group by edoc_id) B
					 	on A.edoc_id = B.edoc_id
 and A.flow_ord = B.flow_ord
		 	where
		 		flow_emp_no = 1
			 
			 
			 
			 
			)
			 WHERE edoc_title like '%' || '' || '%'
					or
					emp_name like '%' || '' || '%'
					or
					form_nm like '%' || '' || '%'
					or
					edoc_id like '%' || '' || '%' 
			order by edoc_dt desc;

select rownum, A.* from
(select distinct edoc_id, emp_name, form_nm, edoc_title, edoc_end_dt from edoc_all_tb where edoc_end = 'Y' order by edoc_end_dt desc) A where rownum < 7;
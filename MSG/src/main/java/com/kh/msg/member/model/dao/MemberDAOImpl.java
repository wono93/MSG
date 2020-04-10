package com.kh.msg.member.model.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SimpleTimeZone;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.member.model.vo.*;

import lombok.extern.slf4j.Slf4j;


@Repository
@Slf4j
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public OrgChart selectOne(String userId) {
		
		return sqlSession.selectOne("member.logIn",userId);
	}

	@Override
	public List<HrMntList> selectList(HashMap<String, Object> map) {
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date today = null;
		Date vctnEndt = null;
		Date vctnStdt = null;
		log.debug("map = {}", map);
		List<HrMntList> hrmntlist = sqlSession.selectList("member.selectHrMngList",map);
		log.debug("HrMntList = {} ",hrmntlist);
		List<Vacation> vac = sqlSession.selectList("member.selectVacationCount",map);
		for(HrMntList hr : hrmntlist) {
			for(Vacation v : vac) {
				if(hr.getEmpNo() == v.getEmpNo()){
					try {
						today = fmt.parse(fmt.format(curDate));
						vctnEndt = fmt.parse(v.getVctnEndt());
						vctnStdt = fmt.parse(v.getVctnStdt());
						int compare = today.compareTo(vctnEndt);
						// 현재 기준, 휴가가 진행중인경우
						// 두날짜의 차이 구하기 
						// 현재날짜-휴가시작일
						if(compare < 0) {
									
							// 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
							long diff = today.getTime() - vctnStdt.getTime();
							long diffDays = diff / (24 * 60 * 60 * 1000);

							hr.setVctnCount(hr.getVctnCount()+(int)diffDays+1);

						}
						// 현재 기준, 이미 휴가가 종료된 경우
						// 두날짜의 차이 구하기 
						// 휴가종료일-휴가시작일
						else {
							long diff = vctnEndt.getTime() - vctnStdt.getTime();
							long diffDays = diff / (24 * 60 * 60 * 1000);

							hr.setVctnCount(hr.getVctnCount()+(int)diffDays+1);
						}
						
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		return hrmntlist;
	}

	@Override
	public List<com.kh.msg.member.model.vo.OrgChart> orgChart(Map<String, String> map) {
		
		return sqlSession.selectList("member.orgChart",map);
	}

	@Override
	public OrgChart empInfo(String empNo) {
		
		return sqlSession.selectOne("member.empInfo",empNo);
	}

	@Override
	public int updateEmp(Map<String, String> map) {
		return sqlSession.update("member.updateEmp",map);
	}

	@Override
	public void loginLog(int empNo) {
		//그 날의 첫번째 로그인 기록인지 검사
		//그 날의 첫번째 로그인 기록이 9시 혹은 임의출근시간이 넘으면 지각 처리하는 프로시져 호출
		sqlSession.insert("member.isLate",empNo);
		
		//로그에 로그인 기록
		sqlSession.insert("member.loginLog", empNo);
	}

	@Override
	public void logoutLog(int empNo) {
		//로그에 로그인 기록
		sqlSession.insert("member.logoutLog", empNo);
	}

	@Override
	public List<WorkTimes> getLog(HashMap<String, Object> map) {
		
		return sqlSession.selectList("member.selectEmpLog", map);
	}

	@Override
	public List<IOLog> ioLog(Map<String, String> map) {
		
		return sqlSession.selectList("member.selectIOLog",map);
	}

	@Override
	public List<Department> getDepts() {
		
		return sqlSession.selectList("member.getDepts");
	}

	@Override
	public List<Job> getJobs() {
		
		return sqlSession.selectList("member.getJobs");
	}

	@Override
	public int submitNewEmp(Member member) {
		
		return sqlSession.insert("member.submitNewEmp", member);
	}
}

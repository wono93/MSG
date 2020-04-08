package com.kh.msg.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.member.model.dao.MemberDAO;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.IOLog;
import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.member.model.vo.WorkTimes;
@Service("memberServiceImpl")
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public OrgChart selectOne(String userId) {
		
		return memberDAO.selectOne(userId);
	}

	@Override
	public List<HrMntList> selectList(HashMap<String, Object> map) {
		
		return memberDAO.selectList(map);
	}

	@Override
	public List<OrgChart> orgChart(Map<String, String> map) {
		
		return memberDAO.orgChart(map);
	}

	@Override
	public OrgChart empInfo(String empNo) {
		
		return memberDAO.empInfo(empNo);
	}

	@Override
	public int updateEmp(Map<String, String> map) {
		
		return memberDAO.updateEmp(map);
	}

	@Override
	public void loginLog(int empNo) {
		memberDAO.loginLog(empNo);
	}

	@Override
	public void logoutLog(int empNo) {
		memberDAO.logoutLog(empNo);
	}

	@Override
	public List<WorkTimes> getLog(HashMap<String, Object> map) {
		
		return memberDAO.getLog(map);
	}
}

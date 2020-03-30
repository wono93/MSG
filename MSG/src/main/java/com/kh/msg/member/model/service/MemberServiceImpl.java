package com.kh.msg.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.member.model.dao.MemberDAO;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.orgChart;
@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public orgChart selectOne(String userId) {
		
		return memberDAO.selectOne(userId);
	}

	@Override
	public List<HrMntList> selectList(Map<String, String> map) {
		
		return memberDAO.selectList(map);
	}

	@Override
	public List<orgChart> orgChart(Map<String, String> map) {
		
		return memberDAO.orgChart(map);
	}

	@Override
	public orgChart empInfo(String empNo) {
		
		return memberDAO.empInfo(empNo);
	}

	@Override
	public int updateEmp(Map<String, String> map) {
		
		return memberDAO.updateEmp(map);
	}
}

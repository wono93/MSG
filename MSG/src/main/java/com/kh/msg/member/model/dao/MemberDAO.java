package com.kh.msg.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.orgChart;

public interface MemberDAO {

	Member selectOne(String userId);

	List<HrMntList> selectList(Map<String, String> map);

	List<orgChart> orgChart(Map<String, String> map);

	orgChart empInfo(String empNo);

	int updateEmp(Map<String, String> map);
	
}

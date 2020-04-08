package com.kh.msg.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.IOLog;
import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.member.model.vo.WorkTimes;

public interface MemberDAO {

	OrgChart selectOne(String userId);

	List<HrMntList> selectList(HashMap<String, Object> map);

	List<OrgChart> orgChart(Map<String, String> map);

	OrgChart empInfo(String empNo);

	int updateEmp(Map<String, String> map);

	void loginLog(int empNo);

	void logoutLog(int empNo);

	List<WorkTimes> getLog(HashMap<String, Object> map);
	
}

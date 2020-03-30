package com.kh.msg.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.orgChart;

public interface MemberService {

	com.kh.msg.member.model.vo.orgChart selectOne(String userId);

	List<HrMntList> selectList(Map<String, String> map);

	List<orgChart> orgChart(Map<String, String> map);

	orgChart empInfo(String empNo);

	int updateEmp(Map<String, String> map);

}

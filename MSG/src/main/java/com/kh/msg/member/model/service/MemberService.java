package com.kh.msg.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.orgChart;

public interface MemberService {

	Member selectOne(String userId);

	List<HrMntList> selectList(Map<String, String> map);

	List<orgChart> orgChart(Map<String, String> map);

}

package com.kh.msg.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;

public interface MemberDAO {

	Member selectOne(String userId);

	List<HrMntList> selectList(Map<String, String> map);
	
}

package com.kh.msg.member.model.service;


import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;

public interface MemberService {

	Member selectOne(String userId);

	List<HrMntList> selectList(Map<String, String> map);

}

package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.chat.model.vo.DirectMsg;
import com.kh.msg.member.model.vo.Member;

public interface DirectMsgDAO {

	List<DirectMsg> directMsgList(Map<String, Object> param);

	List<DirectMsg> directMsgListByRecent(Map<String, Object> param);

	int insert(Map<String, Object> param);

	DirectMsg selectOne(String toId);

	List<DirectMsg> headerDmList(Map<String, Object> param);

	List<Member> userLogin();

	int readDm(Map<String, Object> param);

	int getAllUnreadDm(String fromId);

	int getUnreadDm(Map<String, Object> idMap);


}

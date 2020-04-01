package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.chat.model.vo.DirectMsg;

public interface DirectMsgDAO {

	List<DirectMsg> directMsgList(Map<String, Object> param);

	List<DirectMsg> directMsgListByRecent(Map<String, Object> param);

	int insert(Map<String, Object> param);

	DirectMsg selectOne(String toId);

	List<DirectMsg> headerDmList(String fromId);

}

package com.kh.msg.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.msg.chat.model.vo.DirectMsg;

public interface DirectMsgService {


	List<DirectMsg> directMsgList(Map<String, Object> param);

	List<DirectMsg> directMsgListByRecent(Map<String, Object> param);

	int insert(Map<String, Object> param);

	DirectMsg selectOne(String toId);

}

package com.kh.msg.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.chat.model.dao.DirectMsgDAO;
import com.kh.msg.chat.model.vo.DirectMsg;

@Service
public class DirectMsgServiceImpl implements DirectMsgService {

	@Autowired
	DirectMsgDAO directMsgDAO;

	@Override
	public List<DirectMsg> directMsgList(Map<String, Object> param) {
		return directMsgDAO.directMsgList(param);
	}

	@Override
	public List<DirectMsg> directMsgListByRecent(Map<String, Object> param) {
		return directMsgDAO.directMsgListByRecent(param);
	}

	@Override
	public int insert(Map<String, Object> param) {
		return directMsgDAO.insert(param);
	}

	@Override
	public DirectMsg selectOne(String toId) {
		return directMsgDAO.selectOne(toId);
	}

	@Override
	public List<DirectMsg> headerDmList(String fromId) {
		return directMsgDAO.headerDmList(fromId);
	}
	

}

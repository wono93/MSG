package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.chat.model.vo.DirectMsg;

@Repository
public class DirectMsgDAOImpl implements DirectMsgDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<DirectMsg> directMsgList(Map<String, Object> param) {
		return sqlSession.selectList("directMsg.directMsgList",param);
	}

	@Override
	public List<DirectMsg> directMsgListByRecent(Map<String, Object> param) {
		return sqlSession.selectList("directMsg.directMsgListByRecent",param);
	}

	@Override
	public int insert(Map<String, Object> param) {
		return sqlSession.insert("directMsg.insert",param);
	}

	@Override
	public DirectMsg selectOne(String toId) {
		return sqlSession.selectOne("directMsg.selectOne",toId);
	}

	@Override
	public List<DirectMsg> headerDmList(String fromId) {
		return sqlSession.selectList("directMsg.headerDmList",fromId);
	}
	
	
}

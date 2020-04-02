package com.kh.msg.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.chat.model.vo.ChannelInfo;

@Repository
public class ChannelDAOImpl implements ChannelDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ChannelInfo> headerChList(String fromId) {
		return sqlSession.selectList("ChannelInfo.headerChList",fromId);
	}

}

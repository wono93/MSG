package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMsg;

@Repository
public class ChannelDAOImpl implements ChannelDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ChannelInfo> headerChList(String fromId) {
		return sqlSession.selectList("Channel.headerChList",fromId);
	}

	@Override
	public List<ChannelMsg> channelListByNumber(Map<String, Object> param) {
		return sqlSession.selectList("Channel.channelListByNumber",param);
	}

	@Override
	public List<ChannelMsg> channelListByRecent(Map<String, Object> param) {
		return sqlSession.selectList("Channel.channelListByRecent",param);
	}

}

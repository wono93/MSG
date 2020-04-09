package com.kh.msg.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMember;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.OrgChart;

@Repository
public class ChannelDAOImpl implements ChannelDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Integer> chMemberList(String fromId) {
		return sqlSession.selectList("Channel.chMemberList",fromId);
	}

	@Override
	public List<ChannelMsg> channelListByNumber(Map<String, Object> param) {
		return sqlSession.selectList("Channel.channelListByNumber",param);
	}

	@Override
	public List<ChannelMsg> channelListByRecent(Map<String, Object> param) {
		return sqlSession.selectList("Channel.channelListByRecent",param);
	}

	@Override
	public List<ChannelMember> channelMember(String chNo) {
		return sqlSession.selectList("Channel.channelMember",chNo);
	}

	@Override
	public int insert(Map<String, Object> param) {
		return sqlSession.insert("Channel.insert",param);
	}

	@Override
	public List<OrgChart> searchListCh(Map<String, Object> param) {
		return sqlSession.selectList("Channel.searchListCh",param);
	}

	@Override
	public int generateChannel(ChannelInfo chInfo) {
		return sqlSession.insert("Channel.generateChannel",chInfo);
	}

	@Override
	public int addChannelMember(int empNo, int chNo) {
		Map<String,Integer> map = new HashMap<>();
		map.put("empNo", empNo);
		map.put("chNo", chNo);
		
		return sqlSession.insert("Channel.addChannelMember", map);
	}

	@Override
	public List<ChannelInfo> headerChList(List<Integer> chNoList) {
		return sqlSession.selectList("Channel.headerChList",chNoList);
		
	}


}

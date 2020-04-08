package com.kh.msg.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.chat.model.dao.ChannelDAO;
import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMember;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.OrgChart;;

@Service
public class ChannelServiceImpl implements ChannelService {

	@Autowired
	ChannelDAO channelDAO;
	
	@Override
	public List<ChannelInfo> headerChList(String fromId) {
		return channelDAO.headerChList(fromId);
	}

	@Override
	public List<ChannelMsg> channelListByNumber(Map<String, Object> param) {
		return channelDAO.channelListByNumber(param);
	}

	@Override
	public List<ChannelMsg> channelListByRecent(Map<String, Object> param) {
		return channelDAO.channelListByRecent(param);
	}

	@Override
	public List<ChannelMember> channelMember(String chNo) {
		return channelDAO.channelMember(chNo);
	}

	@Override
	public int insert(Map<String, Object> param) {
		return channelDAO.insert(param);
	}

	@Override
	public List<OrgChart> searchListCh(Map<String, Object> param) {
		return channelDAO.searchListCh(param);
	}

	@Override
	public int generateChannel(ChannelInfo chInfo) {
		return channelDAO.generateChannel(chInfo);
	}

	@Override
	public int addChannelMember(Map<String, Object> param) {
		return channelDAO.addChannelMember(param);
	}


}

package com.kh.msg.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.chat.model.dao.ChannelDAO;
import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMsg;;

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

}

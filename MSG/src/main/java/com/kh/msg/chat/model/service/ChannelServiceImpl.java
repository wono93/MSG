package com.kh.msg.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.chat.model.dao.ChannelDAO;
import com.kh.msg.chat.model.vo.ChannelInfo;

@Service
public class ChannelServiceImpl implements ChannelService {

	@Autowired
	ChannelDAO channelDAO;
	
	@Override
	public List<ChannelInfo> headerChList(String fromId) {
		return channelDAO.headerChList(fromId);
	}

}

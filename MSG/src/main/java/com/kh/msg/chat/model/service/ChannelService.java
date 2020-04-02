package com.kh.msg.chat.model.service;

import java.util.List;

import com.kh.msg.chat.model.vo.ChannelInfo;

public interface ChannelService {

	List<ChannelInfo> headerChList(String fromId);

}

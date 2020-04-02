package com.kh.msg.chat.model.dao;

import java.util.List;

import com.kh.msg.chat.model.vo.ChannelInfo;

public interface ChannelDAO {

	List<ChannelInfo> headerChList(String fromId);

}

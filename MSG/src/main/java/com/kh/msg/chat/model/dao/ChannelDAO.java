package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMsg;

public interface ChannelDAO {

	List<ChannelInfo> headerChList(String fromId);

	List<ChannelMsg> channelListByNumber(Map<String, Object> param);

	List<ChannelMsg> channelListByRecent(Map<String, Object> param);

}

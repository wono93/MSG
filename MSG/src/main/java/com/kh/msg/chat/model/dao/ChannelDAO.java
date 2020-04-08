package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMember;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.OrgChart;

public interface ChannelDAO {

	List<ChannelInfo> headerChList(String fromId);

	List<ChannelMsg> channelListByNumber(Map<String, Object> param);

	List<ChannelMsg> channelListByRecent(Map<String, Object> param);

	List<ChannelMember> channelMember(String chNo);

	int insert(Map<String, Object> param);

	List<OrgChart> searchListCh(Map<String, Object> param);

	int generateChannel(ChannelInfo chInfo);

	int addChannelMember(Map<String, Object> param);


}

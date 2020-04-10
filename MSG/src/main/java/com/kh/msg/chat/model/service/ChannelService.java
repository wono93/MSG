package com.kh.msg.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMember;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.OrgChart;

public interface ChannelService {

	List<Integer> chMemberList(String fromId);

	List<ChannelMsg> channelListByNumber(Map<String, Object> param);

	List<ChannelMsg> channelListByRecent(Map<String, Object> param);

	List<ChannelMember> channelMember(String chNo);

	int insert(Map<String, Object> param);

	List<OrgChart> searchListCh(Map<String, Object> param);

	int generateChannel(ChannelInfo chInfo);

	int addChannelMember(int[] empNo, int chNo, int regEmpNo);

	List<ChannelInfo> headerChList(List<Integer> chNoList);

	List<OrgChart> presentMember(int chNo);

	int deleteChannelMember(int chNo);
	
	int modifyChannel(ChannelInfo chInfo);


}

package com.kh.msg.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.board.model.vo.Board;
import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMember;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

public interface ChannelDAO {

	List<Integer> chMemberList(String fromId);

	List<ChannelMsg> channelListByNumber(Map<String, Object> param);

	List<ChannelMsg> channelListByRecent(Map<String, Object> param);

	List<ChannelMember> channelMember(String chNo);

	int insert(Map<String, Object> param);

	List<OrgChart> searchListCh(Map<String, Object> param);

	int generateChannel(ChannelInfo chInfo);

	int addChannelMember(int empNo, int chNo);

	List<ChannelInfo> headerChList(List<Integer> chNoList);

	List<OrgChart> presentMember(int chNo);

	int deleteChannelMember(int chNo);
	
	int modifyChannel(ChannelInfo chInfo);

	List<Board> mainBoardList();

	List<OrgChart> userLogin();

	


}

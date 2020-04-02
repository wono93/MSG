package com.kh.msg.leave.model.service;


import java.util.List;


import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeaveModal;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.member.model.vo.Member;

public interface LeaveService {

	 List<Leave> selectLeaveList();

	List<LeaveSet> selectLeaveList2();
	
	List<LeavePlus> selectLeaveList3();

	List<MyLeave> selectLeaveList4(Member member);

	List<LeaveInfoPlus> selectleaveListInfoPlus(Member member);

	List<LeaveModal> selectModalList(int empNo);


}

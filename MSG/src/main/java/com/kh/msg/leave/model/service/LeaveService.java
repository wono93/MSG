package com.kh.msg.leave.model.service;

import java.util.List;

import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;

public interface LeaveService {

	 List<Leave> selectLeaveList();

	List<LeaveSet> selectLeaveList2();
	
	List<LeavePlus> selectLeaveList3();

}

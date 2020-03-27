package com.kh.msg.leave.model.dao;

import java.util.List;

import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;

public interface LeaveDAO {

	List<Leave> selectLeaveList();

	List<LeaveSet> selectLeaveList2();

	List<LeavePlus> selectLeaveList3();

}

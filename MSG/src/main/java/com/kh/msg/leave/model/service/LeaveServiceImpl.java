package com.kh.msg.leave.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.leave.model.dao.LeaveDAO;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;


@Service
public class LeaveServiceImpl implements LeaveService {
     
	@Autowired
	LeaveDAO leaveDAO;
	
	@Override
	public List<Leave> selectLeaveList() {
		
		  return leaveDAO.selectLeaveList();
	}

	@Override
	public List<LeaveSet> selectLeaveList2() {
		
		return leaveDAO.selectLeaveList2();
	}

	@Override
	public List<LeavePlus> selectLeaveList3() {
		
		return leaveDAO.selectLeaveList3();
	}

}

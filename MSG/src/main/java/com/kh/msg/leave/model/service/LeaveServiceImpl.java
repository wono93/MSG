package com.kh.msg.leave.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.edoc.model.vo.Edoc;
import com.kh.msg.leave.model.dao.LeaveDAO;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeaveModal;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.LeaveSum;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.leave.model.vo.LeavePagingVO;
import com.kh.msg.member.model.vo.Member;

@Service
public class LeaveServiceImpl implements LeaveService {

	@Autowired
	LeaveDAO leaveDAO;

	@Override
	public List<LeaveSet> selectLeaveList2() {

		return leaveDAO.selectLeaveList2();
	}

	@Override
	public List<LeavePlus> selectLeaveList3() {

		return leaveDAO.selectLeaveList3();
	}

	@Override
	public List<MyLeave> selectLeaveList4(Member member) {

		return leaveDAO.selectLeaveList4(member);
	}

	@Override
	public List<LeaveInfoPlus> selectleaveListInfoPlus(Member member) {

		return leaveDAO.selectleaveListInfoPlus(member);
	}

	@Override
	public List<LeaveModal> selectModalList(int empNo) {

		return leaveDAO.selectModalList(empNo);
	}

	@Override
	public List<Edoc> selectModalSearch() {

		return leaveDAO.selectModalSearch();
	}

	@Override
	public int insertModal(int vctnNo, String edocId, String vctnCd, int vctnAmt, String vctnReason) {

		return leaveDAO.insertModal(vctnNo, edocId, vctnCd, vctnAmt, vctnReason);
	}

	// 게시글 카운트
	
	//휴가조정 내역 카운트
	@Override
	public int selectSetVacationTotalContents(Map<String, String> map) {
	
		return leaveDAO.selectSetVacationTotalContents(map);
	}

	//나의 휴가 내역 카운트
	@Override
	public int selectMyVacationTotalContents(Map<String, String> map) {
		
		return leaveDAO.selectMyVacationTotalContents(map);
	}
	//모든 휴가 내역 카운트
	@Override
	public int selectAllVacationTotalContents(Map<String, String> map) {

		return leaveDAO.selectAllVacationTotalContents(map);
	}


	// 페이지 리스트

	//휴가조정 내역 리스트

	@Override
	public List<LeaveSum> selectSetLeaveList(int cPage, int numPerPage, Map<String, String> map) {
		
		return leaveDAO.selectSetLeaveList(cPage, numPerPage, map);
	}

	
	//모든 휴가 내역 리스트
	@Override
	public List<Leave> selectLeaveList(int cPage, int numPerPage, Map<String, String> map) {

		return leaveDAO.selectLeaveList(cPage, numPerPage, map);
	}
	
	//나의 휴가 내역 리스트
	@Override
	public List<MyLeave> selectMyLeaveList( int cPage, int numPerPage, Map<String, String> map) {
	
		return leaveDAO.selectMyLeaveList( cPage, numPerPage, map);
	}

}

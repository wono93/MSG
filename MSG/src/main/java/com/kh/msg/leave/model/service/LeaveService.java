package com.kh.msg.leave.model.service;


import java.util.List;

import com.kh.msg.edoc.model.vo.Edoc;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeaveModal;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.leave.model.vo.leavePagingVo;
import com.kh.msg.member.model.vo.Member;

public interface LeaveService {

	 List<Leave> selectLeaveList();

	List<LeaveSet> selectLeaveList2();
	
	List<LeavePlus> selectLeaveList3();

	List<MyLeave> selectLeaveList4(Member member);

	List<LeaveInfoPlus> selectleaveListInfoPlus(Member member);

	List<LeaveModal> selectModalList(int empNo);

	List<Edoc> selectModalSearch();

	int insertModal(int vctnNo, String edocId, String vctnCd, int vctnAmt, String vctnReason);

	public int countBoard();

	// 페이징 처리 게시글 조회
	public List<LeaveModal> selectBoard(leavePagingVo vo);
	
}

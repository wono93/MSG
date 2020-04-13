package com.kh.msg.leave.model.service;


import java.util.List;
import java.util.Map;

import com.kh.msg.edoc.model.vo.Edoc;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveAnnual;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeaveModal;
import com.kh.msg.leave.model.vo.LeaveOther;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveReward;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.LeaveSum;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.member.model.vo.Member;

public interface LeaveService {

	List<LeaveSet> selectSettingLeaveList();
	
	List<LeavePlus> selectPlusLeaveList();

	/* List<MyLeave> selectLeaveList4(Member member); */

	List<LeaveInfoPlus> selectleaveListInfoPlus(Member member);

	List<LeaveModal> selectModalList(int empNo);

	List<Edoc> selectModalSearch();

	int insertModal(int empNo, String edocId, String vctnCd, int vctnAmt, String vctnReason);

	//게시글 카운트
	
	//휴가조정 카운트
	int selectSetVacationTotalContents(Map<String, String> map); 
    
    //모든 휴가내역 카운트
    int selectAllVacationTotalContents(Map<String, String> map);
    
    //나의휴가내역 카운트
	int selectMyVacationTotalContents(Map<String, String> map);	
	
	// 페이징 처리 게시글 조회
	
    //휴가조정내역
	
	  List<LeaveSum> selectSetLeaveList(int cPage, int numPerPage, Map<String,
	  String> map);
	 
	
	
	//전체휴가내역
	List<Leave> selectLeaveList(int cPage, int numPerPage, Map<String, String> map);
	
	//나의휴가내역
	List<MyLeave> selectMyLeaveList( int cPage, int numPerPage, Map<String, String> map);

	//사용한 휴가 
	List<LeaveAnnual> selectAnnualList();

	List<LeaveReward> selectRewardList();

	List<LeaveOther> selectOtherList();

	

	

	

}

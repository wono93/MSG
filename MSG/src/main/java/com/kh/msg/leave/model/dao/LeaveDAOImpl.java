package com.kh.msg.leave.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
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

@Repository
public class LeaveDAOImpl implements LeaveDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<LeaveSet> selectSettingLeaveList() {

		return sqlSession.selectList("leave.selectSettingLeaveList");
	}

	@Override
	public List<LeavePlus> selectPlusLeaveList() {

		return sqlSession.selectList("leave.selectPlusLeaveList");
	}

	/*
	 * @Override public List<MyLeave> selectLeaveList4(Member member) {
	 * 
	 * return sqlSession.selectList("leave.selectLeaveList4", member); }
	 */

	@Override
	public List<LeaveInfoPlus> selectleaveListInfoPlus(Member member) {

		return sqlSession.selectList("leave.selectleaveListInfoPlus", member);
	}

	@Override
	public List<LeaveModal> selectModalList(int empNo) {

		return sqlSession.selectList("leave.selectModalList", empNo);
	}

	@Override
	public List<Edoc> selectModalSearch() {

		return sqlSession.selectList("leave.selectModalSearch");
	}

	@Override
	public int insertModal(int empNo, String edocId, String vctnCd, int vctnAmt, String vctnReason) {

		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo", empNo + "");
		map.put("edocId", edocId);
		map.put("vctnCd", vctnCd);
		map.put("vctnAmt", vctnAmt + "");
		map.put("vctnReason", vctnReason);

		return sqlSession.insert("leave.insertModal", map);
	}

	// 게시글 카운트

	// 휴가조정내역 카운트
	@Override
	public int selectSetVacationTotalContents(Map<String, String> map) {

		return sqlSession.selectOne("leave.selectSetVacationTotalContents", map);
	}

	// 모든휴가내역 카운트
	@Override
	public int selectAllVacationTotalContents(Map<String, String> map) {

		return sqlSession.selectOne("leave.selectAllVacationTotalContents", map);
	}

	// 나의휴가내역 카운트
	@Override
	public int selectMyVacationTotalContents(Map<String, String> map) {

		return sqlSession.selectOne("leave.selectMyVacationTotalContents", map);
	}

	// 페이징바,검색

	// 휴가조정내역 리스트

	@Override
	public List<LeaveSum> selectSetLeaveList(int cPage, int numPerPage, Map<String, String> map) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);

		return sqlSession.selectList("leave.selectSetLeaveList", map, rowBounds);
	}

	// 모든휴가내역 리스트
	@Override
	public List<Leave> selectLeaveList(int cPage, int numPerPage, Map<String, String> map) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);

		return sqlSession.selectList("leave.selectLeaveList", map, rowBounds);
	}

	// 나의 휴가내역 리스트
	@Override
	public List<MyLeave> selectMyLeaveList(int cPage, int numPerPage, Map<String, String> map) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);

		return sqlSession.selectList("leave.selectMyLeaveList", map, rowBounds);
	}
	
	//휴가 사용 내역
	@Override
	public List<LeaveOther> selectOtherList() {
		
		return sqlSession.selectList("leave.selectOtherList");
	}

	@Override
	public List<LeaveReward> selectRewardList() {
	
		return sqlSession.selectList("leave.selectRewardList");
	}

	@Override
	public List<LeaveAnnual> selectAnnualList() {
		
		return sqlSession.selectList("leave.selectAnnualList");
	}

}

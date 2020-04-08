package com.kh.msg.leave.model.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.leave.model.vo.leavePagingVo;
import com.kh.msg.edoc.model.vo.Edoc;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeaveModal;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.member.model.vo.Member;

@Repository
public class LeaveDAOImpl implements LeaveDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	
	@Override
	public List<Leave> selectLeaveList() {
		
		return sqlSession.selectList("leave.selectLeaveList");
	
	}


	@Override
	public List<LeaveSet> selectLeaveList2() {
	
		return sqlSession.selectList("leave.selectLeaveList2");
	}


	@Override
	public List<LeavePlus> selectLeaveList3() {
	
		return sqlSession.selectList("leave.selectLeaveList3");
	}

	@Override
	public List<MyLeave> selectLeaveList4(Member member) {
		
		return sqlSession.selectList("leave.selectLeaveList4", member);
	}


	@Override
	public List<LeaveInfoPlus> selectleaveListInfoPlus(Member member) {
		
		return sqlSession.selectList("leave.selectleaveListInfoPlus",member);
	}


	@Override
	public List<LeaveModal> selectModalList(int empNo) {
		
		return sqlSession.selectList("leave.selectModalList",empNo);
	}


	@Override
	public List<Edoc> selectModalSearch() {
		
		return sqlSession.selectList("leave.selectModalSearch");
	}

	@Override
	public int insertModal(int vctnNo, String edocId, String vctnCd, int vctnAmt, String vctnReason) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("vctnNo", vctnNo+"");
		map.put("edocId", edocId);
		map.put("vctnCd", vctnCd);
		map.put("vctnAmt",vctnAmt+"");
		map.put("vctnReason", vctnReason);
		
		return  sqlSession.insert("leave.insertModal", map);
	}


	@Override
	public int countBoard() {
		
		return sqlSession.selectOne("leave.countBoard");
	}

	@Override
	public List<LeaveModal> selectBoard(leavePagingVo vo) {
		Map<String, String> map = new HashMap<String, String>();
		return sqlSession.selectList("leave.selectBoard", vo);
	}


	
}

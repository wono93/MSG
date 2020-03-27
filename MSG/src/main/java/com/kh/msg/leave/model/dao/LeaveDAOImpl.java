package com.kh.msg.leave.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;

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
	
}

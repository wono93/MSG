package com.kh.msg.sched.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.sched.model.vo.Schedule;

@Repository
public class ScheDAOImpl implements ScheDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Schedule> schedList() {
		return sqlSession.selectList("schedule.schedList");
	}
	
	@Override
	public int insert(Schedule s) {
//		return sqlSession.insert("schedule.insert", s);
		return 0;
	}

}

package com.kh.msg.sched.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.sched.model.vo.SchedEmp;
import com.kh.msg.sched.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ScheDAOImpl implements ScheDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	 
	@Override
	public List<Schedule> schedList(String dept_name, List<String> empList, List<String> typeList) {
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		
		List<String> deptName = new ArrayList<String>();
		deptName.add(dept_name);
		
		map.put("deptName", deptName);
		map.put("empList", empList);
		map.put("typeList", typeList);
		//log.debug("map_={}",map);
		return sqlSession.selectList("sched.schedList",map);
	}
	
	@Override
	public List<SchedEmp> deptEmpList(int empNo) {
		return sqlSession.selectList("sched.deptEmpList", empNo);
	}
	
	@Override
	public int insertSched(Schedule s) {
		return sqlSession.insert("sched.insertSched",s);
	}

	@Override
	public int updateSched(int scheCode, Schedule s) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("scheCode", scheCode+"");
		map.put("scheCate", s.getScheCate());
		map.put("empNo", s.getEmpNo()+"");
		map.put("empName", s.getEmpName()+"");
		map.put("deptName", s.getDeptName());
		map.put("jobName", s.getJobName());
		map.put("scheName", s.getScheName());
		map.put("scheStart", s.getScheStart());
		map.put("scheEnd", s.getScheEnd());
		map.put("scheColor",s.getScheColor());
		map.put("schEx", s.getScheEx());
		return sqlSession.update("sched.updateSched", map);
	}

	@Override
	public int deleteSched(int scheCode) {
		return sqlSession.delete("sched.deleteSched", scheCode);
	}

	@Override
	public Schedule selectSched(int scheCode) {
		return sqlSession.selectOne("sched.selectSched", scheCode);
	}

	@Override
	public int resizeSched(String resizeStart, String resizeEnd, int scheCode) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("resizeStart", resizeStart);
		map.put("resizeEnd", resizeEnd);
		map.put("scheCode",scheCode+"");
		return sqlSession.update("sched.resizeSched", map);
	}

	@Override
	public List<Schedule> mainSchedList(int empNo, String deptName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo",empNo+"");
		map.put("deptName", deptName);
		return sqlSession.selectList("mainSchedList", map);
	}


}

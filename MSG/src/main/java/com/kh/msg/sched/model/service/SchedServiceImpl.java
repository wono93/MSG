package com.kh.msg.sched.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.sched.model.dao.ScheDAO;
import com.kh.msg.sched.model.vo.SchedEmp;
import com.kh.msg.sched.model.vo.Schedule;

@Service
public class SchedServiceImpl implements SchedService {

	@Autowired
	ScheDAO scheDAO;
	
	@Override
	public List<Schedule> schedList(String deptName, List<String> empList, List<String> typeList) {
		return scheDAO.schedList(deptName, empList, typeList);
	}
	
	@Override
	public List<SchedEmp> deptEmpList(int empNo) {
		return scheDAO.deptEmpList(empNo);
	}
	
	@Override
	public int insertSched(Schedule s) {
		return scheDAO.insertSched(s);
	}

	@Override
	public int updateSched(int scheCode, Schedule s) {
		return scheDAO.updateSched(scheCode, s);
		
	}

	@Override
	public int deleteSched(int scheCode) {
		return scheDAO.deleteSched(scheCode);
	}

	@Override
	public Schedule selectSched(int scheCode) {
		return scheDAO.selectSched(scheCode);
	}

	@Override
	public int resizeSched(String resizeStart, String resizeEnd, int scheCode) {
		return scheDAO.resizeSched(resizeStart, resizeEnd, scheCode);
		
	}


}

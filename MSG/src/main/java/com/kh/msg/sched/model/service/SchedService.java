package com.kh.msg.sched.model.service;

import java.util.List;

import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.sched.model.vo.SchedEmp;
import com.kh.msg.sched.model.vo.Schedule;

public interface SchedService {

	List<Schedule> schedList(String deptName, List<String> empFilter, List<String> typeFilter);

	List<SchedEmp> deptEmpList(int empNo);
		
	int insertSched(Schedule s);

	int updateSched(int scheCode, Schedule s);

	int deleteSched(int scheCode);

	Schedule selectSched(int scheCode);

	int resizeSched(String resizeStart, String resizeEnd, int scheCode);

	List<Schedule> mainSchedList(int empNo, String deptName);


}

package com.kh.msg.sched.model.dao;

import java.util.List;

import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.sched.model.vo.SchedEmp;
import com.kh.msg.sched.model.vo.Schedule;

public interface ScheDAO {

	List<Schedule> schedList(List<String> empList, List<String> typeList);

	List<SchedEmp> deptEmpList(int empNo);
	
	int insertSched(Schedule s);

	int updateSched(int scheCode, Schedule s);

	int deleteSched(int scheCode);

	Schedule selectSched(int scheCode);

	int resizeSched(String resizeStart, String resizeEnd, int scheCode);


}

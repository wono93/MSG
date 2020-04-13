package com.kh.msg.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.kh.msg.board.model.vo.Board;
import com.kh.msg.member.model.vo.Department;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.IOLog;
import com.kh.msg.member.model.vo.Job;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.member.model.vo.WorkTimes;


public interface MemberService {

	com.kh.msg.member.model.vo.OrgChart selectOne(String userId);

	List<HrMntList> selectList(HashMap<String, Object> map);

	List<OrgChart> orgChart(Map<String, String> map);

	OrgChart empInfo(String empNo);

	int updateEmp(Map<String, String> map);

	void loginLog(int empNo);

	void logoutLog(int empNo);

	List<WorkTimes> getLog(HashMap<String, Object> map);

	List<IOLog> ioLog(Map<String, String> map);

	List<Department> getDepts();

	List<Job> getJobs();

	int submitNewEmp(Member member);

	List<Board> mainBoardList(Member member);

}
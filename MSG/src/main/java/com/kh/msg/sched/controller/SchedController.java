package com.kh.msg.sched.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonView;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.sched.model.service.SchedService;
import com.kh.msg.sched.model.vo.SchedEmp;
import com.kh.msg.sched.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@Slf4j
@RequestMapping("/sched")
public class SchedController {
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	
	@Autowired
	SchedService schedService;
	
	@GetMapping("/calcover.do")
	public ModelAndView schedList_() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("sched/calcover");
		return mav;
	}
	
	@ResponseBody
	@GetMapping("/calendar.do")
	//public ModelAndView cal() {
	public ModelAndView schedList(HttpSession session,
//								  @RequestParam(value="deptName") String deptName,
						          @RequestParam(value="empFilter", required=false) List<String> empFilter,
						          @RequestParam(value="typeFilter", required=false) List<String> typeFilter) throws IOException {
//	public List<Schedule> cal(HttpServletResponse response) throws IOException {
		OrgChart o = (OrgChart)session.getAttribute("memberLoggedIn");
		ModelAndView mav = new ModelAndView();
		
		log.debug("typeFilter={}",typeFilter);
		log.debug("empFilter={}",empFilter);

		List<Schedule> list = schedService.schedList(o.getDeptName(), empFilter, typeFilter);
//		List<Schedule> list = schedService.schedList(deptName, empFilter, typeFilter);
		
//		log.debug("o0o={}",o);
		mav.addObject("list", list); //예약된 일정목록
		
		
//		mav.setViewName("sched/calendar");
		mav.setViewName("jsonView");
		
		

//		return list;
		return mav;
	}
	
	
	
	@GetMapping("cal.do")
	public ModelAndView deptEmpList(HttpSession session){
		ModelAndView mav = new ModelAndView();
		
		Member m = (Member)session.getAttribute("memberLoggedIn");
		
		//로그인한 사용자와 같은 부서의 사원번호, 주민번호, 부서명, 직급명, 사원이름
		List<SchedEmp> eList = schedService.deptEmpList(m.getEmpNo());
		mav.addObject("eList", eList);
		
		mav.setViewName("sched/calendar");
		return mav;
	}
	
//	public ModelAndView insertSched(@RequestParam(value="scheCate") String scheCate,
//									@RequestParam(value="empNo") int empNo,
//									@RequestParam(value="empName") String empName,
//									@RequestParam(value="deptName") String deptName,
//									@RequestParam(value="jobName") String jobName,
//									@RequestParam(value="scheName") String scheName,
//								   @RequestParam(value="scheStart") String scheStart,
//								   @RequestParam(value="scheEnd") String scheEnd,
//								   @RequestParam(value="scheColor") String scheColor,
//								   @RequestParam(value="scheEx") String scheEx,
//								   @RequestParam(value="alldayYn") boolean allday) {
	@ResponseBody
	@PostMapping("/insertSched")
	public ModelAndView insertSched(HttpSession session,
	   @RequestParam(value="scheName") String scheName,
	   @RequestParam(value="scheStart") String scheStart,
	   @RequestParam(value="scheEnd") String scheEnd,
	   @RequestParam(value="scheCate") String scheCate,
	   @RequestParam(value="scheColor") String scheColor,
	   @RequestParam(value="scheEx") String scheEx,
	   @RequestParam(value="alldayYn") boolean allday) {
//	public ModelAndView insertSched(Schedule s) {
		
		ModelAndView mav = new ModelAndView();
		
		OrgChart o = (OrgChart)session.getAttribute("memberLoggedIn");
		
		char alldayYn = yOrN(allday);
		
		Schedule s = new Schedule(0, scheCate, o.getEmpNo(), o.getEmpName(), o.getDeptName(), o.getJobName(),scheName, scheStart,scheEnd, scheColor, scheEx, alldayYn);
//		Schedule s = new Schedule(0, scheCate, empNo, empName, deptName, jobName,scheName, scheStart,scheEnd, scheColor, scheEx, alldayYn);
		log.debug("sched_"+s);
		//scheCode, scheCate, empNo, empName, deptName, jobName, scheName, scheStart, scheEnd, scheColor, scheEx, alldayYn
		
//		int result = schedService.insertSched(s);
		schedService.insertSched(s);
				
		mav.setViewName("redirect:calendar");
		return mav;
	}
	@ResponseBody
	@PostMapping("/updateSched")
	public ModelAndView updateSched( HttpSession session,
									 @RequestParam(value="scheCode")int scheCode,
//									 @RequestParam Schedule s) {
									 
									 @RequestParam(value="scheCate") String scheCate,
//									 @RequestParam(value="empNo") int empNo,
//									 @RequestParam(value="empName") String empName,
//									 @RequestParam(value="deptName") String deptName,
//									 @RequestParam(value="jobName") String jobName,
								     @RequestParam(value="scheName") String scheName,
								     @RequestParam(value="scheStart") String scheStart,
								     @RequestParam(value="scheEnd") String scheEnd,
								     @RequestParam(value="scheColor") String scheColor,
								     @RequestParam(value="scheEx") String scheEx,
								     @RequestParam(value="alldayYn") boolean allday) {
		ModelAndView mav = new ModelAndView();
		OrgChart o = (OrgChart)session.getAttribute("memberLoggedIn");
		
		char alldayYn = yOrN(allday);
		
		Schedule s = new Schedule(scheCode, scheCate, o.getEmpNo(), o.getEmpName(), o.getDeptName(), o.getJobName(), scheName, scheStart, scheEnd, scheColor, scheEx, alldayYn);
//		log.debug("schedule_={}",s);
		
		schedService.updateSched(scheCode, s);
		
		mav.setViewName("redirect:calendar");
		
		return mav;
	}
	
	@DeleteMapping("deleteSched/{scheCode}")
	public void deleteSched( @PathVariable(value="scheCode") int scheCode) {
		
		schedService.deleteSched(scheCode);

	}
	@ResponseBody
	@GetMapping(value="/selectSched/{scheCode}")
	public Schedule selectSched(@PathVariable("scheCode") int scheCode) {
		
		Schedule s = schedService.selectSched(scheCode);
		return s;
	}
	
	@ResponseBody
	@PostMapping(value="/resizeSched")
	public ModelAndView resizeSched(@RequestParam("resizeStart") String resizeStart,
								    @RequestParam("resizeEnd") String resizeEnd,
								    @RequestParam("scheCode") int scheCode) {
		
	ModelAndView mav = new ModelAndView();
	
	log.debug("resizeStart={}",resizeStart+" resizeEnd={}", resizeEnd);
	
	schedService.resizeSched(resizeStart, resizeEnd, scheCode);
	
	mav.setViewName("redirect:calendar");
	return mav;
	}
	
	@ResponseBody
	@GetMapping(value="/mainSchedList")
	public ModelAndView mainSchedList(@RequestParam("empNo") int empNo,
									  @RequestParam("deptName") String deptName) {
		ModelAndView mav = new ModelAndView();
		//log.debug("o0o={}",empNo+" "+deptName);
		
		List<Schedule> list = schedService.mainSchedList(empNo,deptName);
		for(Schedule s : list) {
		}
		//log.debug("o0o={}",list);
		mav.addObject(list);
		return mav;
	}
	
	public char yOrN(boolean allday) {
		if(allday == true) return 'Y';
		else return 'N';
	}
		
	
}

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.sched.model.service.SchedService;
import com.kh.msg.sched.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oracle.net.aso.r;

@Controller
@Slf4j
@RequestMapping("/sched")
public class SchedController {
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	
	@Autowired
	SchedService schedService;
	
	@ResponseBody
	@GetMapping("/calendar.do")
	//public ModelAndView cal() {
	public List<Schedule> cal(HttpServletResponse response) throws IOException {

		List<Schedule> list = schedService.schedList();
//		mav.addObject("list", list); //key, value
//		
//		mav.setViewName("sched/calendar");
		

		return list;
	}
	@GetMapping("cal.do")
	public String cas(){
		return "sched/calendar";
	}
		
	@PostMapping("/insertSched")
	public ModelAndView insertSched(HttpSession session,
								   @RequestParam(value="scheName") String scheName,
								   @RequestParam(value="scheStart") String scheStart,
								   @RequestParam(value="scheEnd") String scheEnd,
								   @RequestParam(value="scheCate") String scheCate,
								   @RequestParam(value="scheColor") String scheColor,
								   @RequestParam(value="scheEx") String scheEx,
								   @RequestParam(value="alldayYn") boolean allday) {
		
		ModelAndView mav = new ModelAndView();
		
		OrgChart o = (OrgChart)session.getAttribute("memberLoggedIn");
		
		char alldayYn = ' ';
		if(allday == true) {
			alldayYn = 'Y';
		}
		else alldayYn = 'N';
		
		Schedule s = new Schedule(0, scheCate, o.getEmpNo(), o.getEmpName(), o.getDeptName(), o.getJobName(),scheName, scheStart,scheEnd, scheColor, scheEx, alldayYn);
		//scheCode, scheCate, empNo, empName, deptName, jobName, scheName, scheStart, scheEnd, scheColor, scheEx, alldayYn
		
		int result = schedService.insertSched(s);
				
		mav.setViewName("redirect:calendar");
		return mav;
	}
}

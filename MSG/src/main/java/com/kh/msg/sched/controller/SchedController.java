package com.kh.msg.sched.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.sched.controller.SchedController;
import com.kh.msg.sched.model.service.SchedService;
import com.kh.msg.sched.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/sched")
public class SchedController {
	
	@Autowired
	SchedService schedService;

	@GetMapping("/cal.do")
	public ModelAndView cal(ModelAndView mav) {
		
		log.debug("schedService={}", schedService.getClass());
		
		List<Schedule> list = schedService.schedList();
		mav.addObject("list", list); //key, value
		
		mav.setViewName("sched/calendar");
		return mav;
	}
	
		
	@PostMapping("/insert.do")
	public ModelAndView insert(Schedule s, ModelAndView mav) {
		int result = schedService.insert(s);
				
		mav.setViewName("redirect:cal.do");
		return mav;
	}
}

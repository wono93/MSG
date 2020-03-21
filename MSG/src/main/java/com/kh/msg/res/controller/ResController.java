package com.kh.msg.res.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh.msg.res.service.ResService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/res")
public class ResController {

	@GetMapping("/cal.do")
	public String cal() {
		return "res/calendar";
	}
	@GetMapping("/carRes.do")
	public String carRes() {
		return "res/carReservation";
	}
	@GetMapping("/confRes.do")
	public String confRes() {
		return "res/confroomReservation";
	}
	@GetMapping("/view.do")
	public String view() {
		return "res/resView";
	}
}

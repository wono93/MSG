package com.kh.msg.leave.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/leave")
public class LeaveController {


	@GetMapping("/list.do")
	public String list() {
		return "leave/allvacation";
	}
	@GetMapping("/select.do")
	public String select() {
		return "leave/myvacation";
	}
	@GetMapping("/update.do")
	public String update() {
		return "leave/vacation";
	}
}

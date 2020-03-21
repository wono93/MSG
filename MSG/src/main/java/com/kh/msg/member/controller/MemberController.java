package com.kh.msg.member.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh.msg.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@GetMapping("/list.do")
	public String logBoard() {
		return "member/empLogBoard";
	}
	@GetMapping("/select.do")
	public String log() {
		return "member/empLog";
	}
	@GetMapping("/io.do")
	public String io() {
		return "member/IOlog";
	}
	@GetMapping("/org.do")
	public String org() {
		return "member/org_chart";
	}
	@GetMapping("/insert.do")
	public String info() {
		return "member/addEmpForm";
	}
}

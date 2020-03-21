package com.kh.msg.edoc.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
@RequestMapping("/edoc")
public class EdocController {

	@GetMapping("/list.do")
	public String list() {
		return "edoc/edocList";
	}
	@GetMapping("/srch.do")
	public String srch() {
		return "edoc/edocSrch";
	}
	@GetMapping("/confirm.do")
	public String confirm() {
		return "edoc/edocConfirm";
	}
	@GetMapping("/read.do")
	public String read() {
		return "edoc/edocRead";
	}
	@GetMapping("/write.do")
	public String write() {
		return "edoc/edocWrite";
	}

}

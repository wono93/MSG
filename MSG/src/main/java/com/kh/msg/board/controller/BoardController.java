package com.kh.msg.board.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@GetMapping("/list.do")
	public String list() {
		return "board/boardList";
	}
	@GetMapping("/view.do")
	public String view() {
		return "board/boardView";
	}
	@GetMapping("/write.do")
	public String write() {
		return "board/boardWrite";
	}
	
}

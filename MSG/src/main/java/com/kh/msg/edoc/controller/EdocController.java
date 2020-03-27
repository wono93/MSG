package com.kh.msg.edoc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.msg.edoc.model.service.EdocService;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@Slf4j
@RequestMapping("/edoc")
public class EdocController {

	@Autowired
	EdocService edocService;

	@GetMapping("/list.do")
	public String list() {
		return "edoc/edocList";
	}

	@GetMapping("/srch.do")
	public String srch() {
		return "edoc/edocSrch";
	}
	@PostMapping("/srch.do")
	public void srchList() {
		
		
		
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

	@GetMapping("/treetest.do")
	public String treetest() {
		return "edoc/treeTest";
	}

	@GetMapping("/jstree.do")
	public void jstree(HttpServletResponse response) {

		try {
			List<Jstree> list = edocService.selectJstree();
			log.debug("list@EdocController"+list.toString());
			
			JSONArray jsonArr = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject sObject = new JSONObject(); 
				sObject.put("id", list.get(i).getId());
				if((list.get(i).getParent())==null) {
					sObject.put("parent", "#");
				} else {
					sObject.put("parent", list.get(i).getParent());
				}
				sObject.put("text", list.get(i).getText());
				sObject.put("icon", list.get(i).getIcon());
				jsonArr.add(sObject);
			}
			
			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(jsonArr.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	@GetMapping("/jstreeMem.do")
	public void jstreeMem(HttpServletRequest request, HttpServletResponse response) {

		try {
			log.debug("name Parameter@EdocController.jstreeMem:"+request.getParameter("name"));
			JstreeMem memOne = edocService.selectJstreeMem(request.getParameter("name"));
			log.debug("memOne@EdocController"+memOne.toString());
			
			JSONObject sObject = new JSONObject(); 
			sObject.put("dept", memOne.getDept());
			sObject.put("name", memOne.getName());
			
			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(sObject.toString());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}

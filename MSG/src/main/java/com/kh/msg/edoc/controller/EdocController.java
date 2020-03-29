package com.kh.msg.edoc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.edoc.model.service.EdocService;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;

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
	public String list(@RequestParam(value="cPage", defaultValue="1") int cPage, String srchWord, String srchType, @RequestParam(value="arrayDocuCheck", defaultValue="{myDocu, reqDocu, compDocu, refDocu}")String[] arrayDocuCheck, Member member) {
		log.debug("=========내 전자문서 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;
		
		String myDocu = "y"; 
		String reqDocu = "y"; 
		String compDocu = "y"; 
		String refDocu = "y";
		
		if(!Arrays.stream(arrayDocuCheck).anyMatch("myDocu"::equals)) myDocu="n";
		if(!Arrays.stream(arrayDocuCheck).anyMatch("reqDocu"::equals)) reqDocu="n";
		if(!Arrays.stream(arrayDocuCheck).anyMatch("compDocu"::equals)) compDocu="n";
		if(!Arrays.stream(arrayDocuCheck).anyMatch("refDocu"::equals)) refDocu="n";
		
		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		map.put("empNo", 123+"");//member.getEmpNo()+""
		map.put("myDocu", myDocu);
		map.put("reqDocu", reqDocu);
		map.put("compDocu", compDocu);
		map.put("refDocu", refDocu);
		
		List<EdocSrch> list = edocService.selectMyList(cPage, numPerPage, map);
		
		int totalContents = edocService.selectMyEdocTotalContents(map);
		
		
//		여기서부터 페이징
		final int totalPage = (int)(Math.ceil((double)totalContents/numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		final int pageEnd = (pageStart+pageBarSize)-1;
		int pageNo = pageStart;
		
		String pageBar = "";
		if(pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		}
		else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage="+(pageNo-1)+"'>&laquo;</a>";
		}
		
		while(pageNo <= pageEnd  && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pageBar += "<span class='active'>"+pageNo+"</span>";
			}
			else {
				pageBar += "<a href='/msg/edoc/srch.do?cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		};
		if(pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		}
		else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage="+pageNo+"'>&raquo;</a>";
		};
		
		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		
		mav.setViewName("edoc/edocList");
		
		return "edoc/edocList"; // mav로
	}

	@GetMapping("/srch.do")
	public String srch(@RequestParam(value="cPage", defaultValue="1") int cPage, String srchWord, String srchType) {
		log.debug("=========전자문서 검색 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;
		
		
		List<EdocSrch> list = edocService.selectList(cPage, numPerPage, srchWord, srchType);
		
		int totalContents = edocService.selectEdocTotalContents(srchWord, srchType);
		
		
		mav.addObject("list", list);
		mav.addObject("totalContents", totalContents);
		
//		여기서부터 페이징
		final int totalPage = (int)(Math.ceil((double)totalContents/numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		final int pageEnd = (pageStart+pageBarSize)-1;
		int pageNo = pageStart;
		
		String pageBar = "";
		if(pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		}
		else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage="+(pageNo-1)+"'>&laquo;</a>";
		}
		
		while(pageNo <= pageEnd  && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pageBar += "<span class='active'>"+pageNo+"</span>";
			}
			else {
				pageBar += "<a href='/msg/edoc/srch.do?cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		};
		if(pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		}
		else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage="+pageNo+"'>&raquo;</a>";
		};
		
		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		
		
		mav.setViewName("edoc/edocSrch");
		
		return "edoc/edocSrch"; //mav로
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

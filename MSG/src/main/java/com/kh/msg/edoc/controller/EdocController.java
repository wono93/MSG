package com.kh.msg.edoc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.edoc.model.service.EdocService;
import com.kh.msg.edoc.model.vo.EdocAtt;
import com.kh.msg.edoc.model.vo.EdocFlow;
import com.kh.msg.edoc.model.vo.EdocLeaveLtt;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

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
	public ModelAndView list(@RequestParam(value="cPage", defaultValue="1") int cPage, String srchWord, @RequestParam(value="srchType", defaultValue="all")String srchType, @RequestParam(value="arrayDocuCheck", defaultValue="myDocu,reqDocu,compDocu,refDocu")String[] arrayDocuCheck, HttpSession session) {
		log.debug("=========내 전자문서 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;
		
		OrgChart m = (OrgChart)session.getAttribute("memberLoggedIn");// 로그인 객체 호출
		
		//일단 초기값은 모든 종류의 문서를 가져오는 것으로 가정
		String myDocu = "y"; 
		String reqDocu = "y"; 
		String compDocu = "y"; 
		String refDocu = "y";
		
		if(!Arrays.stream(arrayDocuCheck).anyMatch("myDocu"::equals)) myDocu="n";
		if(!Arrays.stream(arrayDocuCheck).anyMatch("reqDocu"::equals)) reqDocu="n";
		if(!Arrays.stream(arrayDocuCheck).anyMatch("compDocu"::equals)) compDocu="n";
		if(!Arrays.stream(arrayDocuCheck).anyMatch("refDocu"::equals)) refDocu="n";
		
		// docuCheckMap : 페이지 리다이렉트시 이전에 선택한 검색 조건을 유지 하기 위해 사용
		Map<String, String> docuCheckMap = new HashMap<String, String>();
		docuCheckMap.put("myDocu", myDocu);
		docuCheckMap.put("reqDocu", reqDocu);
		docuCheckMap.put("compDocu", compDocu);
		docuCheckMap.put("refDocu", refDocu);
		
		//
		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		map.put("empNo", m.getEmpNo()+"");//member.getEmpNo()+""
		map.put("myDocu", myDocu);
		map.put("reqDocu", reqDocu);
		map.put("compDocu", compDocu);
		map.put("refDocu", refDocu);

		List<EdocSrch> list = edocService.selectMyList(cPage, numPerPage, map);
		
		log.debug("list.toString()={}", list.toString());
		int totalContents = edocService.selectMyEdocTotalContents(map);
		
		mav.addObject("myEdocList", list);
		
		
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
			pageBar += "<a href='/msg/edoc/list.do?cPage="+(pageNo-1)+"&srchWord="+srchWord+"&srchType="+srchType+"'>&laquo;</a>";
		}
		
		while(pageNo <= pageEnd  && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pageBar += "<a class='active'>"+pageNo+"</a>";
			}
			else {
				pageBar += "<a href='/msg/edoc/list.do?cPage="+pageNo+"&srchWord="+srchWord+"&srchType="+srchType+"'>"+pageNo+"</a>";
			}
			pageNo++;
		};
		if(pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		}
		else {
			pageBar += "<a href='/msg/edoc/list.do?cPage="+pageNo+"&srchWord="+srchWord+"&srchType="+srchType+"'>&raquo;</a>";
		};
		
		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		mav.addObject("docuCheckMap", docuCheckMap);
		mav.addObject("srchWord", srchWord);
		mav.addObject("srchType", srchType);
		
		
		mav.setViewName("edoc/edocList");
		
		return mav;
	}

	@GetMapping("/srch.do")
	public ModelAndView srch(@RequestParam(value="cPage", defaultValue="1") int cPage, String srchWord, String srchType) {
		log.debug("=========전자문서 검색 페이지=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;
		
		log.debug("srchWord@srch.EdocController{}",srchWord);
		log.debug("srchType@srch.EdocController{}",srchType);
		
		List<EdocSrch> list = edocService.selectList(cPage, numPerPage, srchWord, srchType);
		
		int totalContents = edocService.selectEdocTotalContents(srchWord, srchType);
		
		
		mav.addObject("srchList", list);
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
			pageBar += "<a href='/msg/edoc/srch.do?cPage="+(pageNo-1)+"&srchWord="+srchWord+"&srchType="+srchType+"'>&laquo;</a>";
		}
		
		while(pageNo <= pageEnd  && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pageBar += "<a class='active'>"+pageNo+"</a>";
			}
			else {
				pageBar += "<a href='/msg/edoc/srch.do?cPage="+pageNo+"&srchWord="+srchWord+"&srchType="+srchType+"'>"+pageNo+"</a>";
			}
			pageNo++;
		};
		if(pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		}
		else {
			pageBar += "<a href='/msg/edoc/srch.do?cPage="+pageNo+"&srchWord="+srchWord+"&srchType="+srchType+"'>&raquo;</a>";
		};

		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		
		
		mav.setViewName("edoc/edocSrch");
		
		return mav;
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
	public String write(HttpSession session) {
		Member m = (Member)session.getAttribute("memberLoggedIn");
		log.debug("------------------------------------------------------------------{}",m);
		return "edoc/edocWrite";
	}
	@ResponseBody
	@PostMapping("/write.do")
	public String edocWrite(String empNo, String secuCd, String prsvCd, String edocTitle, String vctnCd, String startDt,
			String endDt, String leaveAmt, String leavePurpose, String leaveContact, String typeCd, String surEmpNo, String[] flowLine, String flowCd) {
		
		String edocId = edocService.newEdocId();
		
		List<EdocFlow> edocFlowList = new ArrayList<>();
		List<EdocAtt> edocAttList = new ArrayList<>();
		EdocLeaveLtt edocLeaveLtt = new EdocLeaveLtt();
		
		edocLeaveLtt.setEdocId(edocId);
		edocLeaveLtt.setSecuCd(secuCd);
		edocLeaveLtt.setPrsvCd(prsvCd);
		edocLeaveLtt.setEmpNo(Integer.parseInt(empNo));
		edocLeaveLtt.setEdocTitle(edocTitle);
		edocLeaveLtt.setVctnCd(vctnCd);
		edocLeaveLtt.setStartDt(startDt);
		edocLeaveLtt.setEndDt(endDt);
		edocLeaveLtt.setLeaveAmt(Integer.parseInt(leaveAmt));
		edocLeaveLtt.setLeavePurpose(leavePurpose);
		edocLeaveLtt.setLeaveContact(leaveContact);
		if(surEmpNo != null) {
			edocLeaveLtt.setSurEmpNo(Integer.parseInt(surEmpNo));
		}
		edocLeaveLtt.setTypeCd(typeCd);
		
		if(flowLine.length > 1) {
			for(int i = 0; i < flowLine.length-1; i++) { // 더미 flowLine을 하나 추가했으므로, 컨트롤러로 받은 시점에서 하나를 덜 세는 것.
				EdocFlow ef = new EdocFlow();
				ef.setEdocId(edocId);
				// F1 : 결재, F2 : 전결
				if(flowCd!="") {
					if((Integer.parseInt(flowCd)-1)==i) ef.setFlowCd("F2");
				}
				else ef.setFlowCd("F1");
				ef.setFlowEmpNo(Integer.parseInt(flowLine[i].substring(0, 1)));
				ef.setFlowOrd(i+1);
				edocFlowList.add(ef);
			}
		}
		
		int result = edocService.edocWrite(edocLeaveLtt, edocAttList, edocFlowList);

		return "edoc/list.do";
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
		if(request.getParameter("id").charAt(0) == 'D') {
			try {
				JSONObject sObject = new JSONObject(); 
				sObject.put("empNo", "fail");
				sObject.put("dept", "fail");
				sObject.put("job", "fail");
				sObject.put("name", "fail");
				
				response.setCharacterEncoding("UTF-8");
				PrintWriter out;
				out = response.getWriter();
				out.write(sObject.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else {
			try {
				JstreeMem memOne = edocService.selectJstreeMem(request.getParameter("id"));
				
				log.debug("memOne@EdocController"+memOne.toString());
				
				JSONObject sObject = new JSONObject(); 
				sObject.put("empNo", memOne.getEmpNo());
				sObject.put("dept", memOne.getDeptName());
				sObject.put("job", memOne.getJobName());
				sObject.put("name", memOne.getEmpName());
				
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
}

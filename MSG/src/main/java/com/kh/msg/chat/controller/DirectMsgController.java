package com.kh.msg.chat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.msg.board.model.vo.BoardScrap;
import com.kh.msg.chat.model.service.DirectMsgService;
import com.kh.msg.chat.model.vo.DirectMsg;
import com.kh.msg.member.controller.MemberController;
import com.kh.msg.member.model.vo.LoginVO;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Slf4j
@Controller
@RequestMapping("/chat")
public class DirectMsgController {
	
	@Autowired
	DirectMsgService directMsgService;
	
	@ResponseBody
	@GetMapping("/headerDmList.do")
	public void headerDmList(@RequestParam(value="keyword", required=false) String keyword,
			HttpSession session, HttpServletResponse response,  Model model) {
		
		try {
			List<LoginVO> userList= MemberController.userList;
			
			OrgChart m = (OrgChart)session.getAttribute("memberLoggedIn");
			
			String fromId = m.getUserId();
			
			Map<String, Object> param = new HashMap<>();
			param.put("keyword", keyword);
			param.put("fromId", fromId);
			
			List<DirectMsg> list = directMsgService.headerDmList(param);
			
			JSONArray jsonArr = new JSONArray();
			int unread = 0;
				for(int i = 0; i < list.size(); i++) {
					JSONObject sObject = new JSONObject(); 
						
					Map<String, Object> idMap = new HashMap<>();
					
					idMap.put("fromId", fromId);
					idMap.put("toId",list.get(i).getUserId());
					
					unread = directMsgService.getUnreadDm(idMap);
					
						sObject.put("empImage", list.get(i).getEmpImage());
						sObject.put("empName", list.get(i).getEmpName());
						sObject.put("toId", list.get(i).getUserId());
						sObject.put("jobName", list.get(i).getJobName());
						sObject.put("unread", unread);
						jsonArr.add(sObject);
				}
			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(jsonArr.toString());

		} catch (IOException e) {
			e.printStackTrace();
		}catch(NullPointerException n) {
			n.printStackTrace();
		}
	}
	
	
	
	@PostMapping("/msgInsert.do")
	public void directMsginsert(@RequestParam("toId") String toId,
							   @RequestParam("fromId") String fromId,
							   @RequestParam("msgContent") String msgContent,
							   @RequestParam("empNo") int empNo,
							   HttpServletRequest request,
							   HttpServletResponse response){
		int result = 0;
		try {
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
			
			if(fromId == null || fromId.equals("") || toId == null || toId.equals("")
					|| msgContent == null || msgContent.equals("")){
				response.getWriter().write("0");
				
			}else {
				fromId = URLDecoder.decode(fromId, "UTF-8");
				toId = URLDecoder.decode(toId, "UTF-8");
				msgContent = URLDecoder.decode(msgContent, "UTF-8");
				
				Map<String, Object> param = new HashMap<>();
				param.put("fromId", fromId);
				param.put("toId", toId);
				param.put("empNo", empNo);
				param.put("msgContent", msgContent.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
										.replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				
				result = directMsgService.insert(param);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@ResponseBody
	@PostMapping("/msgList.do")
	public void directMsgList(@RequestParam("toId") String toId,
							  @RequestParam("fromId") String fromId,
							  @RequestParam("listType") String listType,
							  HttpServletRequest request,
							  HttpServletResponse response){
		
		try {
			
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			
			if(fromId == null || fromId.equals("") || toId == null || toId.equals("")
					|| listType == null || listType.equals("")){
				response.getWriter().write("");
				
			}
			else if(listType.equals("ten")) response.getWriter().write(getTen(fromId, toId));
			
			else{
				try {
					response.getWriter().write(getMsgNo(fromId,toId,listType));
					response.getWriter().write("");
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getMsgNo(String fromId, String toId, String msgNo ) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("fromId", fromId);
		param.put("toId", toId);
		param.put("msgNo", msgNo);
		
		List<DirectMsg> chatList = directMsgService.directMsgList(param);
		if(chatList.size() == 0 ) return "";
		
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getEmpName() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getEmpImage() + "\"}]");
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getMsgNo() +"\"}");
		readDm(fromId, toId);
		return result.toString();
	}
	public String getTen(String fromId, String toId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("fromId", fromId);
		param.put("toId", toId);
		param.put("msgNo", 100);
		
		List<DirectMsg> chatList = directMsgService.directMsgListByRecent(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getEmpName() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getEmpImage() + "\"}]");
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getMsgNo() +"\"}");
		readDm(fromId, toId);
		return result.toString();
	}

   public int readDm(String fromId, String toId) {
	   
		Map<String, Object> param = new HashMap<>();
		param.put("fromId", fromId);
		param.put("toId", toId);
		
		int result = directMsgService.readDm(param);
	   
	    return result;
   }
   
   @ResponseBody
   @PostMapping("/getAllUnreadDm.do")
   public void getAllUnreadDm(@RequestParam("fromId") String fromId, HttpServletRequest request,
		   HttpServletResponse response) {
	   try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			
			if(fromId == null || fromId.equals("")) {
					response.getWriter().write("0");
			}else {
				fromId = URLDecoder.decode(fromId, "UTF-8");
				response.getWriter().write(directMsgService.getAllUnreadDm(fromId)+"");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
   }
   @ResponseBody
   @PostMapping("/getUnreadDm.do")
   public void getAllUnreadDm(@RequestParam("fromId") String fromId,@RequestParam("toId") String toId,
		   HttpServletRequest request, 
		   HttpServletResponse response) {
	   try {
		   request.setCharacterEncoding("UTF-8");
		   response.setContentType("text/html;charset=UTF-8");
		   
		   if(fromId == null || fromId.equals("")) {
			   response.getWriter().write("0");
		   }else {
			   fromId = URLDecoder.decode(fromId, "UTF-8");
			   response.getWriter().write(directMsgService.getAllUnreadDm(fromId)+"");
		   }
		   
	   } catch (IOException e) {
		   e.printStackTrace();
	   }
   }
}
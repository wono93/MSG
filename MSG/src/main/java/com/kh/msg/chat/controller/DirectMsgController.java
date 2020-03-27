package com.kh.msg.chat.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.msg.chat.model.dao.DirectMsgDAOImpl;
import com.kh.msg.chat.model.service.DirectMsgService;
import com.kh.msg.chat.model.vo.DirectMsg;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class DirectMsgController {
	
	@Autowired
	DirectMsgService directMsgService;
	
	@GetMapping("/msgList.do")
	public String directMsgList(@RequestParam("toId") String toId, Model model){
		
		DirectMsg dm = directMsgService.selectOne(toId);
		
		model.addAttribute("dm", dm);
		
		return "chat/msgList";
	}
	
	@PostMapping("/msgInsert.do")
	public int directMsginsert(@RequestParam("toId") String toId,
								 @RequestParam("fromId") String fromId,
								 @RequestParam("msgContent") String msgContent,
								 HttpServletRequest request,
								 HttpServletResponse response){
			
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
				param.put("msgContent",
							msgContent.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
										.replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				
				log.debug("param={}",param);
				
				int result = directMsgService.insert(param);
				
				log.debug("result={}",result);
				
				response.getWriter().write(new DirectMsgDAOImpl().insert(param) + "");
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	@PostMapping("/msgList.do")
	public void directMsgList(@RequestParam("toId") String toId,
			@RequestParam("fromId") String fromId,
			HttpServletRequest request,
			HttpServletResponse response){
		
		
		String listType = request.getParameter("listType");
		
		log.debug("fromId="+fromId+", toId="+toId+" listType="+listType);
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
		
		log.debug("param={}",param);
		
		List<DirectMsg> chatList = directMsgService.directMsgList(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getEmpName() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"}]");
			
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getMsgNo() +"\"}");
		
		log.debug("result={}",result);
		
		return result.toString();
		
	}
	public String getTen(String fromId, String toId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("fromId", fromId);
		param.put("toId", toId);
		param.put("msgNo", 10);
		
		log.debug("param={}",param);
		
		List<DirectMsg> chatList = directMsgService.directMsgListByRecent(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getEmpName() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"}]");
			
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getMsgNo() +"\"}");
		
		log.debug("result={}",result);
		
		return result.toString();
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

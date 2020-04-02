package com.kh.msg.chat.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.chat.model.service.ChannelService;
import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChannelController {
	
	@Autowired
	ChannelService channelService;
	
	@GetMapping("/headerChList.do")
	public void headerDmList(HttpSession session, HttpServletResponse response) {
		
		try {
			
			Member m = (Member)session.getAttribute("memberLoggedIn");
			
			String fromId = m.getUserId();
			
			List<ChannelInfo> list = channelService.headerChList(fromId);
			
			log.debug("list@ChannelController"+list.toString());
			
			JSONArray jsonArr = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject sObject = new JSONObject(); 
				sObject.put("userId", list.get(i).getUserId());
				sObject.put("chNo", list.get(i).getChNo());
				sObject.put("chName", list.get(i).getChName());
				
				jsonArr.add(sObject);
			}
			
			response.setCharacterEncoding("UTF-8");
			PrintWriter out;
			out = response.getWriter();
			out.write(jsonArr.toString());
			
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	@PostMapping("/channel.do")
	public ModelAndView channelList(String userId, String chNo, ModelAndView mav) {
		log.debug(userId+ chNo);
		
		mav.addObject("userId",userId);
		mav.addObject("chNo",chNo);
		
		mav.setViewName("/chat/channel");
		return mav;
	}
	@PostMapping("/channelContent.do")
	public void channelList(
							@RequestParam(value="userId", required=false) String userId,
							@RequestParam(value="chNo", required=false) String chNo,
							  HttpServletRequest request,
							  HttpServletResponse response){
		
		String listType = request.getParameter("listType");
		
		log.debug("userId="+userId+", chNo="+chNo+" listType="+listType);
		try {
			
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			
			if(userId == null || userId.equals("") || chNo == null || listType == null || listType.equals("")){
				response.getWriter().write("");
				
			}
			else if(listType.equals("ten")) response.getWriter().write(getTen(userId, chNo));
			
			else{
				try {
					response.getWriter().write(getMsgNo(userId,chNo,listType));
					response.getWriter().write("");
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getMsgNo(String userId, String chNo, String msgNo ) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("chNo", chNo);
		param.put("msgNo", msgNo);
		
		log.debug("param={}",param);
		
		List<ChannelMsg> chatList = channelService.channelListByNumber(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getChNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getUserId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getEmpImage() + "\"}]");
			
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getMsgNo() +"\"}");
		
		log.debug("result={}",result);
		
		return result.toString();
		
	}
	public String getTen(String userId, String chNo) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("chNo", chNo);
		param.put("msgNo", 10);
		
		log.debug("param={}",param);

		List<ChannelMsg> chatList = channelService.channelListByRecent(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getChNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getUserId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getEmpImage() + "\"}]");
			
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getMsgNo() +"\"}");
		
		log.debug("result={}",result);
		
		return result.toString();
		
	}
	
//	@PostMapping("/msgInsert.do")
//	public void directMsginsert(@RequestParam("toId") String toId,
//							   @RequestParam("fromId") String fromId,
//							   @RequestParam("msgContent") String msgContent,
//							   @RequestParam("empNo") int empNo,
//							   HttpServletRequest request,
//							   HttpServletResponse response){
//		int result = 0;
//		try {
//				request.setCharacterEncoding("UTF-8");
//				response.setContentType("text/html;charset=UTF-8");
//			
//			if(fromId == null || fromId.equals("") || toId == null || toId.equals("")
//					|| msgContent == null || msgContent.equals("")){
//				response.getWriter().write("0");
//				
//			}else {
//				fromId = URLDecoder.decode(fromId, "UTF-8");
//				toId = URLDecoder.decode(toId, "UTF-8");
//				msgContent = URLDecoder.decode(msgContent, "UTF-8");
//				
//				Map<String, Object> param = new HashMap<>();
//				param.put("fromId", fromId);
//				param.put("toId", toId);
//				param.put("empNo", empNo);
//				param.put("msgContent", msgContent.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
//										.replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
//				
//				log.debug("param={}",param);
//				
//				result = directMsgService.insert(param);
//				
//				log.debug("result={}",result);
//				
////				response.getWriter().write(new DirectMsgDAOImpl().insert(param) + "");
//				
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
}

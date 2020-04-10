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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.chat.model.service.ChannelService;
import com.kh.msg.chat.model.vo.ChannelInfo;
import com.kh.msg.chat.model.vo.ChannelMember;
import com.kh.msg.chat.model.vo.ChannelMsg;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

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
	@ResponseBody
	public void headerDmList(HttpSession session, HttpServletResponse response) {
		
		try {
			
			Member m = (Member)session.getAttribute("memberLoggedIn");
			
			String fromId = m.getUserId();
			
			List<Integer> chNoList = channelService.chMemberList(fromId);
			
			
			log.debug("chNoList@ChannelController"+chNoList.toString());
			
			List<ChannelInfo> list = channelService.headerChList(chNoList);
			
			
			JSONArray jsonArr = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject sObject = new JSONObject(); 
				sObject.put("userId", fromId);
				sObject.put("chNo", list.get(i).getChNo());
				sObject.put("chName", list.get(i).getChName());
				sObject.put("regId", list.get(i).getRegId());
				sObject.put("chEx", list.get(i).getChEx());
				
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
	@GetMapping("/channelMember.do")
	@ResponseBody
	public void channelMember(String chNo,HttpSession session, HttpServletResponse response) {
		
		try {
			
			List<ChannelMember> MemberList = channelService.channelMember(chNo);
			
//			log.debug("Memberlist@ChannelController"+MemberList.toString());
			
			JSONArray jsonArr = new JSONArray();
			
			for(int i = 0; i < MemberList.size(); i++) {
				JSONObject sObject = new JSONObject(); 
				sObject.put("userId", MemberList.get(i).getUserId());
				sObject.put("empImage", MemberList.get(i).getEmpImage());
				sObject.put("regId", MemberList.get(i).getRegId());
				
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
	public ModelAndView channelList(String userId, String chNo, String chName, String chEx, String regId, ModelAndView mav) {
		
		mav.addObject("userId",userId);
		mav.addObject("chNo",chNo);
		mav.addObject("chName",chName);
		mav.addObject("chEx",chEx);
		mav.addObject("regId",regId);
		mav.setViewName("/chat/channel");
		
		return mav;
	}
	@ResponseBody
	@PostMapping("/channelContent.do")
	public void channelList(
							@RequestParam(value="userId", required=false) String userId,
							@RequestParam(value="chNo", required=false) String chNo,
							  HttpServletRequest request,
							  HttpServletResponse response){
		
		String listType = request.getParameter("listType");
		
		log.debug("listType="+listType);
//		log.debug("userId="+userId+", chNo="+chNo+" listType="+listType);
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
	
	public String getMsgNo(String userId, String chNo, String chMsgNo ) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("chNo", chNo);
		param.put("chMsgNo", chMsgNo);
		
		log.debug("param={}",param);
		
		List<ChannelMsg> chatList = channelService.channelListByNumber(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getChNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChMsgNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getUserId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getEmpImage() + "\"}]");
			
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getChMsgNo() +"\"}");
		
		log.debug("result={}",result);
		
		return result.toString();
		
	}
	public String getTen(String userId, String chNo) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("chNo", chNo);
		param.put("chMsgNo", 10);
		
		log.debug("param={}",param);

		List<ChannelMsg> chatList = channelService.channelListByRecent(param);
		if(chatList.size() == 0 ) return "";
		for(int i = 0; i<chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getChNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChMsgNo() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getUserId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMsgDate() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getEmpImage() + "\"}]");
			
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size() -1).getChMsgNo() +"\"}");
		
		log.debug("result={}",result);
		
		return result.toString();
		
	}
	
	@PostMapping("/channelMsgInsert.do")
	public void channelMsgInsert(@RequestParam("chNo") int chNo,
								 @RequestParam("empNo") int empNo,
								 @RequestParam("userId") String userId,
								 @RequestParam("msgContent") String msgContent,
								 HttpServletRequest request,
								 HttpServletResponse response){
		int result = 0;
		try {
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
			
			if(chNo == 0 || empNo == 0 || userId == null || userId.equals("")
					|| msgContent == null || msgContent.equals("")){
				response.getWriter().write("0");
				
			}else {
				userId = URLDecoder.decode(userId, "UTF-8");
				msgContent = URLDecoder.decode(msgContent, "UTF-8");
				
				Map<String, Object> param = new HashMap<>();
				param.put("chNo", chNo);
				param.put("empNo", empNo);
				param.put("userId", userId);
				param.put("msgContent", msgContent.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
										.replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				
				log.debug("param={}",param);
				
				result = channelService.insert(param);
				
				log.debug("result={}",result);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	
	}
	@GetMapping("/searchListCh.do")
	public void searchListCh(@RequestParam("keyword") String keyword,
							 @RequestParam("searchType") String searchType,
							 HttpServletRequest request,
							 HttpServletResponse response) {
		try {

			Map<String, Object> param = new HashMap<>();
				param.put("keyword", keyword);
				param.put("searchType", searchType);
			
			List<OrgChart> list = channelService.searchListCh(param);
			
			log.debug("list@ChannelController"+list.toString());
			
			JSONArray jsonArr = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject sObject = new JSONObject(); 
				sObject.put("empImage", list.get(i).getEmpImage());
				sObject.put("empName", list.get(i).getEmpName());
				sObject.put("deptName", list.get(i).getDeptName());
				sObject.put("jobName", list.get(i).getJobName());
				sObject.put("empNo", list.get(i).getEmpNo());
				
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
		
	@PostMapping("/generateChannel.do")
	public ModelAndView generateChannel(ModelAndView mav, ChannelInfo chInfo,
										@RequestParam("empNo") int[] empNo,
										@RequestParam("chName") String chName,
										@RequestParam("regId") String regId,
										@RequestParam("chEx") String chEx,
										@RequestParam("regEmpNo") int regEmpNo,
										RedirectAttributes redirectAttributes) {
		
		log.debug("empNo={}", empNo);
//		log.debug("empNo.length="+ empNo.length);
		
		int result = channelService.generateChannel(chInfo);
		
		int chNo = chInfo.getChNo();
		
		int memberResult = channelService.addChannelMember(empNo, chNo, regEmpNo);
		
		mav.addObject("userId",regId);
		mav.addObject("chNo",chInfo.getChNo());
		mav.addObject("chName",chName);
		
		mav.setViewName("chat/channel");
		return mav;
		
	}
	@PostMapping("/modifyChannel.do")
	public ModelAndView modifyChannel(ModelAndView mav, ChannelInfo chInfo,
			@RequestParam(value="empNo", required=false) int[] empNo,
			@RequestParam(value="chName", required=false) String chName,
			@RequestParam(value="regId", required=false) String regId,
			@RequestParam(value="chEx", required=false) String chEx,
			@RequestParam(value="regEmpNo", required=false) int regEmpNo,
			@RequestParam(value="chNo", required=false) int chNo,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request,
			 HttpServletResponse response) {
		
		log.debug("empNo={}", empNo);
//		log.debug("empNo.length="+ empNo.length);
		
		try {
			if(chNo != 0) {
				
				List<OrgChart> list = channelService.presentMember(chNo);
				
				JSONArray jsonArr = new JSONArray();
				
				for(int i = 0; i < list.size(); i++) {
					JSONObject sObject = new JSONObject(); 
					sObject.put("empImage", list.get(i).getEmpImage());
					sObject.put("empName", list.get(i).getEmpName());
					sObject.put("deptName", list.get(i).getDeptName());
					sObject.put("jobName", list.get(i).getJobName());
					sObject.put("empNo", list.get(i).getEmpNo());
					
					jsonArr.add(sObject);
					
				}
				
				response.setCharacterEncoding("UTF-8");
				
				PrintWriter out;
				out = response.getWriter();
				out.write(jsonArr.toString());
					
			}
			
			int deleteResult = channelService.deleteChannelMember(chNo);
			
			int insertResult = channelService.addChannelMember(empNo, chNo, regEmpNo);
		
			int result = channelService.modifyChannel(chInfo);
			
			mav.addObject("userId",regId);
			mav.addObject("chNo",chInfo.getChNo());
			mav.addObject("chName",chName);
			
			mav.setViewName("chat/channel");
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		return mav;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
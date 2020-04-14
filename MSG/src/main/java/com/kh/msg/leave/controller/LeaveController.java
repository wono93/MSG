package com.kh.msg.leave.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.edoc.model.vo.Edoc;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.leave.model.service.LeaveService;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveAnnual;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeaveModal;
import com.kh.msg.leave.model.vo.LeaveOther;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveReward;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.LeaveSum;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/leave")
public class LeaveController {

	@Autowired
	LeaveService leaveService;

	/* 전체 휴가내역 리스트 */
	@GetMapping("/list.do")
	public ModelAndView allList(@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "srchWord", defaultValue = "") String srchWord,
			@RequestParam(value = "srchType", defaultValue = "all") String srchType) {
		log.debug("=========allvacation 모든 휴가 리스트=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;

		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);

		List<Leave> leaveList = leaveService.selectLeaveList(cPage, numPerPage, map);
		log.debug("leaveList.toString()={}", leaveList.toString());
		int totalContents = leaveService.selectAllVacationTotalContents(map);

		mav.addObject("leaveList", leaveList);

//		여기서부터 페이징
		final int totalPage = (int) (Math.ceil((double) totalContents / numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		final int pageEnd = (pageStart + pageBarSize) - 1;
		int pageNo = pageStart;

		String pageBar = "";
		if (pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		} else {
			pageBar += "<a href='/msg/leave/list.do?cPage=" + (pageNo - 1) + "&srchWord=" + srchWord + "&srchType="
					+ srchType + "'>&laquo;</a>";
		}

		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				pageBar += "<a class='active'>" + pageNo + "</a>";
			} else {
				pageBar += "<a href='/msg/leave/list.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
						+ srchType + "'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		;
		if (pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		} else {
			pageBar += "<a href='/msg/leave/list.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType=" + srchType
					+ "'>&raquo;</a>";
		}
		;

		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		mav.addObject("srchWord", srchWord);
		mav.addObject("srchType", srchType);

		mav.setViewName("leave/allvacation");

		return mav;
	}

	// 나의 휴가 내역
	@GetMapping("/select.do")
	public ModelAndView myList(@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "srchWord", defaultValue = "") String srchWord,
			@RequestParam(value = "srchType", defaultValue = "all") String srchType, HttpSession session) {
		log.debug("=========myvacation 나의 휴가 리스트=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;

		Member m = (Member) session.getAttribute("memberLoggedIn");

		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		map.put("empNo", m.getEmpNo() + "");// member.getEmpNo()+""

		List<MyLeave> leaveMyList = leaveService.selectMyLeaveList(cPage, numPerPage, map);
		List<LeaveInfoPlus> leaveListInfoPlus = leaveService
				.selectleaveListInfoPlus((Member) session.getAttribute("memberLoggedIn"));
		LeaveInfoPlus lip = new LeaveInfoPlus();
		log.debug("leaveMyList.toString()={}", leaveMyList.toString());
		int totalContents = leaveService.selectMyVacationTotalContents(map);

		int annual = 0; // 연차
		int reward = 0; // 포상
		int official = 0; // 공가
		int funeral = 0; // 경조사
		int sick = 0; // 병가
		int unpaid = 0; // 무급
		int other = 0; // 기타

		for (int i = 0; i < leaveListInfoPlus.size(); i++) {

			lip.setEmpNo(leaveListInfoPlus.get(i).getEmpNo());
			lip.setDeptName(leaveListInfoPlus.get(i).getDeptName());
			lip.setJobName(leaveListInfoPlus.get(i).getJobName());
			lip.setUserId(leaveListInfoPlus.get(i).getUserId());
			lip.setEmpName(leaveListInfoPlus.get(i).getEmpName());
			lip.setAnnual(leaveListInfoPlus.get(i).getAnnual());
			lip.setReward(leaveListInfoPlus.get(i).getReward());
			if (leaveListInfoPlus.get(i).getVctnCd().equals("V1")) {
				annual += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd().equals("V2")) {
				reward += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd().equals("V3")) {
				official += leaveListInfoPlus.get(i).getVctnUsed();
				;
			} else if (leaveListInfoPlus.get(i).getVctnCd().equals("V4")) {
				funeral += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd().equals("V5")) {
				sick += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd().equals("V6")) {
				unpaid += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd().equals("V7")) {
				other += leaveListInfoPlus.get(i).getVctnUsed();
			}

		}
		lip.setAnnualUsed(annual);
		lip.setRewardUsed(reward);
		lip.setFloatingUsed(official);
		lip.setFamilyeventUsed(funeral);
		lip.setSickleaveUsed(sick);
		lip.setUnpaidUsed(unpaid);
		lip.setOtherUsed(other);
		lip.setAnnualNotUsed(lip.getAnnual() - lip.getAnnualUsed());
		lip.setRewardNotused(lip.getReward() - lip.getRewardUsed());

		leaveListInfoPlus.add(lip);

		mav.addObject("leaveMyList", leaveMyList);
		mav.addObject("leaveListInfoPlus", leaveListInfoPlus);

		// 여기서부터 페이징
		final int totalPage = (int) (Math.ceil((double) totalContents / numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		final int pageEnd = (pageStart + pageBarSize) - 1;
		int pageNo = pageStart;

		String pageBar = "";
		if (pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		} else {
			pageBar += "<a href='/msg/leave/select.do?cPage=" + (pageNo - 1) + "&srchWord=" + srchWord + "&srchType="
					+ srchType + "'>&laquo;</a>";
		}

		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				pageBar += "<a class='active'>" + pageNo + "</a>";
			} else {
				pageBar += "<a href='/msg/leave/select.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
						+ srchType + "'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		;
		if (pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		} else {
			pageBar += "<a href='/msg/leave/select.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
					+ srchType + "'>&raquo;</a>";
		}
		;

		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		mav.addObject("srchWord", srchWord);
		mav.addObject("srchType", srchType);

		mav.setViewName("leave/myvacation");

		return mav;
	}

	@GetMapping("/modal") // 모달 내역 테이블
	@ResponseBody
	public List<LeaveModal> modal(@RequestParam("empNo") int empNo) {

		List<LeaveModal> modalList = leaveService.selectModalList(empNo);

		return modalList;
	}

	@GetMapping("/modalSearch") // 모달내 검색
	@ResponseBody
	public List<Edoc> modalSearch() {

		List<Edoc> edocList = leaveService.selectModalSearch();
		log.debug("edocList={}", edocList);
		return edocList;
	}

	@PostMapping("/update.do") // 모달 내 insert 테이블
	@ResponseBody
	public String modalInsert(@RequestParam("empNo") int empNo, @RequestParam("edocId") String edocId,
			@RequestParam("vctnCd") String vctnCd, @RequestParam("vctnAmt") int vctnAmt,
			@RequestParam("vctnReason") String vctnReason, RedirectAttributes redirectAttributes) {

		// 1.비지니스로직 실행

		int result = leaveService.insertModal(empNo, edocId, vctnCd, vctnAmt, vctnReason);

		return "redirect:/leave/update.do";
	}

	/* 전체 휴가조wjd 리스트 */
	@GetMapping("/update.do")
	public ModelAndView setList(@RequestParam(value = "cPage", defaultValue = "1") int cPage, 
			@RequestParam(value = "srchWord", defaultValue = "") String srchWord,
			@RequestParam(value = "srchType", defaultValue = "all") String srchType) {
		log.debug("=========setvacation 조정 휴가 리스트=========");
		ModelAndView mav = new ModelAndView();
		final int numPerPage = 15;

		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);

		/* log.debug("leaveList.toString()={}", leaveList.toString()); */
		int totalContents = leaveService.selectSetVacationTotalContents(map);

		log.debug("leaveService={}", leaveService.getClass());

		List<LeaveAnnual> listAnnual = leaveService.selectAnnualList();
		List<LeaveReward> listReward = leaveService.selectRewardList();
		List<LeaveOther> listOther = leaveService.selectOtherList();
		List<LeaveSum> listSum = leaveService.selectSetLeaveList(cPage, numPerPage, map);
			
		
		mav.addObject("listOther", listOther);
		mav.addObject("listAnnual", listAnnual);
		mav.addObject("listReward", listReward);

		mav.addObject("listSum", listSum);

//			여기서부터 페이징
		final int totalPage = (int) (Math.ceil((double) totalContents / numPerPage));
		final int pageBarSize = 5;
		final int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		final int pageEnd = (pageStart + pageBarSize) - 1;
		int pageNo = pageStart;

		String pageBar = "";
		if (pageNo == 1) {
			pageBar += "<a href=\"#\" class=\"arrow\">&laquo;</a>";
		} else {
			pageBar += "<a href='/msg/leave/update.do?cPage=" + (pageNo - 1) + "&srchWord=" + srchWord + "&srchType="
					+ srchType + "'>&laquo;</a>";
		}

		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				pageBar += "<a class='active'>" + pageNo + "</a>";
			} else {
				pageBar += "<a href='/msg/leave/update.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType="
						+ srchType + "'>" + pageNo + "</a>";
			}
			pageNo++;
		}
		;
		if (pageNo > totalPage) {
			pageBar += "<a href=\"#\" class=\"arrow\">&raquo;</a>";
		} else {
			pageBar += "<a href='/msg/leave/update.do?cPage=" + pageNo + "&srchWord=" + srchWord + "&srchType=" + srchType
					+ "'>&raquo;</a>";
		}
		;

		mav.addObject("pageBar", pageBar);
		mav.addObject("cPage", cPage);
		mav.addObject("srchWord", srchWord);
		mav.addObject("srchType", srchType);

		mav.setViewName("leave/vacation");

		return mav;
	}

}

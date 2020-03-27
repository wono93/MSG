package com.kh.msg.leave.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.leave.model.service.LeaveService;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.LeaveSum;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/leave")
public class LeaveController {

	@Autowired
	LeaveService leaveService;

	@GetMapping("/list.do")
	public ModelAndView leave(ModelAndView mav) {

		log.debug("leaveService={}", leaveService.getClass());

		List<Leave> leaveList = leaveService.selectLeaveList();

		mav.addObject("leaveList", leaveList);

		mav.setViewName("leave/allvacation");

		return mav;
	}

	@GetMapping("/select.do")
	public String select() {
		return "leave/myvacation";
	}

	@GetMapping("/update.do")
	public ModelAndView leave2(ModelAndView mav) {

		List<LeaveSet> leaveList2 = leaveService.selectLeaveList2();
		List<LeavePlus> leaveList3 = leaveService.selectLeaveList3();
		List<LeaveSum> listSum = new ArrayList<>();
		int emp = 0;

		for (int i = 0; i < leaveList2.size(); i++) {
			LeaveSum ls = new LeaveSum();
			ls.setVctnNo(leaveList2.get(i).getVctnNo());
			ls.setDeptName(leaveList2.get(i).getDeptName());
			ls.setEmpName(leaveList2.get(i).getEmpName());
			ls.setLongevity(leaveList2.get(i).getLongevity());
			ls.setReward(leaveList2.get(i).getReward());
			ls.setAnnual(leaveList2.get(i).getAnnual());
			ls.setEmpNo(leaveList2.get(i).getEmpNo());
			
			int ot = 0;
			for (int j = emp; j < leaveList3.size(); j++) {
				if (ls.getEmpNo() == leaveList3.get(j).getEmpNo()  ) {
					if (leaveList3.get(j).getVctnCd() == 1) {
						ls.setAnnualUsed(leaveList3.get(j).getVctnUsed());
					} else if (leaveList3.get(j).getVctnCd() == 2) {
						ls.setRewardUsed(leaveList3.get(j).getVctnUsed());
					} else {

						ot += leaveList3.get(j).getVctnUsed();
					}
						
				}else{
					emp=j;
					break; 
				}
					
			}		
			ls.setOtherUsed(ot);
			listSum.add(ls);
		}
		System.out.println("listSum"+listSum);

		mav.addObject("listSum", listSum);

		mav.setViewName("leave/vacation");

		return mav;
	}

}

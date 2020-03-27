package com.kh.msg.res.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.res.model.service.ResService;
import com.kh.msg.res.model.vo.Car;
import com.kh.msg.res.model.vo.CarReservation;
import com.kh.msg.res.model.vo.ConfReservation;
import com.kh.msg.res.model.vo.ConferenceRoom;
import com.kh.msg.res.model.vo.ResView;
import com.kh.msg.res.model.vo.Reservation;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/res")
public class ResController {
	
	@Autowired
	private ResService resService;

	//회의실예약페이지에 DB에 등록된 회의실 불러오기 
	@GetMapping("/confRes.do")
	public ModelAndView selectConfList() {
		ModelAndView mav = new ModelAndView();
		
		List<ConferenceRoom> cList = resService.selectConfList();
		mav.addObject("cList", cList);
		
		mav.setViewName("res/confroomReservation");
		return mav;
	}
	
	//회의실 예약하기
	@PostMapping("/confInsert.do")
	public ModelAndView confInsert( ConfReservation cr,
//									@RequestParam(value = "resUseDate") String resUseDate,
//									@RequestParam(value = "resReturnDate") String resReturnDate,
									RedirectAttributes redirectAttributes) {
		ModelAndView mav = new ModelAndView();
		
		log.debug("confReservation={}", cr);
		
		int result = resService.confInsert(cr);
//		String msg = result>0?"등록 성공!":"등록 실패!";
//		log.debug(cr.getCroomCode() + msg);
//		
//		redirectAttributes.addFlashAttribute("msg", msg);
//		
//		return "redirect:/res/view.do";
		mav.setViewName("redirect:/res/myResView.do");
		return mav;
	}
	
	//차량예약페이지에 DB에 등록된 차량 불러오기 
	@GetMapping("/carRes.do")
	public ModelAndView selectCarList() {
		ModelAndView mav = new ModelAndView();
		
		List<Car> list = resService.selectCarList();
		mav.addObject("list", list);
		
		mav.setViewName("res/carReservation");
		return mav;
	}
	
	//차량 예약하기
	@PostMapping("/carInsert.do")
	public ModelAndView confInsert( CarReservation cr) {
	ModelAndView mav = new ModelAndView();
	
	log.debug("carReservation={}", cr);
	
	int result = resService.carInsert(cr);
	
	mav.setViewName("redirect:/res/myResView.do");
	return mav;
	}
	
	 
	
	//자신의 예약내역 보기
	@GetMapping("/myResView.do")
	public ModelAndView selectAllMyResList() {
		ModelAndView mav = new ModelAndView();
		
		List<ResView> confList = resService.selectAllMyConfResList();
		List<ResView> carList = resService.selectAllMyCarResList();
		
		log.debug("confList={}", confList);
		log.debug("carList={}", carList);
		
		List<ResView> rList = new ArrayList<>();
		
		for(int i=0; i<confList.size(); i++) {
			rList.add(confList.get(i));
		}
		
		int k = 0;
		for(int j=confList.size(); j<confList.size()+carList.size(); j++) {
			rList.add(carList.get(k));
			log.debug("carList(k)={}", carList.get(k));
			k++;
		}
		
		Collections.sort(rList);
		
		log.debug("rList={}", rList);
		
		mav.addObject("confList", confList);
		mav.addObject("carList", carList);
		mav.addObject("rList", rList);
		
		mav.setViewName("res/resView");
		return mav;
	}
}

//	@PostMapping("/test.do")
//	public String confInsertTest() {
//		String pname = request.getParameter("pname");
//		int amount = Integer.parseInt(request.getParameter("amount"));
//		//업무로직
//		
//		
//		SmartPhone smart = new SmartPhone(pname, amount, null);
//		
//		int result = new SmartPhoneService().smartInsert(smart);
//	}
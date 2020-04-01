package com.kh.msg.res.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
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
	public ModelAndView confInsert( ConfReservation cr, RedirectAttributes redirectAttributes) {
		ModelAndView mav = new ModelAndView();
		
		log.debug("confReservation={}", cr);
		
		int result = resService.confInsert(cr);

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
	@ResponseBody
	@GetMapping("/myResView.do")
	public ModelAndView selectAllMyResList() {
		ModelAndView mav = new ModelAndView();
		
		List<ResView> confList = resService.selectAllMyConfResList();
		List<ResView> carList = resService.selectAllMyCarResList();
		
		log.debug("confList={}", confList);
		log.debug("carList={}", carList);
		
//		List<ResView> rList = new ArrayList<>();
//		
//		for(int i=0; i<confList.size(); i++) {
//			rList.add(confList.get(i));
//		}
//		
//		int k = 0;
//		for(int j=confList.size(); j<confList.size()+carList.size(); j++) {
//			rList.add(carList.get(k));
//			log.debug("carList(k)={}", carList.get(k));
//			k++;
//		}
//		
//		Collections.sort(rList);
		
		List<ResView> rList = resService.selectAllMyRList();
		
		log.debug("rList={}", rList);
		
		mav.addObject("confList", confList);
		mav.addObject("carList", carList);
		mav.addObject("rList", rList);
		
		mav.setViewName("res/resView");
		return mav;
	}
	
	@PostMapping("/addConf.do")
	public ModelAndView addConf( ConferenceRoom c) {
		ModelAndView mav = new ModelAndView();
		
		log.debug("conferenceRoom={}", c);
		
		int result = resService.addConferenceRoom(c);
		
		mav.setViewName("redirect:/res/confRes.do");
		return mav;
	}
	
	@PostMapping("/addCar.do")
	public ModelAndView addConf( Car c) {
		ModelAndView mav = new ModelAndView();
//		log.debug("car111={}", c);
		
		  String seq = "SEQ_"+c.getCarCate()+"_CODE"; //input에 해당하는 시퀀스 int carSeq =
		  log.debug("seq="+seq);
		  
		  int carSeq = resService.getNextval(seq); //seq를 이용해 input의 carCode설정
		  log.debug("carSeq="+carSeq);
		  
		  //현재 sequence 값이 10 미만이라면 0을 붙여 carCate 뒤에 붙여줌 (ex.CAR104)
		  if(carSeq < 10) {
			  c.setCarCode(c.getCarCate()+"0"+carSeq); 
		  }
		  else {
			  c.setCarCode(c.getCarCate()+carSeq); 
		  }
		  
		  int result = resService.addCar(c);
		 
		
		mav.setViewName("redirect:/res/carRes.do");
		return mav;
		}

	@DeleteMapping(value="/delCar/{carCode}")
	public Map<String, String> delCar(@PathVariable("carCode") String carCode){
		
		//log.debug("삭제할 차량코드 = "+carCode);
		String msg = resService.delCar(carCode)>0?"선택하신 차량이 삭제되었습니다.":"선택 차량을 삭제하는 데 실패했습니다.";
		
		//String 전송하면 클라이언트에서 json parse error -> map 전송
		Map<String, String> map = new HashMap<>();
		map.put("msg", msg);
		return map;
		
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
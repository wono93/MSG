package com.kh.msg.res.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.res.model.service.ResService;
import com.kh.msg.res.model.vo.Car;
import com.kh.msg.res.model.vo.CarReservation;
import com.kh.msg.res.model.vo.ConfReservation;
import com.kh.msg.res.model.vo.ConferenceRoom;
import com.kh.msg.res.model.vo.ResView;
import com.kh.msg.res.model.vo.Reservation;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	@PostMapping("/confResInsert.do")
	public ModelAndView confResInsert( ConfReservation cr, RedirectAttributes redirectAttributes) {
		ModelAndView mav = new ModelAndView();
		
		//log.debug("confReservation={}", cr);
		
		int result = resService.confResInsert(cr);

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
	@PostMapping("/carResInsert.do")
	public ModelAndView carResInsert( CarReservation cr) {
	ModelAndView mav = new ModelAndView();
	
	//log.debug("carReservation={}", cr);
	
	int result = resService.carResInsert(cr);
	
	mav.setViewName("redirect:/res/myResView.do");
	return mav;
	}
	
	 
	
	//자신의 예약내역 보기
	@ResponseBody
	@GetMapping("/myResView.do")
	//@GetMapping("/myResView/{empNo}/{isManager}")
	public ModelAndView selectAllMyResList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Member m = (Member)session.getAttribute("memberLoggedIn");
		
		log.debug("member={}",m);
		
		List<ResView> confList = resService.selectAllConfResList(m);
		List<ResView> carList = resService.selectAllCarResList(m);
		List<ResView> rList = resService.selectAllRList(m);
		
		
		
		//log.debug("confList={}", confList);
		//log.debug("carList={}", carList);
		//log.debug("rList={}", rList);
		
		mav.addObject("confList", confList);
		mav.addObject("carList", carList);
		mav.addObject("rList", rList);
		
		mav.setViewName("res/resView");
		return mav;
	}
	
	//미완
	@PostMapping("/addConf.do")
	public ModelAndView addConf( ConferenceRoom c) {
		ModelAndView mav = new ModelAndView();
		
		String seq = "SEQ_CONF_ROOM_CODE";
		int confSeq = resService.getNextval(seq);
		
		c.setCroomCode("CONF"+confSeq); //회의실예약 코드 만들기
		
		//log.debug("conferenceRoom={}", c);
		
		int result = resService.addConferenceRoom(c);
		
		mav.setViewName("redirect:/res/confRes.do");
		return mav;
	}
	
	@PostMapping("/addCar.do")
	public ModelAndView addConf( Car c) {
		ModelAndView mav = new ModelAndView();
//		log.debug("car111={}", c);
		
		  String seq = "SEQ_"+c.getCarCate()+"_CODE"; //input에 해당하는 시퀀스 int carSeq =
//		  log.debug("seq="+seq);
		  
		  int carSeq = resService.getNextval(seq); //seq를 이용해 input의 carCode설정
		  //log.debug("carSeq="+carSeq);
		  
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
	
	//차량예약페이지에서 대여마감시간까지 클릭시 ajax로 이미 예약된 list/빌릴 수 있는 list 구분 출력해주기
	@GetMapping("/carListEnd")
	@ResponseBody
	public Map<String,List<Car>> selectCarListEnd(@RequestParam("resUseDate") String resUseDate,
										 @RequestParam("resReturnDate") String resReturnDate) {
		ModelAndView mav = new ModelAndView();
		
		//log.debug("대여 시작할 시간="+resUseDate+", 대여 마감시간="+resReturnDate);
		
		List<Car> allCarList = resService.selectCarList();
		List<Car> unborrowableList =  resService.selectCarListEnd(resUseDate, resReturnDate);
		@SuppressWarnings("unchecked")
		List<Car> borrowableList = ListUtils.subtract(allCarList, unborrowableList);
		
		
//		for(int i=0; i<allCarList.size(); i++) {
//			
//			if(!unborrowableList.contains(allCarList.get(i))) {
//				borrowableList.add(allCarList.get(i));
//			}
//			
//		}
		
		
//		log.debug("allCarList={}",allCarList);
//		log.debug("unborrowableList={}", unborrowableList);
//		log.debug("borrowableList={}", borrowableList);
		
		Map<String,List<Car>> allCarMap = new HashMap<String, List<Car>>();
		allCarMap.put("borrowable", borrowableList);
		allCarMap.put("unborrowable", unborrowableList);
		
		return allCarMap;
	}
		
}

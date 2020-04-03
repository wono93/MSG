package com.kh.msg.member.controller;

import java.util.Calendar;
import java.util.Date;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SimpleTimeZone;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.common.util.Utils;
import com.kh.msg.member.model.exception.MemberException;
import com.kh.msg.member.model.service.MemberService;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.IOLog;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@SessionAttributes(value = { "memberLoggedIn" })
public class MemberController {
	@Autowired
	MemberService memberService;
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@PostMapping("/login.do")
	public String login(@RequestParam("userId") String userId, @RequestParam("password") String password,
			RedirectAttributes redirectAttributes, Model model) {
		try {
			// 로그인 처리
			// 1. memberId 로 member 객체 조회
			// bcryptPasswordEncoder를 이용한 비교
			
			OrgChart member = memberService.selectOne(userId);
			
			log.debug("member={}", member);
			log.debug(bcryptPasswordEncoder.encode(password));

			// 2. member.password와 사용자가 입력한 password 를 비교해서 로그인 처리
			if (member != null && bcryptPasswordEncoder.matches(password, member.getUserPwd())) {
				// 로그인 성공
				model.addAttribute("memberLoggedIn", member);
				//로그인 성공시, 로그에 로그인 기록과 동시에 지각여부 체크
				memberService.loginLog(member.getEmpNo()); 
			} else {
				// 로그인 실패
				redirectAttributes.addFlashAttribute("msg", "입력한 아이디 또는 비밀번호가 일치하지 않습니다");
				return "redirect:/";
			}

		} catch (Exception e) {
			log.error("로그인 처리 예외",e);
			//유저에게 보내는 오류
			throw new MemberException("로그인 처리 도중 오류가 발생했습니다.");
		}
		
		return "/common/welcome";
	}
	
	@GetMapping("/logout.do")
	public String logout(SessionStatus sessionStatus,HttpServletRequest request, @ModelAttribute("memberLoggedIn") Member member) {
		log.debug("[" + member.getUserId() + "] 가 로그아웃 했습니다.");
		
		
		//세션에 request 담아서 넘기기
//		request.getSession().setAttribute("req", request);
		
		
		request.getSession().invalidate();
		
		//session 리셋
//		if (!sessionStatus.isComplete())
//			sessionStatus.setComplete();
		return "redirect:/";
	}
	
	@GetMapping("/empLog.do")
	public String empLog(Model model,@RequestParam("empNo") int empNo) {
		Calendar monthAgo = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		monthAgo.add(Calendar.MONTH, -1); // 한달전 날짜 가져오기
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date monthAgoDate = monthAgo.getTime();
		String srcDateStart = fmt.format(monthAgoDate);
		String srcDateEnd = fmt.format(curDate);
		int bsnsDay = calculateDate(srcDateStart, srcDateEnd);

		log.debug("srcDateStart={}", srcDateStart);
		log.debug("srcDateEnd={}", srcDateEnd);
		
		List<HrMntList> list = null;
		HashMap<String, Object> map = new HashMap<>();
		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);
		map.put("empNo",empNo);

		list = memberService.selectList(map);
//		IOLog log = memberService.getLog(empNo);
		
		
		model.addAttribute("list", list);
//		model.addAttribute("log", log);
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("bsnsDay", bsnsDay);
		
		
		
		return "/member/empLog";
	}
	
	//메인페이지에서 인사관리자/관리자의 근태 페이지 첫 소환
	@GetMapping("/empLogBoard.do")
	public String empLogBoard(Model model) {
		Calendar monthAgo = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		monthAgo.add(Calendar.MONTH, -1); // 한달전 날짜 가져오기
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date monthAgoDate = monthAgo.getTime();
		String srcDateStart = fmt.format(monthAgoDate);
		String srcDateEnd = fmt.format(curDate);
		int bsnsDay = calculateDate(srcDateStart, srcDateEnd);

		log.debug("srcDateStart={}", srcDateStart);
		log.debug("srcDateEnd={}", srcDateEnd);

		List<HrMntList> list = null;
		HashMap<String, Object> map = new HashMap<>();
		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);

		list = memberService.selectList(map);

		model.addAttribute("list", list);
		
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("bsnsDay", bsnsDay);
		
		
		return "member/empLogBoard";
	}

	//근태페이지 내 각종 검색 처리
	@GetMapping("/empLogList.do")
	public String empLogList(@RequestParam("startDate") String srcDateStart, 
			@RequestParam("endDate") String srcDateEnd,
			@RequestParam(value="searchBy",required=false) String searchBy,
			@RequestParam(value="keyword",required=false) String keyword,
			Model model) {

		List<HrMntList> list = null;
		HashMap<String, Object> map = new HashMap<>();
		int bsnsDay = calculateDate(srcDateStart, srcDateEnd);
		log.debug("searchBy = {}", searchBy);
		log.debug("keyword = {}", keyword);
		if(searchBy != "" && keyword != "") {
			map.put("searchBy", searchBy);
			map.put("keyword", keyword);
		}
		
		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);
		
		list = memberService.selectList(map);

		log.debug("list={}", list);
		model.addAttribute("list", list);
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("bsnsDay", bsnsDay);

		return "member/empLogBoard";
	}

	@GetMapping("/orgChart.do")
	public String orgChart(Model model,@RequestParam(value="searchBy",required=false) String searchBy,
			@RequestParam(value="keyword",required=false) String keyword) {
		List<OrgChart> list = null;
		Map<String, String> map = new HashMap<>();
		if(searchBy != "" && keyword != "") {
			map.put("searchBy", searchBy);
			map.put("keyword", keyword);
		}
		
		list = memberService.orgChart(map);
		
		model.addAttribute("list",list);
		return "member/org_chart";
	}
	
	//관리자/인사관리자 용 조직도 세부 페이지
	@GetMapping("/empInfo.do")
	public String empInfo(Model model,@RequestParam(value="empNo",required=false) String empNo) {
		OrgChart emp = null;
		
		emp = memberService.empInfo(empNo);
		if(emp != null) {
			//주민번호에서 생일 추출
			model.addAttribute("birthDay",getBirthDay(emp.getEmpRRNNo()));
		}
		model.addAttribute("emp",emp);
		return "member/emp_info(hr)";
	}
	
	//일반 사원용 조직도 세부페이지
	@GetMapping("/empInfoThird.do")
	public String empInfoThird(Model model, @RequestParam(value="empNo",required=false) String empNo) {
		OrgChart emp = null;
		
		emp = memberService.empInfo(empNo);
		if(emp != null) {
			//주민번호에서 생일 추출
			model.addAttribute("birthDay",getBirthDay(emp.getEmpRRNNo()));
		}
		model.addAttribute("emp",emp);
		
		return "member/emp_info";
	}
	
	
	@PostMapping("/updateEmp.do")
    public String insert(
    					 Model model,
    				     @RequestParam(value="empNo", required=false) String empNo,
    					 @RequestParam(value="empImage_", required=false) MultipartFile empImage,
    					 @RequestParam(value="empEmail", required=false) String empEmail,
    					 @RequestParam(value="empContact", required=false) String empContact,
    					 @RequestParam(value="empAddress", required=false) String empAddress,
    					 @RequestParam(value="auth", required=false) String authority,
    					 @RequestParam(value="status", required=false) String empMsg,
    					 @ModelAttribute("memberLoggedIn") Member memberLoggedIn,
    					 HttpServletRequest request, RedirectAttributes redirectAttributes) {
	
		Map<String, String> map = new HashMap<String, String>();
			
		
    	map.put("empNo", empNo);
    	map.put("authority", authority);
    	map.put("empMsg", empMsg);
		
    	
    	log.debug("empImage = {}",empImage);
    	try {
    		if(empImage != null) { 
    			//파일명 재생성 renamedFileName으로 저장하기
    			String file = empImage.getOriginalFilename();
    			String renamedFile = Utils.getRefile(file);
    			
    			//파일이동
    			String saveDirectory
    			= request.getServletContext()
    			.getRealPath("/resources/upload/empImg");
    			
    			empImage.transferTo(new File(saveDirectory, renamedFile));
    			
    			map.put("empImage", renamedFile);
    		}
    			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
    	
    	if(empEmail != "")
    		map.put("empEmail", empEmail);
    	if(empContact != "")
    		map.put("empContact", empContact);
    	if(empAddress != "")
    		map.put("empAddress", empAddress);

    	int result = memberService.updateEmp(map);
	    		
    	redirectAttributes.addFlashAttribute("msg", result>0?"등록성공!":"등록실패!");
    	
    	Member emp = null;
    	emp = memberService.empInfo(empNo);
		if(emp != null) {
			//주민번호에서 생일 추출
			model.addAttribute("birthDay",getBirthDay(emp.getEmpRRNNo()));
		}
		
		model.addAttribute("emp",emp);
		
		log.debug("memberLoggedIn = {}" , memberLoggedIn);
		if(!memberLoggedIn.getAuthority().equals("N"))
			return "/member/emp_info(hr)";
			
		return "/member/emp_info";
    }
	
	public String getBirthDay(String empRRNNo) {
		char flag = empRRNNo.charAt(6);
		String birthDay = flag == '1'|| flag == '2' ? "19" : "20";
		birthDay = birthDay + empRRNNo.substring(0,2) + "-" + empRRNNo.substring(2,4) + "-" + empRRNNo.substring(4,6);

		return birthDay;
	}
	
	public int calculateDate(String srcDateStart, String srcDateEnd) {
		int workingDays = 0;
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Calendar start = Calendar.getInstance();
			start.setTime(fmt.parse(srcDateStart));
			Calendar end = Calendar.getInstance();
			end.setTime(fmt.parse(srcDateEnd));
			
			while (!start.after(end)) {
				int day = start.get(Calendar.DAY_OF_WEEK);
				if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY))
					workingDays++;
				start.add(Calendar.DATE, 1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return workingDays;

	}
}

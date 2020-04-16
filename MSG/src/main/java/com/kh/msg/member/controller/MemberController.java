package com.kh.msg.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SimpleTimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.board.model.vo.Board;
import com.kh.msg.common.util.Utils;
import com.kh.msg.member.model.exception.MemberException;
import com.kh.msg.member.model.service.MemberService;
import com.kh.msg.member.model.vo.Department;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.IOLog;
import com.kh.msg.member.model.vo.Job;
import com.kh.msg.member.model.vo.LoginImpl;
import com.kh.msg.member.model.vo.LoginVO;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;
import com.kh.msg.member.model.vo.PagingVO;
import com.kh.msg.member.model.vo.WorkTimes;

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

	// 전역변수 접속자확인 시작
	
	public static List<LoginVO> userList = new ArrayList<LoginVO>();
	
	// 접속자 확인 끝

	@PostMapping("/login.do")
	public String login(@RequestParam("userId") String userId, @RequestParam("password") String password,
			RedirectAttributes redirectAttributes, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		try {
			// 로그인 처리
			// 1. memberId 로 member 객체 조회
			// bcryptPasswordEncoder를 이용한 비교

			OrgChart member = memberService.selectOne(userId);

			log.debug("member={}", member);
			log.debug(bcryptPasswordEncoder.encode(password));

			// 접속자확인 시작
			
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");

			HttpSession session = request.getSession();

			String id = request.getParameter("userId");
			String pw = request.getParameter("password");
			
			// 접속자 확인 끝

			// 2. member.password와 사용자가 입력한 password 를 비교해서 로그인 처리
			if (member != null && bcryptPasswordEncoder.matches(password, member.getUserPwd())) {
				// 로그인 성공
				model.addAttribute("memberLoggedIn", member);
				// 로그인 성공시, 로그에 로그인 기록과 동시에 지각여부 체크
				memberService.loginLog(member.getEmpNo());

				// 접속자 확인 시작
				for (int i = 0; i < userList.size(); i++) {
					System.out.println("userList.get(i) : " + userList.get(i));
					if (userList.get(i).getId().equals(userId)) {
						userList.remove(i);
					}
				}
				System.out.println(" session.getId() :" + session.getId());
				LoginImpl loginUser = new LoginImpl(id, pw, session.getId());
				LoginVO loginVO = new LoginVO();

				session.setAttribute("loginUser", loginUser);
				loginVO.setId(id);
				loginVO.setSessionid(session.getId());
				userList.add(loginVO);

			} else {
				// 로그인 실패
				redirectAttributes.addFlashAttribute("msg", "입력한 아이디 또는 비밀번호가 일치하지 않습니다");
				return "redirect:/";
			}

		} catch (Exception e) {
			log.error("로그인 처리 예외", e);
			// 유저에게 보내는 오류
			throw new MemberException("로그인 처리 도중 오류가 발생했습니다.");
		}

		return "redirect:/chat/main.do";
	}

	@GetMapping("/logout.do")
	public String logout(SessionStatus sessionStatus, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("memberLoggedIn") Member member) {
		log.debug("[" + member.getUserId() + "] 가 로그아웃 했습니다.");

		// 세션에 request 담아서 넘기기
//		request.getSession().setAttribute("req", request);

		// request.getSession().invalidate();

		/*
		 * //접속자 확인 시작 String id = member.getUserId();
		 * 
		 * if(id!=null){ List<LoginVO> userList= MemberController.userList;
		 * if(userList!=null && userList.size()>0) {
		 * 
		 * for(int i=0; i<userList.size(); i++) {
		 * 
		 * } } System.out.println("userList size : " +userList.size()); }
		 */
		request.getSession().invalidate();
		// 접속자 확인 끝

		// session 리셋
//		if (!sessionStatus.isComplete())
//			sessionStatus.setComplete();
		return "redirect:/";
	}

	@GetMapping("/empLog.do")
	public String empLog(Model model, @RequestParam("empNo") int empNo,
			@RequestParam(value = "startDate", required = false) String srcDateStart,
			@RequestParam(value = "endDate", required = false) String srcDateEnd,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, PagingVO pvo) 
	{
		Calendar monthAgo = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		monthAgo.add(Calendar.MONTH, -1); // 한달전 날짜 가져오기
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date monthAgoDate = monthAgo.getTime();
		int bsnsDay = 0;
		List<HrMntList> list = null;
		List<WorkTimes> wt = null;
		HashMap<String, Object> map = new HashMap<>();

		log.debug("srcDateStart={}", srcDateStart);
		log.debug("srcDateEnd={}", srcDateEnd);
		if (srcDateStart == null && srcDateEnd == null) {
			srcDateStart = fmt.format(monthAgoDate);
			srcDateEnd = fmt.format(curDate);
		}
		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);
		map.put("empNo", empNo);

		int total = memberService.countOneEmpLog(map);

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "6";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "6";
		}
		pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		bsnsDay = calculateDate(srcDateStart, srcDateEnd);
		

		map.put("start", pvo.getStart());
		map.put("end", pvo.getEnd());

		list = memberService.selectEmpLog(map);
		wt = memberService.getLog(map);

		model.addAttribute("list", list);
		model.addAttribute("wt", wt);
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("bsnsDay", bsnsDay);
		model.addAttribute("paging", pvo);
		model.addAttribute("empNo", empNo);

		return "/member/empLog";
	}

	// 메인페이지에서 인사관리자/관리자의 근태 페이지 첫 소환
	@GetMapping("/empLogBoard.do")
	public String empLogBoard(@RequestParam(value = "startDate", required = false) String srcDateStart,
			@RequestParam(value = "endDate", required = false) String srcDateEnd,
			@RequestParam(value = "searchBy", required = false) String searchBy,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, PagingVO pvo, Model model) {
		Calendar monthAgo = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		monthAgo.add(Calendar.MONTH, -1); // 한달전 날짜 가져오기
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date monthAgoDate = monthAgo.getTime();
		int bsnsDay = calculateDate(srcDateStart, srcDateEnd);
		List<HrMntList> list = null;
		HashMap<String, Object> map = new HashMap<>();

		if (srcDateStart == null && srcDateEnd == null) {
			srcDateStart = fmt.format(monthAgoDate);
			srcDateEnd = fmt.format(curDate);
		}

		if (searchBy != "" && keyword != "") {
			map.put("searchBy", searchBy);
			map.put("keyword", keyword);
		}

		int total = memberService.countEmpLog(map);

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}
		pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		log.debug("srcDateStart={}", srcDateStart);
		log.debug("srcDateEnd={}", srcDateEnd);

		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);
		map.put("start", pvo.getStart());
		map.put("end", pvo.getEnd());

		list = memberService.selectList(map);

		model.addAttribute("list", list);
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("bsnsDay", bsnsDay);
		model.addAttribute("searchBy", searchBy);
		model.addAttribute("keyword", keyword);
		model.addAttribute("paging", pvo);

		return "member/empLogBoard";
	}

	@GetMapping("/orgChart.do")
	public String orgChart(Model model, PagingVO pvo, 
			@RequestParam(value = "searchBy", required = false) String searchBy,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
		List<OrgChart> list = null;
		Map<String, Object> map = new HashMap<>();
		if (searchBy != "" && keyword != "") {
			map.put("searchBy", searchBy);
			map.put("keyword", keyword);
		}
		int total = memberService.countOrgChart(map);

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}
		pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));


		map.put("start", pvo.getStart());
		map.put("end", pvo.getEnd());
		
		list = memberService.orgChart(map);

		model.addAttribute("list", list);
		model.addAttribute("searchBy", searchBy);
		model.addAttribute("keyword", keyword);
		model.addAttribute("paging", pvo);
		
		return "member/org_chart";
	}

	// 관리자/인사관리자 용 조직도 세부 페이지
	@GetMapping("/empInfo.do")
	public String empInfo(Model model, @RequestParam(value = "empNo", required = false) String empNo) {
		OrgChart emp = null;

		emp = memberService.empInfo(empNo);
		if (emp != null) {
			// 주민번호에서 생일 추출
			model.addAttribute("birthDay", getBirthDay(emp.getEmpRRNNo()));
		}
		model.addAttribute("emp", emp);
		return "member/emp_info(hr)";
	}

	// 일반 사원용 조직도 세부페이지
	@GetMapping("/empInfoThird.do")
	public String empInfoThird(Model model, @RequestParam(value = "empNo", required = false) String empNo) {
		OrgChart emp = null;

		emp = memberService.empInfo(empNo);
		if (emp != null) {
			// 주민번호에서 생일 추출
			model.addAttribute("birthDay", getBirthDay(emp.getEmpRRNNo()));
		}
		model.addAttribute("emp", emp);

		return "member/emp_info";
	}

	@PostMapping("/updateEmp.do")
	public String insert(Model model, @RequestParam(value = "empNo", required = false) String empNo,
			@RequestParam(value = "empImage_", required = false) MultipartFile empImage,
			@RequestParam(value = "empEmail", required = false) String empEmail,
			@RequestParam(value = "empContact", required = false) String empContact,
			@RequestParam(value = "empAddress", required = false) String empAddress,
			@RequestParam(value = "auth", required = false) String authority,
			@RequestParam(value = "status", required = false) String empMsg,
			@ModelAttribute("memberLoggedIn") Member memberLoggedIn, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

		Map<String, String> map = new HashMap<String, String>();

		map.put("empNo", empNo);
		map.put("authority", authority);
		map.put("empMsg", empMsg);

		log.debug("empImage = {}", empImage);
		try {
			if (empImage != null) {
				// 파일명 재생성 renamedFileName으로 저장하기
				String file = empImage.getOriginalFilename();
				String renamedFile = Utils.getRefile(file);

				// 파일이동
				String saveDirectory = request.getServletContext().getRealPath("/resources/upload/empImg");

				empImage.transferTo(new File(saveDirectory, renamedFile));

				map.put("empImage", renamedFile);
			}

		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		if (empEmail != "")
			map.put("empEmail", empEmail);
		if (empContact != "")
			map.put("empContact", empContact);
		if (empAddress != "")
			map.put("empAddress", empAddress);

		int result = memberService.updateEmp(map);

		redirectAttributes.addFlashAttribute("msg", result > 0 ? "등록성공!" : "등록실패!");

		Member emp = null;
		emp = memberService.empInfo(empNo);
		if (emp != null) {
			// 주민번호에서 생일 추출
			model.addAttribute("birthDay", getBirthDay(emp.getEmpRRNNo()));
		}

		model.addAttribute("emp", emp);

		log.debug("memberLoggedIn = {}", memberLoggedIn);
		if (!memberLoggedIn.getAuthority().equals("N"))
			return "/member/emp_info(hr)";

		return "/member/emp_info";
	}

	@GetMapping("/ioLog.do")
	public String ioLog(Model model, PagingVO pvo,
			@RequestParam(value = "startDate", required = false) String srcDateStart,
			@RequestParam(value = "endDate", required = false) String srcDateEnd,
			@RequestParam(value = "searchBy", required = false) String searchBy,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage

	) {
		Map<String, Object> map = new HashMap<String, Object>();
		Calendar monthAgo = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		monthAgo.add(Calendar.MONTH, -1); // 한달전 날짜 가져오기
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date monthAgoDate = monthAgo.getTime();

		if (srcDateStart == null && srcDateEnd == null) {
			srcDateStart = fmt.format(monthAgoDate);
			srcDateEnd = fmt.format(curDate);
		}

		if (searchBy != "" && keyword != "") {
			map.put("searchBy", searchBy);
			map.put("keyword", keyword);
		}

		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);

		int total = memberService.countIOLog(map);

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}
		pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		List<IOLog> list = null;

		log.debug("srcDateStart = {}", srcDateStart);
		log.debug("srcDateEnd = {}", srcDateEnd);

		map.put("start", pvo.getStart());
		map.put("end", pvo.getEnd());

		list = memberService.ioLog(map);

		model.addAttribute("list", list);
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("searchBy", searchBy);
		model.addAttribute("keyword", keyword);
		model.addAttribute("paging", pvo);

		return "/member/ioLog";
	}

	@GetMapping("/addEmp.do")
	public String addEmp(Model model) {
		List<Department> depts = null;
		List<Job> jobs = null;

		depts = memberService.getDepts();
		jobs = memberService.getJobs();

		model.addAttribute("depts", depts);
		model.addAttribute("jobs", jobs);

		return "/member/addEmpForm";
	}

	@PostMapping("/addEmpFormSubmit.do")
	public String submitNewEmp(Model model, @RequestParam(value = "empImage_", required = false) MultipartFile empImage,
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "userPwd", required = false) String userPwd,
			@RequestParam(value = "empName", required = false) String empName,
			@RequestParam(value = "empRRNNo", required = false) String empRRNNo,
			@RequestParam(value = "empEmail", required = false) String empEmail,
			@RequestParam(value = "empAddress", required = false) String empAddress,
			@RequestParam(value = "deptCd", required = false) String deptCd,
			@RequestParam(value = "jobCd", required = false) String jobCd,
			@RequestParam(value = "isManager", required = false) String isManager,
			@RequestParam(value = "authority", required = false) String authority, HttpServletRequest request,
			RedirectAttributes redirectAttributes, Member member) {
		try {
			// 파일명 재생성 renamedFileName으로 저장하기
			String file = empImage.getOriginalFilename();
			String renamedFile = Utils.getRefile(file);

			// 파일이동
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/empImg");

			empImage.transferTo(new File(saveDirectory, renamedFile));
			log.debug("renamedFile  = {}", renamedFile);
			member.setEmpImage(renamedFile);
			member.setEmpName(empName);
			member.setUserId(userId);
			member.setUserPwd(bcryptPasswordEncoder.encode(userPwd));
			member.setEmpEmail(empEmail);
			member.setEmpAddress(empAddress);
			member.setEmpRRNNo(empRRNNo);
			member.setDeptCd(deptCd);
			member.setJobCd(jobCd);
			member.setAuthority(authority);
			member.setIsManager(isManager);

		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		int result = memberService.submitNewEmp(member);

		return "member/org_chart";
	}

	/*
	 * @GetMapping("/login.do") public ModelAndView login(ModelAndView modelAndView,
	 * Member member){
	 * 
	 * ModelAndView mav = new ModelAndView();
	 * 
	 * List<Board> boardList = memberService.mainBoardList(member);
	 * log.debug("boardList="+boardList);
	 * 
	 * mav.addObject("boardList",boardList); mav.setViewName("/common/welcome");
	 * return mav; }
	 */

	public String getBirthDay(String empRRNNo) {
		char flag = empRRNNo.charAt(6);
		String birthDay = flag == '1' || flag == '2' ? "19" : "20";
		birthDay = birthDay + empRRNNo.substring(0, 2) + "-" + empRRNNo.substring(2, 4) + "-"
				+ empRRNNo.substring(4, 6);

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

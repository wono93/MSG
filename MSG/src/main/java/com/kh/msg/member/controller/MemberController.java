package com.kh.msg.member.controller;

import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SimpleTimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.msg.member.model.exception.MemberException;
import com.kh.msg.member.model.service.MemberService;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;

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
			Member member = memberService.selectOne(userId);
			log.debug("member={}", member);
			log.debug(bcryptPasswordEncoder.encode(password));

			// 2. member.password와 사용자가 입력한 password 를 비교해서 로그인 처리
			if (member != null && bcryptPasswordEncoder.matches(password, member.getUserPwd())) {
				// 로그인 성공
				model.addAttribute("memberLoggedIn", member);
			} else {
				// 로그인 실패
				redirectAttributes.addFlashAttribute("msg", "입력한 아이디 또는 비밀번호가 일치하지 않습니다");
			}

		} catch (Exception e) {
			log.error("로그인 처리 예외", e);
			// 유저에게 보내는 오류
			throw new MemberException("로그인 처리 도중 오류가 발생했습니다.");
		}

		return "common/welcome";

	}

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
		Map<String, String> map = new HashMap<>();
		map.put("srcDateStart", srcDateStart);
		map.put("srcDateEnd", srcDateEnd);

		list = memberService.selectList(map);

		model.addAttribute("list", list);
		model.addAttribute("srcDateStart", srcDateStart);
		model.addAttribute("srcDateEnd", srcDateEnd);
		model.addAttribute("bsnsDay", bsnsDay);
		
		
		return "member/empLogBoard";
	}

	@GetMapping("/empLogList.do")
	public String empLogList(@RequestParam("startDate") String srcDateStart, @RequestParam("endDate") String srcDateEnd,
			@RequestParam("bsnsDay") int bsnsDay, Model model) {

		List<HrMntList> list = null;
		Map<String, String> map = new HashMap<>();
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

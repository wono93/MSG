package com.kh.msg.common.listener;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.msg.member.controller.MemberController;
import com.kh.msg.member.model.service.MemberService;
import com.kh.msg.member.model.vo.LoginImpl;
import com.kh.msg.member.model.vo.LoginVO;
import com.kh.msg.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Component
public class MsgSessionListener implements HttpSessionListener {
    
//	@Autowired
//	@Qualifier("memberServiceImpl")
	MemberService memberService;
	
	
	
//	public MsgSessionListener() {
//		super();
//	}


//	@Autowired
//	public MsgSessionListener(MemberService memberService) {
//		log.debug("MsgSessionListener -> " + memberService);
//		this.memberService = memberService;
//		
//	}
	

	@Override
	public void sessionCreated(HttpSessionEvent se) {
//		se.getSession().setMaxInactiveInterval(30); 
		se.getSession().setMaxInactiveInterval(30*60); 
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		
		
		Member member = (Member) session.getAttribute("memberLoggedIn");
		log.debug("세션이 종료되었습니다 = {}", member.getEmpName());
		log.debug("로그아웃 = ============"+se.getSession().getId());
		
		
		List<LoginVO> userList= MemberController.userList;
		//접소자 목록에서 제거
        
        for(int i=0; i<userList.size(); i++) {
            if(userList.get(i).getId().equals(member.getUserId())){
                userList.remove(i);
            }
        }
		
		
//		ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
//		context = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
//		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

		
		//DispatcherServlet이 관리하는 빈 context가져오기: HttpServletRequest가 필요.
		//dispatch단에서 request session에 넘겨서 받아오는 방식
		
//		HttpServletRequest req = (HttpServletRequest)session.getAttribute("req");
//		WebApplicationContext context = RequestContextUtils.findWebApplicationContext(req);

		
		//이렇게 해주면 dispatcher 단에서 request를 session에 넘겨서 받아오지 않아도 됨
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext context = RequestContextUtils.findWebApplicationContext(req);
	
		//관리하는 모든 빈의 이름 조회
//		log.debug(Arrays.toString(context.getBeanDefinitionNames()));
		
		
//		
		
         
		memberService = context.getBean(MemberService.class);
		log.debug("memberService={}, {}", memberService==null, memberService);
		
		//로그아웃 성공시, 로그에 로그아웃 기록
		memberService.logoutLog(member.getEmpNo()); 
	}

}

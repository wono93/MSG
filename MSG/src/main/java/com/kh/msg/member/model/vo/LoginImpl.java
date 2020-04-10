package com.kh.msg.member.model.vo;

import java.util.List;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.msg.member.controller.MemberController;
import com.kh.msg.member.model.service.MemberService;
 
@WebListener
public class LoginImpl  implements HttpSessionListener  {
 
    private String id;
    String pw;
    String sessionid;
    private static int loginUserCount=0;
    @Autowired
    MemberService memberService;
         
     
    public LoginImpl() {
     
    }
     
    public LoginImpl(String id, String pw, String sessionid) {
        this.setId(id);
        this.pw=pw; 
        this.sessionid=sessionid;
    }
     
     
     
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("세션 생성");
        setLoginUserCount(getLoginUserCount() + 1);
         
        System.out.printf("생성된 SESSIONID %s \n",  se.getSession().getId());
        System.out.printf("로그인된 사용자 수 : %d \n", getLoginUserCount());
    }
     
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("세션 소멸");        
        System.out.printf("세션 소멸된 아이디 SESSIONID %s \n",  se.getSession().getId());
         
        List<LoginVO> userList= MemberController.userList;
         
        //접소자 목록에서 제거
        if(userList!=null && userList.size()>0) {
            for(int i=0; i<userList.size(); i++) {
                if(userList.get(i)!=null || userList.get(i).getSessionid().equals(se.getSession().getId())){
                    userList.remove(i); 
                    LoginImpl.setLoginUserCount(LoginImpl.getLoginUserCount() - 1);             
                }           
            }
        }
         
        System.out.printf("로그인된 사용자 수 : %d \n", getLoginUserCount());
    }

	public static int getLoginUserCount() {
		return loginUserCount;
	}

	public static void setLoginUserCount(int loginUserCount) {
		LoginImpl.loginUserCount = loginUserCount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
 
}
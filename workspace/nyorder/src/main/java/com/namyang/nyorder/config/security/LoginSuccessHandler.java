package com.namyang.nyorder.config.security;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.namyang.nyorder.comm.service.LoginService;
import com.namyang.nyorder.comm.service.MenuService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.MenuVO;

@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	MenuService menuService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		//인증된 사용자의 정보를 추출
		AccountVO acount = (AccountVO)authentication.getPrincipal();
		System.out.println("acount =>"+acount.getTmpPwdYn()+", ::" + acount.getAgenSeq() + ", ::" + acount.getEmplSeq());
		
		String url="/comm/main.do";
		
		if("Y".equals(acount.getTmpPwdYn())){
			url="/changePassword.do";
		}		
		

		
		// 접속 기기 셋팅
		String userAgent = request.getHeader("User-Agent").toUpperCase();
		if(userAgent.indexOf("MOBILE") > -1) {
			if(userAgent.indexOf("PHONE") == -1) {
				acount.setEmplMch("MOBILE");
			}else{
				acount.setEmplMch("TABLET");
			}
		}else{
			acount.setEmplMch("PC");
		}
		
		// 접속 IP 셋팅
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("WL-Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("HTTP_CLIENT_IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("X-Real-IP"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("X-RealIP"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getRemoteAddr(); 
		}
		
		acount.setEmplIp(ip);
		String failCnt = null;
		try{
			failCnt = request.getSession().getAttribute("failCnt").toString() ;
			acount.setFailCnt(Integer.parseInt(failCnt));
		}catch (Exception e) {
			acount.setFailCnt(0);
		}
	
		try {
			loginService.insertLoginHis(acount);
		} catch (Exception e) {
		}
		
		MenuVO menuParam = new MenuVO();
		menuParam.setAgenSeq(acount.getAgenSeq());
		menuParam.setEmplSeq(acount.getEmplSeq());
		
		acount.setMenuVOList(menuService.selectLeftMenuList(menuParam));
		
		acount.setBkmkMenuList(menuService.selectLeftBkmkMenuList(menuParam));
		
		request.getSession().setAttribute("userInfo", acount);
		request.getSession().setAttribute("lastLogin", new Date());	// 최근 접속 일시
		
		//request.getSession().setAttribute("agenSeq", acount.getAgenSeq());
		//request.getSession().setAttribute("emplSeq", acount.getEmplSeq());
				
		response.sendRedirect(url);
		
	}
		

}

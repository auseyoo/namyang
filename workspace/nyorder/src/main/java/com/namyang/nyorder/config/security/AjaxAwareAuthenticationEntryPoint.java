package com.namyang.nyorder.config.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.log.LogMessage;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

public class AjaxAwareAuthenticationEntryPoint  extends LoginUrlAuthenticationEntryPoint{
	
	private static final Log logger = LogFactory.getLog(AjaxAwareAuthenticationEntryPoint.class);
	private String ajaxLogoutUrl = "/sessionDestroyedLogout.do";
	
    public AjaxAwareAuthenticationEntryPoint(String loginUrl) {
        super(loginUrl);
    }

    @Override
    public void commence(
        HttpServletRequest request,
        HttpServletResponse response,
        AuthenticationException authException)
        throws IOException, ServletException {
    	
        String ajaxHeader = ((HttpServletRequest) request).getHeader("X-Requested-With");        
        boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);
        
        //System.out.println(" ############################  commence  isAjax :: " + isAjax);
        
        if (isAjax) {
            //response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ajax REquest Denied (Session Expired)");
            
            String loginForm = ajaxLogoutUrl;
    		logger.debug(LogMessage.format("Server side forward to: %s", loginForm));
    		RequestDispatcher dispatcher = request.getRequestDispatcher(loginForm);
    		dispatcher.forward(request, response);

        } else {
            super.commence(request, response, authException);
        }
        
    }
}

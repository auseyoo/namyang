package com.namyang.nyorder.config;

import javax.servlet.ServletContext;

import org.springframework.context.annotation.Bean;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.namyang.nyorder.config.web.GlobalErrorHandler;

public class BeansUtil {
	
	public static GlobalErrorHandler getBean(ServletContext servletContext, Class classNm) {
		
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		

		return (GlobalErrorHandler) wac.getBean(classNm);		
	}

}

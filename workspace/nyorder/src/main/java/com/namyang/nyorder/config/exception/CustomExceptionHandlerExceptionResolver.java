package com.namyang.nyorder.config.exception;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class CustomExceptionHandlerExceptionResolver implements HandlerExceptionResolver { 
	
	@Override 
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) { 
		// HystrixRuntimeException인지 체크 
		if (!(ex instanceof Exception)) { 
			return null; 
		} 
		
		Throwable cause = ((Exception) ex).getCause(); 
		
		// cause 변수가 A Exception인지 체크 
		if (!(cause instanceof Exception)) { 
			return null; 
		} 
		
		Exception targetException = (Exception) cause; 
		
		// 적당히 반환할 값 처리 (Map이 아니어도 상관없음) 
		Map<String, String> resultMap = new HashMap<>(); 
		resultMap.put("result", "에러 결과 처리"); 
		ModelAndView modelAndView = new ModelAndView("error/404", resultMap); 
		modelAndView.setStatus(HttpStatus.BAD_REQUEST); 
		return modelAndView; 
	} 
	
}



package com.namyang.nyorder.config.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice("com.namyang.nyorder")
public class CustomControllerAdvice {

	@ExceptionHandler
	public String errorHandler(CustomAjaxException e, HttpServletRequest request, HttpServletResponse response) {
		
	    response.setStatus(399);
	    response.setHeader("Access-Control-Allow-Credentials", "true");
	    response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
	    response.setHeader("Connection", "close");
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    		
		return e.getMessage();
	}
	
	
}

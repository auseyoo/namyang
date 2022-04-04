package com.namyang.nyorder.config.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

@Component
public class GlobalErrorHandlerImpl implements GlobalErrorHandler{

	public void handleError(int responseCode, HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		System.out.println("GlobalErrorHandlerImpl  handleError  :: " + responseCode );
		
		response.sendRedirect("/errorPage.do");
		
	}
	
	public void addHandler(int responseCode, String handlerDescription) {
		
	}
}

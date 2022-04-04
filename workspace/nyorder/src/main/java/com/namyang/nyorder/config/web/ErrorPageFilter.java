package com.namyang.nyorder.config.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.namyang.nyorder.config.BeansUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter(filterName = "ErrorPageFilter", urlPatterns = "/*")
public class ErrorPageFilter implements Filter { 
	 
	private GlobalErrorHandler globalErrorHandler;
	
	@Override 
	public void init(FilterConfig filterConfig) throws ServletException { 
		
		globalErrorHandler = BeansUtil.getBean(filterConfig.getServletContext(), GlobalErrorHandler.class);
		log.debug("Filter Start Method checking"); 
		Filter.super.init(filterConfig); 
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request; 
		HttpServletResponse res = (HttpServletResponse) response;
		
	    chain.doFilter(request, new ErrorPageHttpServletResponseWrapper(req, res, globalErrorHandler));
	}
	
	
	/**
	@Override 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException { 
		HttpServletRequest req = (HttpServletRequest) request; 
		HttpServletResponse res = (HttpServletResponse) response;
		log.debug("Filter Request Method: {}", req.getMethod()); 
		PrintWriter out = response.getWriter();
				
	    CharResponseWrapper responseWrapper = new CharResponseWrapper ((HttpServletResponse) response);
	    
	    //response.setCharacterEncoding("UTF-8");
	    
	    System.out.println("BEFORE filter, original response: "  + responseWrapper.getStatus());
	    
	    System.out.println("BEFORE filter, original response: "  + responseWrapper.getStatus());

	    try {
	    	chain.doFilter(request, response);
	    }catch(Exception e) {
	    	
	    	e.printStackTrace();
	    	res.sendRedirect("/errorPage.do");
	    	
	    }
	    
	    
	    System.out.println("AFTER filter, original response: "  + responseWrapper.getStatus());
	    
	    if(responseWrapper.getStatus() != 200) {
	    	
	    	//res.sendRedirect("/errorPage.do");
	    	
	    	out.write("<script>location.href='/errorPage.do';</script>");
	    }
	    
	    //String servletResponse = new String(responseWrapper.toString());	    
	    //System.out.println(" servletResponse is "+servletResponse);
	    //out.write(servletResponse + " filtered"); // Here you can change the response		
		//chain.doFilter(request, response);
		
	} 
	*/
	
	@Override 
	public void destroy() { 
		log.debug("Filter End Method checking"); 
		Filter.super.destroy(); 
	}


    

}

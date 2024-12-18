package com.namyang.nyorder.config.exception;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.Ordered;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class HandlerExceptionResolverComposite implements HandlerExceptionResolver, Ordered { 
	
	@Nullable 
	private List<HandlerExceptionResolver> resolvers; 
	private int order = Ordered.LOWEST_PRECEDENCE; 
	
	/** 
	 * Set the list of exception resolvers to delegate to. 
	 */ 
	
	public void setExceptionResolvers(List<HandlerExceptionResolver> exceptionResolvers) { 
		this.resolvers = exceptionResolvers; 
	} 
	
	/** * Return the list of exception resolvers to delegate to. */ 
	
	public List<HandlerExceptionResolver> getExceptionResolvers() { 
		
		return (this.resolvers != null ? Collections.unmodifiableList(this.resolvers) : Collections.emptyList()); 
	} 
	
	public void setOrder(int order) { 
		this.order = order; 
	} 
	
	@Override 
	public int getOrder() { 
		return this.order; 
	} 
	
	/** * Resolve the exception by iterating over the list of configured exception resolvers. 
	 * <p>The first one to return a {@link ModelAndView} wins. Otherwise {@code null} is returned. 
	 */ 
	
	@Override 
	@Nullable 
	public ModelAndView resolveException( HttpServletRequest request, HttpServletResponse response, @Nullable Object handler, Exception ex) { 
		
		if (this.resolvers != null) { 
			for (HandlerExceptionResolver handlerExceptionResolver : this.resolvers) { 
				
				ModelAndView mav = handlerExceptionResolver.resolveException(request, response, handler, ex); 
				
				if (mav != null) { 
					return mav; 
				} 
			} 
		} 
		return null; 
	} 
	
}


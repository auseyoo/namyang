package com.namyang.nyorder.config;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class SessionListener implements HttpSessionListener {
	
	private int sessionTimeout = 30*60; 
	
 
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        //System.out.println("==== Session is created ====");
        event.getSession().setMaxInactiveInterval(sessionTimeout);
    }
 
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        //System.out.println("==== Session is destroyed ====");
    }


}

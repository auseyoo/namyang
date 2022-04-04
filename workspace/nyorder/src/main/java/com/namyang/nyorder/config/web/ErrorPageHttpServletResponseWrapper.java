package com.namyang.nyorder.config.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import com.namyang.nyorder.config.BeansUtil;

public class ErrorPageHttpServletResponseWrapper  extends HttpServletResponseWrapper {
    HttpServletRequest request;
    HttpServletResponse response;
    
    GlobalErrorHandler globalErrorHandler;

    public ErrorPageHttpServletResponseWrapper(HttpServletRequest request, HttpServletResponse response, GlobalErrorHandler globalErrorHandler) {
    	
        super(response);
        this.request = request;
        this.response = response;
        this.globalErrorHandler = globalErrorHandler;
    }

    @Override
    public void sendError(int sc) throws IOException {
    	//System.out.println("sendError sc :: " + sc );
        globalErrorHandler.handleError(sc, request, response);
    }

    @Override
    public void sendError(int sc, String msg) throws IOException {
    	//System.out.println("sendError sc :: " + sc + ", :: " + msg);
        sendError(sc);
    }
}


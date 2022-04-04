package com.namyang.nyorder.config.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface GlobalErrorHandler {

	void handleError(int responseCode, HttpServletRequest request, HttpServletResponse response) throws IOException;
	void addHandler(int responseCode, String handlerDescription);
}

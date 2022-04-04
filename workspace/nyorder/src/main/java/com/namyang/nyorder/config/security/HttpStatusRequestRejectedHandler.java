package com.namyang.nyorder.config.security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.log.LogMessage;
import org.springframework.security.web.firewall.RequestRejectedException;
import org.springframework.security.web.firewall.RequestRejectedHandler;

import lombok.extern.slf4j.Slf4j;

public class HttpStatusRequestRejectedHandler implements RequestRejectedHandler {

	private final int httpError;
	
	private static final Log logger = LogFactory.getLog(HttpStatusRequestRejectedHandler.class);

	/**
	 * Constructs an instance which uses {@code 400} as response code.
	 */
	public HttpStatusRequestRejectedHandler() {
		this.httpError = HttpServletResponse.SC_BAD_REQUEST;
	}

	/**
	 * Constructs an instance which uses a configurable http code as response.
	 * @param httpError http status code to use
	 */
	public HttpStatusRequestRejectedHandler(int httpError) {
		this.httpError = httpError;
	}

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			RequestRejectedException requestRejectedException) throws IOException {
		
		logger.debug(LogMessage.format("Rejecting request due to: %s", requestRejectedException.getMessage()),
				requestRejectedException);
		
		System.out.println("Rejecting request :: " + request.getRequestURI() );
		
		System.out.println("Rejecting request Exception.getMessage() :: " + requestRejectedException.getMessage() );
		
		response.sendError(this.httpError);
	}

}

package com.namyang.config;

import javax.batch.api.listener.JobListener;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
//@Component
public class JobsListener implements JobListener {
	 
	public void jobToBeExecuted(JobExecutionContext context) {
		JobKey jobKey = context.getJobDetail().getKey();
	    log.info("jobToBeExecuted :: jobKey : {}", jobKey);
	}
	 
	public void jobExecutionVetoed(JobExecutionContext context) {
		JobKey jobKey = context.getJobDetail().getKey();
	    log.info("jobExecutionVetoed :: jobKey : {}", jobKey);
	}
	 
	public void jobWasExecuted(JobExecutionContext context, JobExecutionException jobException) {
		JobKey jobKey = context.getJobDetail().getKey();
	    log.info("jobWasExecuted :: jobKey : {}", jobKey);
	}

	@Override
	public void beforeJob() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterJob() throws Exception {
		// TODO Auto-generated method stub
		
	}
}



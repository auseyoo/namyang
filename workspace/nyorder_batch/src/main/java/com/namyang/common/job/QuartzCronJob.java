package com.namyang.common.job;

import java.time.LocalDateTime;
import java.util.HashMap;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.namyang.common.service.TestService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
//@Component
public class QuartzCronJob  extends QuartzJobBean {
	
	@Autowired
	private TestService testService;
	
    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        log.info("QuartzCronJob Job Executed : {}", LocalDateTime.now().toString());
        HashMap<String, Object> param = new HashMap<String, Object>();
        int cnt = 0;
        try {
        	testService.insertFileList(param);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        log.info("Quartz Job Executed  cnt : " + cnt);
        
        

    }

}


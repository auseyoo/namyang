package com.namyang.nyorder.sample.job;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.namyang.nyorder.sample.service.SampleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SampleCronJob extends QuartzJobBean {
	
	@Autowired
	private SampleService sampleService;
	
    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        log.info("###### SampleCronJob3 Job Executed : {}", LocalDateTime.now().toString());
        HashMap<String, Object> param = new HashMap<String, Object>();
        int cnt = 0;
        try {
        	List<HashMap> resultList = sampleService.selectSampleList(param);
        	
        	for(HashMap<String, Object> hm : resultList) {
        		if(hm != null) {
        			log.info("SampleCronJob Job resultList  hm : " + hm.toString());
        		}        		
        	}
        	
        	sampleService.insSample(resultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        log.info("SampleCronJob Job Executed  cnt : " + cnt);        
        

    }

}

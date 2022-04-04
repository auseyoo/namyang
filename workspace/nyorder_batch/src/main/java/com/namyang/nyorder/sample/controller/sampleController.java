package com.namyang.nyorder.sample.controller;

import javax.annotation.PostConstruct;

import org.quartz.SchedulerException;
import org.springframework.stereotype.Component;
import com.namyang.config.BatchController;
import com.namyang.nyorder.sample.job.SampleCronJob;


@Component
public class sampleController {

	
	private BatchController batchController;
	
	public sampleController(BatchController batchController) {
		
		this.batchController = batchController;		
	}
	
    @PostConstruct
    public void quartzJobInit() {
        try {
        	batchController.addCronJob(SampleCronJob.class, "SampleCronJob", "SampleCronJob 잡",null , "1 * * * * ?");
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
}

package com.namyang.common.service;

import javax.annotation.PostConstruct;

import org.quartz.SchedulerException;
import org.springframework.stereotype.Component;

import com.namyang.common.job.QuartzCronJob;
import com.namyang.common.job.QuartzJob;
import com.namyang.config.BatchController;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
//@Component
public class BatchService {
	
	private final BatchController batchController;
	
	//private BatchController batchController;
	
    //@PostConstruct
    public void quartzJobInit() {
        try {
        	batchController.addSimpleJob(QuartzJob.class, "QuartzJob", "Quartz 잡",null , 100);
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
    
//    @PostConstruct
//    public void cronJobinit() {
//        try {
//        	batchController.addCronJob(QuartzCronJob.class, "QuartzCronJob", "QuartzCronJob 잡",null , "1 * * * * ?");
//        } catch (SchedulerException e) {
//            e.printStackTrace();
//        }
//    }

}

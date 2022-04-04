package com.namyang.config;

import static org.quartz.JobBuilder.newJob;

import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.namyang.common.job.TrReReqJob;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BatchController {

//	public BatchController() {		
//		try {
//			if(scheduler!=null) {
//				scheduler.clear();
//				List<String> jobs = scheduler.getJobGroupNames();				
//				for(String job : jobs) {					
//					log.debug("BatchController   job :: " + job);
//				}
//			}
//			
//		} catch (SchedulerException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	@Autowired
    private Scheduler scheduler;    

    public void addSimpleJob(Class job, String name, String desc, Map params, Integer seconds) throws SchedulerException {
    	
        JobDetail jobDetail = buildJobDetail(job, name, desc, params);
        
        log.debug("addSimpleJob   jobDetail :: " + jobDetail.getKey());

        if (scheduler.checkExists(jobDetail.getKey())) {
            scheduler.deleteJob(jobDetail.getKey());
        }

        scheduler.scheduleJob(
                jobDetail,
                buildSimpleJobTrigger(seconds)
        );
        
        if(scheduler!=null) {
			//scheduler.clear();
			List<String> jobs = scheduler.getJobGroupNames();				
			for(String strJob : jobs) {					
				log.debug("addSimpleJob   job :: " + strJob);
			}
		}
        
        
    }

    public void addCronJob(Class job, String name, String desc, Map params, String expression) throws SchedulerException {
    	
        JobDetail jobDetail = buildJobDetail(job, name, desc, params);
        
        log.debug("addCronJob   jobDetail :: " + jobDetail.getKey());

        if (scheduler.checkExists(jobDetail.getKey())) {
            scheduler.deleteJob(jobDetail.getKey());
        }

        scheduler.scheduleJob(
                jobDetail,
                buildCronJobTrigger(expression)
        );
        
        if(scheduler!=null) {
			//scheduler.clear();
			List<String> jobs = scheduler.getJobGroupNames();				
			for(String strJob : jobs) {					
				log.debug("addCronJob   job :: " + strJob);
			}
		}
    }

    private JobDetail buildJobDetail(Class job, String name, String desc, Map params) {
    	
        JobDataMap jobDataMap = new JobDataMap();
        if(params != null) jobDataMap.putAll(params);
        return JobBuilder
                .newJob(job)
                .withIdentity(name)
                .withDescription(desc)
                .usingJobData(jobDataMap)
                .build();
    }

    /**
     * Cron Job Trigger
     */
    // *  *   *   *   *   *     *
    // 초  분  시   일   월  요일  년도(생략가능)
    private Trigger buildCronJobTrigger(String scheduleExp) {
    	
    	log.debug("buildCronJobTrigger scheduleExp ::" + scheduleExp + ","  );
    	
        return TriggerBuilder.newTrigger()
                .withSchedule(CronScheduleBuilder.cronSchedule(scheduleExp))
                .build();
    }

    /**
     * Simple Job Trigger
     */
    private Trigger buildSimpleJobTrigger(Integer seconds) {
        return TriggerBuilder.newTrigger()
                .withSchedule(SimpleScheduleBuilder
                        .simpleSchedule()
                        .repeatForever()
                        .withIntervalInSeconds(seconds))
                .build();
    }

    public static String buildCronExpression(LocalDateTime time) {
        LocalDateTime fireTime = time.plusSeconds(10);
        // 0 0 0 15 FEB ? 2021
        return String.format("%d %d %d %d %s ? %d"
        		, fireTime.getSecond()
        		, fireTime.getMinute()
        		, fireTime.getHour()
        		, fireTime.getDayOfMonth()
        		, fireTime.getMonth().getDisplayName(TextStyle.SHORT, Locale.ENGLISH).toUpperCase()
        		, fireTime.getYear());
    }

}

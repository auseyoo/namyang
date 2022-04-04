package com.namyang.nyorder.prdbndchg.job;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.namyang.nyorder.prdbndchg.service.StdPrdBndChgService;
import com.namyang.nyorder.sample.job.SampleCronJob;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class StdPrdBndChgCronJob extends QuartzJobBean {

	@Autowired
	private StdPrdBndChgService stdPrdBndChgService;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		try {
			log.debug("===================================================");
			log.debug("배치 시작");
			stdPrdBndChgService.update();
			log.debug("===================================================");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

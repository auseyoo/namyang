package com.namyang.common.job;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.batch.operations.JobRestartException;
import javax.batch.runtime.JobExecution;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameter;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.namyang.common.tasklet.MdbMigTasklet;

import lombok.extern.slf4j.Slf4j;

@Slf4j 
@EnableBatchProcessing
@EnableScheduling
@Configuration 
public class MigBatchJob { 
	
	@Autowired
	private final JobBuilderFactory jobBuilderFactory;
	
	@Autowired
	private final StepBuilderFactory stepBuilderFactory;
	
	@Autowired
	private final MdbMigTasklet mdbMigTasklet; 
	
	@Autowired
	private JobLauncher jobLauncher;
	
	public MigBatchJob(JobBuilderFactory jobBuilderFactory, StepBuilderFactory stepBuilderFactory, MdbMigTasklet mdbMigTasklet) { 
		this.jobBuilderFactory = jobBuilderFactory; 
		this.stepBuilderFactory = stepBuilderFactory; 
		this.mdbMigTasklet = mdbMigTasklet; 
	} 
		
	//@Scheduled(cron = "0 20 18 * * *")
	//@Scheduled(cron = "1 * * * * *")
	public void jobSchduled() throws JobParametersInvalidException, JobExecutionAlreadyRunningException,
			JobRestartException, JobInstanceAlreadyCompleteException {

		Map<String, JobParameter> jobParametersMap = new HashMap<>();
		
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
		Date time = new Date();

		String time1 = format1.format(time);

		jobParametersMap.put("date",new JobParameter(time1));

		JobParameters parameters = new JobParameters(jobParametersMap);
		
		Job job = migrationBatchJob();

		JobExecution jobExecution = null;
		try {
			jobLauncher.run(job, parameters);
		} catch (JobExecutionAlreadyRunningException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (org.springframework.batch.core.repository.JobRestartException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JobInstanceAlreadyCompleteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JobParametersInvalidException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();			
		}		
	}	
	
	@Bean 
	public Job migrationBatchJob() { 
		return jobBuilderFactory.get("migBatchJob")  
				.flow(migStep())  
				.end() 
				.build(); 
	} 
	
	@Bean 
	public Step migStep() { 
		return stepBuilderFactory.get("migStep")  
				.tasklet(mdbMigTasklet)  
				.build(); 
	}
}



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

import com.namyang.common.tasklet.CreateFileLinkTasklet;
import com.namyang.common.tasklet.FileInsertProcTasklet;
import com.namyang.common.tasklet.FileReadTasklet;
import com.namyang.common.tasklet.MdbMigTasklet;

import lombok.extern.slf4j.Slf4j;

@Slf4j 
//@EnableBatchProcessing
//@EnableScheduling
//@Configuration 
public class MigBatchTestJob {

	@Autowired
	private final JobBuilderFactory jobBuilderFactory;
	
	@Autowired
	private final StepBuilderFactory stepBuilderFactory;
	
	@Autowired
	private FileReadTasklet fileReadTasklet;
	
	@Autowired
	private FileInsertProcTasklet fileInsertProcTasklet;
	
	@Autowired
	private CreateFileLinkTasklet createFileLinkTasklet; 
		
	@Autowired
	private JobLauncher jobLauncher;
	
	
	public MigBatchTestJob(JobBuilderFactory jobBuilderFactory, StepBuilderFactory stepBuilderFactory) { 
		this.jobBuilderFactory = jobBuilderFactory; 
		this.stepBuilderFactory = stepBuilderFactory; 
		
	} 
		
	@Scheduled(fixedDelay = 2000000000)
	public void jobSchduled() throws JobParametersInvalidException, JobExecutionAlreadyRunningException,
			JobRestartException, JobInstanceAlreadyCompleteException {

		Map<String, JobParameter> jobParametersMap = new HashMap<>();
		
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
		Date time = new Date();

		String time1 = format1.format(time);

		jobParametersMap.put("time", new JobParameter(time1));

		JobParameters parameters = new JobParameters(jobParametersMap);
		
		Job job = helloWorldJob();

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
	public Job helloWorldJob() { 
		return jobBuilderFactory.get("FileInsertJob")  
				.flow(fileListInsertStep())  
				.next(execProcStep())
				.end() 
				.build(); 
	} 
	
	@Bean 
	public Step fileListInsertStep() { 
		return stepBuilderFactory.get("FileInsertStep")  
				.tasklet(fileReadTasklet)  
				.build(); 
	}
	
	@Bean 
	public Step execProcStep() { 
		return stepBuilderFactory.get("FileInsertStep2")  
				.tasklet(createFileLinkTasklet)  
				.build(); 
	}
}
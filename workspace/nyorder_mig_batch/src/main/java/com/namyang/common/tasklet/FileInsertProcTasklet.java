package com.namyang.common.tasklet;

import java.io.File;
import java.util.HashMap;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.namyang.common.service.FileServiceImpl;

@Component 
@StepScope 
public class FileInsertProcTasklet implements Tasklet { 
	
	@Autowired
	private FileServiceImpl fileService;

	@Override 
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception { 
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		System.out.println("FileInsertProcTasklet start#####################"); 
		
		paramMap.put("PARAM1", "test");
		paramMap.put("RESULT", "");
		try {
			fileService.fileInsertProc(paramMap);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("FileInsertProcTasklet end!   RESULT :: " + paramMap.get("RESULT")); 
		
		return RepeatStatus.FINISHED;
	}
}



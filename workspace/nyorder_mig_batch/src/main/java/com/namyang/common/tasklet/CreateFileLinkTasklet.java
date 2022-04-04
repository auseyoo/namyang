package com.namyang.common.tasklet;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.namyang.common.service.FileServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j 
@Component 
@StepScope 
public class CreateFileLinkTasklet implements Tasklet { 
	
	
	@Autowired
	private FileServiceImpl fileService;

	@Override 
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception { 
		
		log.info("CreateFileLinkTasklet start =====================================================================");
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		List<HashMap> list = fileService.selectFileList(paramMap);
				
		for(HashMap<String, Object> map : list) {
			
			fileService.createFileLink(map);
			Thread.sleep(1500);
			fileService.fileInsertProc(map);
			fileService.dropFileLink(map);
			
		}
		
		log.info("CreateFileLinkTasklet end ====================================================================="); 
		return RepeatStatus.FINISHED;
	}
}

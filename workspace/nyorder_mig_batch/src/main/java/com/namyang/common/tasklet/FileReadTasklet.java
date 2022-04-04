package com.namyang.common.tasklet;

import java.io.File;
import java.util.HashMap;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import com.namyang.common.job.MigBatchTestJob;
import com.namyang.common.service.BatchService;
import com.namyang.common.service.FileServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j 
@Component 
@StepScope 
public class FileReadTasklet implements Tasklet { 
	
	//private String dir = "D:\\temp";
	
	private String dir = "E:\\NY_ORDER_MDB";
	
	@Autowired
	private FileServiceImpl fileService;

	@Override 
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception { 
		
		String[] aName = chunkContext.attributeNames();	
				
		for(String name : aName) {			
			log.info("###########  name :: " + name);			
		}
		
		int cnt = 0;
		File file = new File(dir);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		if(file.isDirectory()) {
			
			File[] arrFiles = file.listFiles();
		    //디렉토리의 파일목록(디렉토리포함)을 File 배열로 반환
		    for(File f: arrFiles){
		    	
		    	if(cnt == 0 ) {
		    		fileService.deleteFileName(paramMap);
		    		cnt++;
		    	}
		    	
		    	paramMap = new HashMap<String, Object>();
		    	String fileName = f.getName();		       
		        if(f.isDirectory()){
		        	System.out.print(fileName+"\t");
		            System.out.print("DIR\n");
		        }else{ 
		        	paramMap.put("fileName", fileName);
		        	paramMap.put("fileSize", f.length());
		        	paramMap.put("filePath", dir + "/" +  fileName);
		        	//fileService.insertFileName(paramMap);
		        	   
		        }			
			}
		}
		
		log.info("FileReadTasklet end"); 
		return RepeatStatus.FINISHED;
	}
}

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

import com.namyang.common.job.MigBatchJob;
import com.namyang.common.service.BatchService;
import com.namyang.common.service.FileService;
import com.namyang.common.service.NoBatchService;

import lombok.extern.slf4j.Slf4j;

@Slf4j 
@Component 
@StepScope 
public class MdbMigTasklet implements Tasklet { 
	
	//private String dir = "E:\\NY_ORDER_MDB";
	
    private String dir = "E:\\mdb";
	
	@Autowired
	private FileService fileService;
	
	@Override 
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception { 
		log.info("MdbMigTasklet execute start  배치 시작 !!");
		
        if (!new File(dir).exists()) {
        	
        	log.info("is not dir  =====================================================================");
        	
        }else {
                
	        //나스서버에 있는 파일 DB인서트
	        fileService.insertMdbFileList();
	        
	        //fileService.insertFileList();
	        
			log.info("CreateFileLinkTasklet start =====================================================================");
			
			HashMap<String, Object> fileParamMap = new HashMap<String, Object>();
			
			//나스서버에 있는 파일 리스트
			List<HashMap> list = fileService.selectFileList(fileParamMap);
					
			for(HashMap<String, Object> map : list) {
				
				log.info((String) map.get("AGEN_CD") + ".MDB start ============================================================================");
				
				//나스서버에 있는 파일 D:로 복사
				fileService.copyMdbFile(map);
				//복사 상태 업데이트
				fileService.updUpdMigFile(map);	
				
				if("Y".equals(map.get("UPD_YN"))) {
					
					String result = fileService.createFileLink(map);			
					if(!"".equals(result)) {
						log.info("createFileLink result :: " + result);
						continue;				
					}			
					
					Thread.sleep(1500);
					fileService.fileInsertProc(map);
					
					fileService.updMigFile(map);			
					
					fileService.dropFileLink(map);
					
					try {
						fileService.deleteMigFile(map);
					}catch(Exception e) {
						e.printStackTrace();
						
						log.info("StartRunner 파일삭제 실패  =======================================");
					}
				}
				
				log.info("MDB end  ==========================================================================");
			}
        }
		
		log.info("CreateFileLinkTasklet end ====================================================================="); 
        log.info("배치 종료 !!");
	    
		
		
		 
		return RepeatStatus.FINISHED; 
	} 
}



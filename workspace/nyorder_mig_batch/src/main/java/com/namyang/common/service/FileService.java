package com.namyang.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface FileService {
	
	Map<String, Object> insertMdbFileList();
	
	Map<String, Object> copyMdbFile(Map<String, Object> param);
	
	List<HashMap> selectFileList(Map<String, Object> param) throws Exception;
	
	String createFileLink(Map<String, Object> param) throws Exception;
	
	Map<String, Object> fileInsertProc(Map<String, Object> param) throws Exception;
	
	String dropFileLink(Map<String, Object> param) throws Exception;
	
	Map<String, Object> updMigFile(Map<String, Object> param) throws Exception;
	
	Map<String, Object> updUpdMigFile(Map<String, Object> param) throws Exception;
	
	String deleteMigFile(Map<String, Object> param) ;

}

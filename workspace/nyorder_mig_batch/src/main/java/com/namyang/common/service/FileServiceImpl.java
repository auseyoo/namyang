package com.namyang.common.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.sql.DataSource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.TransactionIsolationLevel;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;

import com.namyang.common.mapper.FileMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : FileServiceImpl.java
 * 작성자  : JungsuKim
 * 작성일  : 2022. 1. 21.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 21.    JungsuKim     최조 프로그램 작성
 *
 ****************************************************/
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : FileServiceImpl.java
 * 작성자  : JungsuKim
 * 작성일  : 2022. 1. 21.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 21.    JungsuKim     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Service
public class FileServiceImpl implements FileService {

    // Sql SessionFactory ( 배치 처리 )
    private SqlSessionFactory sqlSessionFactory;
    
    @Autowired
	public FileMapper fileMapper;


    /**
     * Instantiates a new Batch service.
     *
     * @param sqlSessionFactory  the sql session factory
     */
    public FileServiceImpl(SqlSessionFactory sqlSessionFactory){
        this.sqlSessionFactory = sqlSessionFactory;
    }
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    @Autowired
    private DataSource dataSource;
    
    private String dir = "E:\\mdb";
    
    private String uploadPath="\\\\150.1.3.3\\log\\ny_order\\mdb/";
    
    
    /**
     * 
     * @Method Name : insertFileList
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : 마이그레이션폴더에 있는 파일 DB테이블에 업로드
     * @param param void
     */
    public Map<String, Object> insertMdbFileList() {

    	log.info("insertMdbFileList start"); 
		
		int cnt = 0;
		File file = new File(uploadPath);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(file.isDirectory()) {
			
			File[] arrFiles = file.listFiles();
		    //디렉토리의 파일목록(디렉토리포함)을 File 배열로 반환
			
			log.info("insertFileList arrFiles :: " + arrFiles.length);
			
		    for(File f: arrFiles){
		    	
//		    	if(cnt == 0 ) {
//		    		sqlSessionTemplate.insert("com.namyang.common.mapper.FileMapper.deleteFileName", param);	    	
//		    	}
		    	cnt++;
		    	
		    	paramMap = new HashMap<String, Object>();
		    	String fileName = f.getName();
		    	String agenCd = fileName.substring(0, fileName.lastIndexOf(".")); 
		    	
		    	log.info("insertFileList fileName :: " + fileName + ", :: " + agenCd);
		    	
		        if(f.isDirectory()){
		        	System.out.print(fileName+"\t");
		            System.out.print("DIR\n");
		        		        
		        }else{
		        	
		        	paramMap.put("AGEN_CD", 		agenCd);		        	
		        	paramMap.put("FILE_PATH", 		dir +"/"+fileName);
		        	paramMap.put("ORI_FILE_PATH", 	uploadPath +"/"+fileName);
		        			        	
		        	sqlSessionTemplate.insert("com.namyang.common.mapper.FileMapper.insertFileName", paramMap);		        	
		        	   
		        }		
			}
		}		
		log.info("insertMdbFileList end");
		
		return resultMap;
    }
    
    /**
     * 
     * @Method Name : insertFileList
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : 마이그레이션폴더에 있는 파일 DB테이블에 업로드
     * @param param void
     */
    public Map<String, Object> copyMdbFile(Map<String, Object> param) {

    	log.info("copyMdbFile start");
    	
        //경로 생성
        if ( ! new File(dir).exists()) {
            new File(dir).mkdirs();
            log.debug("uploadForm  ==================================  경로 없음" );
        }
        
        String fileNm = (String) param.get("AGEN_CD") + ".MDB";
    	
        File target = new File(dir, fileNm);
        
        File file = new File(uploadPath, fileNm);

        //파일 복사
        try {
        	
        	Files.copy(file.toPath(), target.toPath(), StandardCopyOption.REPLACE_EXISTING);
            
            if (new File(dir, fileNm).isFile()) {
            	log.info("uploadForm  ==================================  success :: " + uploadPath + target );
            	param.put("UPD_YN", "Y");
            }else {
            	log.info("uploadForm  ==================================  FAIL :: " + uploadPath + target );
            	param.put("UPD_YN", "N");
            	param.put("UPD_RMK", "is not file");
            	
            }
            
            
        } catch(Exception e) {
            e.printStackTrace();
            param.put("UPD_YN", "N");
            param.put("UPD_RMK", e.getMessage());
        }
		
		log.info("copyMdbFile end");
		
		return param;
    }
    
    
    public void deleteFileName(Map<String, Object> param) {

    	log.info("deleteFileName $$$$$$$$$ 시작");                
    	sqlSessionTemplate.insert("com.namyang.common.mapper.FileMapper.deleteFileName", param);
    	
    	
        
    }
    
    /**
     * 
     * @Method Name : updMigFile
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : 마이그레이션 성공여부를 업데이트한다.
     * @param param Map
     */
    @Transactional
    public Map<String, Object> updMigFile(Map<String, Object> param) throws Exception {

    	log.info("updMigFile   ######### 시작 SALE_CD :: "+ param.get("SALE_CD") + ",  param :: " + param);
    	
    	try {    	
    		sqlSessionTemplate.update("com.namyang.common.mapper.FileMapper.updMigFile", param);
    	}catch(Exception e) {
    		e.printStackTrace();
    	}    	
    	return param;
        
    }
    
    public Map<String, Object> updUpdMigFile(Map<String, Object> param) throws Exception {

    	log.info("updMigFile   ######### 시작 SALE_CD :: "+ param.get("AGEN_CD") + ",  param :: " + param);
    	
    	try {
    	
    		sqlSessionTemplate.update("com.namyang.common.mapper.FileMapper.updUpdMigFile", param);
    	}catch(Exception e) {
    		e.printStackTrace();
    	}    	
    	return param;
        
    }
    
    
    /**
     * 
     * @Method Name : fileInsertProc
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : DB링크를 이용해서 마이그레이션 프로시저 호출
     * @param param Map
     */
    @Transactional
    public Map<String, Object> fileInsertProc(Map<String, Object> param) throws Exception {

    	log.info("FileInsertProc   ######### 시작 SALE_CD :: "+ param.get("SALE_CD") + ",  param :: " + param);
    	
    	try {    		
    		
    		sqlSessionTemplate.update("com.namyang.common.mapper.FileMapper.updMigFileStatDtm", param);
    	
	    	if("BA".equals(param.get("SALE_CD"))) {
	    		sqlSessionTemplate.selectList("com.namyang.common.mapper.FileMapper.baFileInsertProc", param);
	    		
	    	}else if("SI".equals(param.get("SALE_CD"))) {
	    		sqlSessionTemplate.selectList("com.namyang.common.mapper.FileMapper.siFileInsertProc", param);
	    		
	    	}else {
	    		param.put("RESULT", "NOT SALE_CD");
	    	}
    	}catch(Exception e) {
    		e.printStackTrace();
    		param.put("migYn", "E");
    		param.put("migRmk", e.getMessage());
    		
    		//param.put("migRmk", new String(e.getMessage().getBytes(), 0, 200));    		
    		
    		log.info("FileInsertProc   ######### end  RESULT :: " + param);    		
    		return param;
    	}
    	
    	param.put("migYn", "Y");
		param.put("migRmk", "success");
		
		log.info("FileInsertProc   ######### end  RESULT :: " + param);
		
    	return param;
        
    }
    
    public List<HashMap> selectFileList(Map<String, Object> param) throws Exception {

    	log.info("selectFileList   ######### 시작");
    	
    	return sqlSessionTemplate.selectList("com.namyang.common.mapper.FileMapper.selectFileList", param);
    	
    	//fileMapper.insertFileName(param);
        
    }
    
    
    /**
     * 
     * @Method Name : createFileLink
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : T_MIG_FILE 테이블에 읽어서 DB링크 생성
     * @param param String
     */
    public String createFileLink(Map<String, Object> param) throws Exception {

    	log.info("createFileLink   ######### 시작 param ::" + param);
    	
    	String agenCd = (String) param.get("AGEN_CD");
    	String serverNm = "";
    	String addQuery = "";
    	String filePaht = dir +"/"+ agenCd + ".MDB";
    	
    	if("BA".equals(param.get("SALE_CD"))) {
    		serverNm = "BA_MDB";
    		addQuery = "		    ,@provstr =  N';PWD=qkdvksqlalfqjsgh'   ;";
    		
    	}else if("SI".equals(param.get("SALE_CD"))) {
    		serverNm = "SI_MDB";
    		addQuery= "		    ,@provstr =  N';PWD=persys21'   ;";
    		
    	}else {
    		return "NOT SALE_CD";    		
    	}
    	
    	String qurey = "EXEC master.dbo.sp_addlinkedserver  "
    			+ "			@server = '" + serverNm + "' , "
    			+ "			@srvproduct = 'Access' , "
    			+ "			@provider = 'Microsoft.ACE.OLEDB.12.0',  "
    			+ "		    @datasrc =  '" + filePaht + "',   "
    			+ "		    @location =  'PAMS21'   " + addQuery;
    			//+ "		    @provstr =  N';PWD=qkdvksqlalfqjsgh'   ;"
    			//+ "		    @provstr =  N';PWD=persys21'   ;"
    			
    			;
    	
    	String loginQurey = "EXEC sp_addlinkedsrvlogin "	
    			+ " @rmtsrvname = '" + serverNm + "' , "
    			+ " @useself = FALSE,    "		
    			+ " @locallogin = NULL,  "		
    			+ " @rmtuser = Admin,	 "	
    			+ " @rmtpassword = NULL ;";
    	
    	
    	log.info("createFileLinkLogin   ######### 시작 qurey ::" + qurey);
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	PreparedStatement pstmt2 = null;
    			
    	try {
    		
    		//SqlSession sqlSession = sqlSessionFactory.openSession(TransactionIsolationLevel.NONE);
    		
    		//sqlSession.selectList("com.namyang.common.mapper.FileMapper.createFileLink", param);
    		
    		conn = dataSource.getConnection();
        	
        	pstmt = conn.prepareStatement(qurey);
        	
        	int resultInt = pstmt.executeUpdate();
        	
        	log.info("createFileLink   ######### resultInt ::" + resultInt );
        	
    	}catch(Exception e) {
    		e.printStackTrace();    		
    	} finally {
    		pstmt.close();    		
    		//conn.close();    		
    	}
    	
    	try {
    		pstmt2 = conn.prepareStatement(loginQurey);
        	
        	int resultInt2 = pstmt2.executeUpdate();
        	
        	log.info("createFileLinkLogin   ######### resultInt2 ::" + resultInt2 );
        	
    	}catch(Exception e) {
    		e.printStackTrace();    		
    	} finally {
    		pstmt2.close();    		
    		//conn.close();    		
    	
    	}
    	
    	log.info("createFileLink   ######### end ");
    	    	
    	return "";
    	
    }
    
    
    /**
     * 
     * @Method Name : dropFileLink
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : 생성 한 DB링크 삭제
     * @param param String
     */
    public String dropFileLink(Map<String, Object> param) throws Exception {

    	log.info("dropFileLink   ######### 시작 param :: " + param);                
    	//sqlSessionTemplate.update("com.namyang.common.mapper.FileMapper.dropFileLink", param);
    	String serverNm = "";
    	
    	if("BA".equals(param.get("SALE_CD"))) {
    		serverNm = "BA_MDB";   		
    		
    	}else if("SI".equals(param.get("SALE_CD"))) {
    		serverNm = "SI_MDB";    	    		
    	}
    	
    	String qurey = "EXEC master.dbo.sp_dropserver   "
    			+ "			@server = '" + serverNm + "' , "
    			+ "			@droplogins = 'droplogins' ; ";
    			
    	log.info("dropFileLink   ######### qurey ::" + qurey);
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	    			
    	try {
    		
    		conn = dataSource.getConnection();        	
        	pstmt = conn.prepareStatement(qurey);        	
        	int resultInt = pstmt.executeUpdate();
        	
        	log.info("dropFileLink   ######### resultInt ::" + resultInt );
        	
    	}catch(Exception e) {
    		e.printStackTrace();    		
    	} finally {
    		pstmt.close();    		
    		//conn.close();    		
    	}  
    	
    	log.info("dropFileLink   ######### end ");
    	return "";
    }
    
    /**
     * 
     * @Method Name : deleteMigFile
     * @작성일 : 2022. 1. 21.
     * @작성자 : JungsuKim
     * @Method 설명 : 복사한 MDB파일 삭제
     * @param param String
     */
    public String deleteMigFile(Map<String, Object> param) {

    	log.info("deleteMigFile   ######### 시작 param :: " + param);                
    	 
    	File file = new File(dir, (String) param.get("AGEN_CD") + ".MDB");
    	
    	if( file.exists() ){ 
    		if(file.delete()){ 
    			
    			log.info("deleteMigFile   ######### 파일삭제 성공 " );
    			 
    		}else{ 
    			log.info("deleteMigFile   ######### 파일삭제 실패 " ); 
    		} 
    	}else{ 
    		log.info("deleteMigFile   ######### 파일삭제 실패 " );
    	} 
    
    	log.info("deleteMigFile   ######### end ");
    	return "";
    }   
       
    
    
    
}

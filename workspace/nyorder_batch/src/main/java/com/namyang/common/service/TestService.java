package com.namyang.common.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class TestService {
	
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    @Autowired
    private DataSource dataSource;
	
    public int insertFileList(Map<String, Object> param) throws Exception {

    	log.info("selectFileList   ######### 시작");
    	
    	param.put("name", "kim");
    	param.put("sex", 1);
    	
    	return sqlSessionTemplate.insert("com.namyang.common.mapper.TestMapper.insertSqlSession", param);
    	
    	//fileMapper.insertFileName(param);
        
    }
    
    public void dropFileLink(Map<String, Object> param) throws Exception {

    	log.info("dropFileLink   ######### 시작");                
    	//sqlSessionTemplate.update("com.namyang.common.mapper.FileMapper.dropFileLink", param);
    	
    	String qurey = "INSERT INTO TEST (ID, NAME, SEX, REG_DATE) VALUES (NEXT VALUE FOR TEST_SEQ, 'mmm', 1, getdate())";
    			
    	log.info("dropFileLink   ######### 시작 qurey ::" + qurey);
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	    			
    	try {
    		
    		//SqlSession sqlSession = sqlSessionFactory.openSession(TransactionIsolationLevel.NONE);
    		
    		//sqlSession.selectList("com.namyang.common.mapper.FileMapper.createFileLink", param);
    		//conn = sqlSessionTemplate.getConnection();
    		
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
    	
    	
    }

}

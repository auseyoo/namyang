package com.namyang.common.service;


import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.common.mapper.BatchMapper;
import com.namyang.common.mapper.NoBatchMapper;
import com.namyang.util.CreateData;

import lombok.extern.slf4j.Slf4j;

import java.util.*;

@Slf4j
@Service
public class BatchService {


	
    // Sql SessionFactory ( 배치 처리 )
    private SqlSessionFactory sqlSessionFactory;

    /**
     * Instantiates a new Batch service.
     *
     * @param sqlSessionFactory  the sql session factory
     */
    public BatchService(SqlSessionFactory sqlSessionFactory){
        this.sqlSessionFactory = sqlSessionFactory;
    }
    
	

    /**
     * Instantiates a new No batch service.
     *
     * @param noBatchMapper
     */

    
    //@Autowired
    //private  BatchMapper batchMapper;

    /**
     * sqlSession 배치 처리 ( 데이터 생성은 AOP로 구현 )
     *
     * @param paramList the param list
     */
    @CreateData
    public void sqlSessionBatchWithAop(List<Map<String, Object>> paramList) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        long startTime = System.currentTimeMillis();
        try {
            for (Map<String, Object> param : paramList) {
                sqlSession.insert("com.namyang.common.mapper.BatchMapper.insertSqlSession1", param);
            }
        }catch(Exception e) {
        	e.printStackTrace();       	
        
        } finally {
            sqlSession.flushStatements();
            sqlSession.close();
            sqlSession.clearCache();
        }
        long endTime = System.currentTimeMillis();
        long resultTime = endTime - startTime;

        log.info("sqlSessionBatchWithAop  트랜젝션 sqlSession 배치 테스트 종료");
        log.info("sqlSessionBatchWithAop  트랜젝션 sqlSession 배치" + " 소요시간  : " + resultTime/1000 + "초("+resultTime+")");
    }

    /**
     * forEach 배치 처리 ( 데이터 생성은 AOP로 구현 )
     *
     * @param paramList the param list
     */
    @CreateData
    public void forEachBatchWithAop(List<Map<String, Object>> paramList) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        
        long startTime = System.currentTimeMillis();
        
        try {
            Map<String, Object> param = new HashMap<>();
            param.put("memberList", paramList);
            sqlSession.insert("com.namyang.common.mapper.BatchMapper.insertForEach3", param);
        }catch(Exception e) {
        	e.printStackTrace();       	
        
        } finally {
            sqlSession.flushStatements();
            sqlSession.close();
            sqlSession.clearCache();
        }
        long endTime = System.currentTimeMillis();
        long resultTime = endTime - startTime;

        log.info("forEachBatchWithAop  트랜젝션 sqlSession 배치 테스트 종료");
        log.info("forEachBatchWithAop  트랜젝션 sqlSession 배치" + " 소요시간  : " + resultTime/1000 + "초("+resultTime+")");
    }

    /**
     * sqlSession 배치 처리
     */
    public void sqlSessionBatch() {

        log.info("sqlSessionBatch  트랜젝션 sqlSession 배치 테스트 시작");
        int totalCount = 10000;
        int perPageNum = 1000;
        int maxPageNum = (int) Math.ceil(totalCount / perPageNum);
        maxPageNum = maxPageNum == 0 ? 1 : maxPageNum;

        String[] nameArr = {"Aadan","Aaliah","Aalleeyaa","Aaric","Ab-Owen","Abadine","Abagael","Abagale","Abbagail","Abbegail","Abbeygail","Abbi","Abbigail","Abbigayle","Abbot","Abbott","Aberfa","Abergavenny","Abgail","Abhorson","Abigale","Abrielle","Acca","Acennan","Acey","Acker","Ackerley","Ackerman","Ackley","Acton","Acwel","Acwellen","Adain","Adalbeorht","Adalbrechta","Adalson","Adam","Adamm","Adamson","Addeline","Addis","Addison","Adelaido","Adelyn","Adia","Adken","Adkins","Adler","Adney","Adny","Adonna","Adram","Adrean","Adrena","Adrenalijna","Adriann","Adrieanna","Adrin","Adrion","Adriona","Adron","Adyn","Adyna","Adyson","Aeccestane","Aedd","Aedre","Aefentid","Aefre","Aeker","Aekerman","Aelfraed","Aelfthryth","Aelfwine","Aelita","Aelle","Aelwen","Aenedleah","Aenescumb","Aeoelric","Aeric","Aerica","Aerlene","Aerona","Aesclin","Aesoburne","Aethelberht","Aethelbert","Aethelind","Aethelred","Aethelweard","Aethelwine","Aethelwulf","Aetheston","Agness","Ahebban","Ahreddan","Aiken","Aikin","Ailen"};
        List<Map<String, Object>> paramList = new ArrayList<>();

        log.info("sqlSessionBatch  트랜젝션 배치 전체 데이터 수 : " + totalCount);
        log.info("sqlSessionBatch  트랜젝션 배치 루프 당 데이터 수 : " + perPageNum);

        long startTime = System.currentTimeMillis();
        Random random = new Random();
        for (int i = 0; i < maxPageNum; i++) {
        	
            for (int j = 0; j < perPageNum; j++) {
                Map<String, Object> param = new HashMap<>();
                
                param.put("name", nameArr[(int) (Math.random() * 100)]);
                param.put("sex", random.nextInt(3));
                SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
                try {
                	sqlSession.insert("com.namyang.common.mapper.BatchMapper.insertSqlSession", param);
                }catch(Exception e) {
                	
                	e.printStackTrace();
                } finally {
                    sqlSession.flushStatements();
                    sqlSession.close();
                    sqlSession.clearCache();
                }
                
            }
        }
        long endTime = System.currentTimeMillis();
        long resultTime = endTime - startTime;

        log.info("sqlSessionBatch  트랜젝션 sqlSession 배치 테스트 종료");
        log.info("sqlSessionBatch  트랜젝션 sqlSession 배치" + " 소요시간  : " + resultTime/1000 + "초("+resultTime+")");

    }
    

    
    /**
     * forEach 배치 처리
     */
    public void forEachBatch() {

        log.info("forEachBatch  트랜젝션 forEach 배치 테스트 시작");
        int totalCount = 10000;
        int perPageNum = 1000;
        int maxPageNum = (int) Math.ceil(totalCount / perPageNum);
        maxPageNum = maxPageNum == 0 ? 1 : maxPageNum;

        String[] nameArr = {"Aadan","Aaliah","Aalleeyaa","Aaric","Ab-Owen","Abadine","Abagael","Abagale","Abbagail","Abbegail","Abbeygail","Abbi","Abbigail","Abbigayle","Abbot","Abbott","Aberfa","Abergavenny","Abgail","Abhorson","Abigale","Abrielle","Acca","Acennan","Acey","Acker","Ackerley","Ackerman","Ackley","Acton","Acwel","Acwellen","Adain","Adalbeorht","Adalbrechta","Adalson","Adam","Adamm","Adamson","Addeline","Addis","Addison","Adelaido","Adelyn","Adia","Adken","Adkins","Adler","Adney","Adny","Adonna","Adram","Adrean","Adrena","Adrenalijna","Adriann","Adrieanna","Adrin","Adrion","Adriona","Adron","Adyn","Adyna","Adyson","Aeccestane","Aedd","Aedre","Aefentid","Aefre","Aeker","Aekerman","Aelfraed","Aelfthryth","Aelfwine","Aelita","Aelle","Aelwen","Aenedleah","Aenescumb","Aeoelric","Aeric","Aerica","Aerlene","Aerona","Aesclin","Aesoburne","Aethelberht","Aethelbert","Aethelind","Aethelred","Aethelweard","Aethelwine","Aethelwulf","Aetheston","Agness","Ahebban","Ahreddan","Aiken","Aikin","Ailen"};
        List<Map<String, Object>> paramList = new ArrayList<>();

        log.info("forEachBatch  트랜젝션 배치 전체 데이터 수 : " + totalCount);
        log.info("forEachBatch  트랜젝션 배치 루프 당 데이터 수 : " + perPageNum);

        long startTime = System.currentTimeMillis();
        Random random = new Random();
        for (int i = 0; i < maxPageNum; i++) {
            for (int j = 0; j < perPageNum; j++) {
                Map<String, Object> param = new HashMap<>();
                param.put("name", nameArr[(int) (Math.random() * 100)]);
                param.put("sex", random.nextInt(3));
                paramList.add(param);
                
                //log.info("forEachBatch  트랜젝션 forEach 배치  paramList.size() :: " + paramList.size() + ", :: " + j);
                
                if (j == 999 || (i == maxPageNum - 1 && j == totalCount - maxPageNum * perPageNum)) {
                    SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
                    try {
                        Map<String, Object> params = new HashMap<>();
                        param.put("memberList", paramList);
                        sqlSession.insert("com.namyang.common.mapper.BatchMapper.insertForEach", param);
                    }catch(Exception e) {
                    	
                    	e.printStackTrace();
                    } finally {
                        sqlSession.flushStatements();
                        sqlSession.close();
                        sqlSession.clearCache();
                    }
                    paramList.clear();
                }
            }
        }
        long endTime = System.currentTimeMillis();
        long resultTime = endTime - startTime;

        log.info("forEachBatch  트랜젝션 forEach 배치 테스트 종료");
        log.info("forEachBatch  트랜젝션 forEach 배치" + " 소요시간  : " + resultTime/1000 + "초("+resultTime+")");

    }
}

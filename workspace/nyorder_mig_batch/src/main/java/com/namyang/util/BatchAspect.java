package com.namyang.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import com.namyang.common.service.BatchService;

import lombok.extern.slf4j.Slf4j;

import java.util.*;

@Aspect
@Slf4j
@Component
public class BatchAspect {
    
    /**
     * 데이터 생성 advice
     *
     * @param pjp the pjp
     * @return the object
     * @throws Throwable the throwable
     */
    @Around("@annotation(com.namyang.util.CreateData)")
    public Object CreateData(ProceedingJoinPoint pjp) throws Throwable {
        String name = pjp.getSignature().getName();
        StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        log.info("CreateData       @@@@@@@@@@@@@@@@@@@@");
        log.info(name + " 배치 데이터 등록 시작");
        
        Object retVal = null;
        try {
            int totalCount = 10000;
            int perPageNum = 1000;
            log.info("CreateData  전체 데이터 개수 : " + totalCount);
            log.info("CreateData  루프당 데이터 개수 : " + perPageNum);
            
            int maxPageNum = (int) Math.ceil(totalCount / perPageNum);
            maxPageNum = maxPageNum == 0 ? 1: maxPageNum;

            if (totalCount < perPageNum) {
                perPageNum = totalCount;
            }

            List<Map<String, Object>> paramList = new ArrayList<>();

            String[] nameArr = {"Aadan","Aaliah","Aalleeyaa","Aaric","Ab-Owen","Abadine","Abagael","Abagale","Abbagail","Abbegail","Abbeygail","Abbi","Abbigail","Abbigayle","Abbot","Abbott","Abbigail","Abbigayle","Abbot","Abbott"};
            		
            Random random = new Random();
            for (int i = 0; i < maxPageNum; i++) {
                for (int j = 0; j < perPageNum; j++) {
                    Map<String, Object> param = new HashMap<>();
                    
                    param.put("name", nameArr[(int) (Math.random() * 20)]);
                    param.put("sex", random.nextInt(3));
                    paramList.add(param);
                    if (j == 999 || (i == maxPageNum - 1 && j == totalCount - maxPageNum * perPageNum)) {
                        retVal = pjp.proceed(new Object[]{ paramList });
                    }
                }
            }
        }catch(Exception e) {
        	e.printStackTrace();       	
        	
        } finally {
            stopWatch.stop();
            //log.info(name + " 배치 데이터 등록 종료 : " + (int) Math.ceil(stopWatch.getTotalTimeSeconds()) + "초");
            log.info("CreateData  @@@@@@@@@@@@@@@@@@@@@@@@@@");
        }

        return retVal;
    }

}

package com.namyang.nyorder.prdbndchg.controller;

import javax.annotation.PostConstruct;

import org.quartz.SchedulerException;
import org.springframework.stereotype.Component;

import com.namyang.config.BatchController;
import com.namyang.nyorder.prdbndchg.job.StdPrdBndChgCronJob;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 표준제품 일괄 변경 배치
 * 파일명  : PrdBndChgController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 26.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 26.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Component
public class StdPrdBndChgController {

	private BatchController batchController;
	
	public StdPrdBndChgController(BatchController batchController) {
		this.batchController = batchController;		
	}
	
    @PostConstruct
    public void quartzJobInit() {
        try {
        	batchController.addCronJob(StdPrdBndChgCronJob.class,"표준제품 일괄 변경 배치", "표준제품 일괄 변경 배치", null, "0 0 1 * * ?");
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
	
}

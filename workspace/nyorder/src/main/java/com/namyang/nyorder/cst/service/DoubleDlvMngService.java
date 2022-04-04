package com.namyang.nyorder.cst.service;

import java.util.Map;

import com.namyang.nyorder.config.error.exception.BusinessException;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 더블 작업 Service
 * 파일명  : DoubleDlvMngService.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 14.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
public interface DoubleDlvMngService {

	String startDoubleProc(Map<String, Object> param) throws BusinessException;
	String returnDoubleProc(Map<String, Object> param) throws BusinessException;
}

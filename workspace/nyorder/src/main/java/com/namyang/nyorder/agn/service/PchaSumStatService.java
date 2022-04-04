package com.namyang.nyorder.agn.service;

import java.util.Map;

import com.namyang.nyorder.agn.vo.PchaSumStatVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 집계 현황 Service
 * 파일명  : PchaSumStatService.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface PchaSumStatService {
	
	/**
	 * @Method Name : selectSumStatPchaList
	 * @작성일 : 2022. 1. 20.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @return PchaRegVO
	 */
	public Map<String, Object> selectSumStatPchaList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectPchaSumStatDayList
	 * @작성일 : 2022. 1. 20.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 상세(일) 조회
	 * @param param
	 * @return PchaSumStatVO
	 */
	public Map<String, Object> selectPchaSumStatDayList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectPchaSumStatMonList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 상세(월) 조회
	 * @param param
	 * @return PchaSumStatVO
	 */
	public Map<String, Object> selectPchaSumStatMonList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectMjrPchaSumStatDayList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 상세(일) 조회(메이저)
	 * @param param
	 * @return PchaSumStatVO
	 */
	public Map<String, Object> selectMjrPchaSumStatDayList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectMjrPchaSumStatMonList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 상세(월) 조회(메이저)
	 * @param param
	 * @return PchaSumStatVO
	 */
	public Map<String, Object> selectMjrPchaSumStatMonList(PchaSumStatVO param);
	
}

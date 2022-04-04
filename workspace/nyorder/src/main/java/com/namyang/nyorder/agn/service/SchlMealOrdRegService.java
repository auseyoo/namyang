package com.namyang.nyorder.agn.service;

import java.util.Map;

import com.namyang.nyorder.agn.vo.SchlMealOrdRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 학교급식 주문 등록 Service
 * 파일명  : SchlMealOrdRegService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 9.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 9.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface SchlMealOrdRegService {
	/**
	 * @Method Name : selectSchlList
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문등록 학교 리스트 조회
	 * @param param
	 * @return SchlMealOrdRegVO
	 */
	public Map<String, Object> selectSchlList(SchlMealOrdRegVO param);
	
	/**
	 * @Method Name : selectSchlMealPrdList
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문등록 표준제품 리스트 조회
	 * @param param
	 * @return SchlMealOrdRegVO
	 */
	public Map<String, Object> selectSchlMealPrdList(SchlMealOrdRegVO param);
}

package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.PchaRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 등록 Service 
 * 파일명  : PchaRegService.java
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
public interface PchaRegService {
	/**
	 * @Method Name : selectPchaList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @return PchaRegVO
	 */
	public Map<String, Object> selectPchaList(PchaRegVO param);
	
	/**
	 * @Method Name : selectPchaRegList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 제품 조회
	 * @param param
	 * @return PchaRegVO
	 */
	public Map<String, Object> selectPchaRegList(PchaRegVO param);
	
	/**
	 * @Method Name : savePchaRegList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 정보 저장
	 * @param param
	 * @return PchaRegVO
	 */
	public String savePchaRegList(List<PchaRegVO> param) throws Exception;
	
	/**
	 * @Method Name : selectOthComPrdList
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 조회
	 * @param param
	 * @return Map<String, Object>
	 */
	public Map<String, Object> selectOthComPrdList(PchaRegVO param);
	
}

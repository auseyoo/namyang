package com.namyang.nyorder.agn.service;

import java.util.Map;

import com.namyang.nyorder.agn.vo.SpclOrdRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 특수처 주문 등록 Service
 * 파일명  : SpclOrdRegService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 22.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 22.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface SpclOrdRegService {
	/**
	 * @Method Name : selectSpclList
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문등록 특수처 조회
	 * @param param
	 * @return Map<String, Object>
	 */
	public Map<String, Object> selectSpclList(SpclOrdRegVO param);
	
	/**
	 * @Method Name : selectSpclStdPrdList
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문등록 제품 리스트 조회
	 * @param param
	 * @return Map<String, Object>
	 */
	public Map<String, Object> selectSpclStdPrdList(SpclOrdRegVO param);
}

package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.PchaSumStatVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 집계 현황 Mapper
 * 파일명  : PchaSumStatMapper.java
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
public interface PchaSumStatMapper {
	/**
	 * @Method Name : selectSumStatPchaList
	 * @작성일 : 2022. 1. 20.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 집계 현황 매입처 조회
	 * @param param
	 * @return List<PchaSumStatVO>
	 */
	public List<PchaSumStatVO> selectSumStatPchaList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectPchaSumStatDayList
	 * @작성일 : 2022. 1. 20.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 집계 현황 매입처(일) 상세 조회
	 * @param param
	 * @return List<PchaSumStatVO>
	 */
	public List<PchaSumStatVO> selectPchaSumStatDayList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectPchaSumStatMonList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 집계 현황 매입처(월) 상세 조회
	 * @param param
	 * @return List<PchaSumStatVO>
	 */
	public List<PchaSumStatVO> selectPchaSumStatMonList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectMjrPchaSumStatDayList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 집계 현황 매입처(일) 상세 조회(메이저)
	 * @param param
	 * @return List<PchaSumStatVO>
	 */
	public List<PchaSumStatVO> selectMjrPchaSumStatDayList(PchaSumStatVO param);
	
	/**
	 * @Method Name : selectMjrPchaSumStatMonList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 집계 현황 매입처(월) 상세 조회(메이저)
	 * @param param
	 * @return List<PchaSumStatVO>
	 */
	public List<PchaSumStatVO> selectMjrPchaSumStatMonList(PchaSumStatVO param);
	
}

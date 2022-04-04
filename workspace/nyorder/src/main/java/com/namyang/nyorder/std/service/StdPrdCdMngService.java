package com.namyang.nyorder.std.service;

import java.util.Map;

import com.namyang.nyorder.std.vo.StdPchaMngVO;
import com.namyang.nyorder.std.vo.StdPrdCdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 타사제품코드 관리 Service
 * 파일명  : StdPrdCdMngService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface StdPrdCdMngService {
	
	/**
	 * @Method Name : selectPrdCdMstList
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드관리 마스터 조회
	 * @param param
	 * @return String
	 */
	public Map<String, Object> selectPrdCdMstList( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : saveStdPrdCdDetail
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드관리 수정 / 등록
	 * @param param
	 * @return String
	 */
	public Map<String, Object> saveStdPrdCdDetail( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : removeStdPrdCd
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드관리 삭제
	 * @param param
	 * @return String
	 */
	public Map<String, Object> removeStdPrdCd( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : selectStdPrdMngDetail
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 조회
	 * @param param
	 * @return String
	 */
	public StdPrdCdMngVO selectStdPrdMngDetail( StdPrdCdMngVO param );
	
}

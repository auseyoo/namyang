package com.namyang.nyorder.std.service;

import java.util.Map;

import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.std.vo.StdPchaMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 매입처 관리 Service
 * 파일명  : StdPchaMngService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface StdPchaMngService {
	
	/**
	 * @Method Name : selectPchaList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 리스트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPchaList(StdPchaMngVO param);
	
	/**
	 * @Method Name : selectPchaDetail
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 상세 조회
	 * @param param
	 * @return PchaVO
	 */
	public Map<String, Object> selectPchaDetail(StdPchaMngVO param);
	
	/**
	 * @Method Name : savePchaDetail
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 수정/등록
	 * @param param
	 * @return PchaVO
	 */
	Map<String, Object> savePchaDetail(StdPchaMngVO param) throws Exception;
	
	/**
	 * @Method Name : removePcha
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 삭제
	 * @param param
	 * @return PchaVO
	 */
	Map<String, Object> removePcha(StdPchaMngVO param) throws Exception;
}

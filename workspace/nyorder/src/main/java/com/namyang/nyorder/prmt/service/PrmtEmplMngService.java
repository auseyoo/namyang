package com.namyang.nyorder.prmt.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.prmt.vo.PrmtEmplMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 수당 관리 Service
 * 파일명  : PrmtEmplMngService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 14.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtEmplMngService {
	/**
	 * @Method Name : selectPrmtEmplMngList
	 * @작성일 : 2022. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 리스트 조회
	 * @param param
	 * @return Map<String, Object>
	 */
	public Map<String, Object> selectPrmtEmplMngList(PrmtEmplMngVO param);
	
	/**
	 * @Method Name : savePrmtEmplHisList
	 * @작성일 : 2022. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 저장
	 * @param param
	 * @return String
	 */
	public String savePrmtEmplHisList(List<PrmtEmplMngVO> list) throws Exception;
}
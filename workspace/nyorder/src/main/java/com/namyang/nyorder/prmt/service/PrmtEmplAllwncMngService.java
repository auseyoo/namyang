package com.namyang.nyorder.prmt.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.prmt.vo.PrmtEmplAllwncMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 수당 관리 Service
 * 파일명  : PrmtEmplAllwncMngService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtEmplAllwncMngService {
	/**
	 * @Method Name : selectPrmtEmplAllwncList
	 * @작성일 : 2022. 3. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 리스트 조회
	 * @param param
	 * @return Map<String, Object>
	 */
	public Map<String, Object> selectPrmtEmplAllwncList(PrmtEmplAllwncMngVO param);
	
	/**
	 * @Method Name : savePrmtEmplAllwncList
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 저장
	 * @param param
	 * @return String
	 */
	public String savePrmtEmplAllwncList(List<PrmtEmplAllwncMngVO> list) throws Exception;
}
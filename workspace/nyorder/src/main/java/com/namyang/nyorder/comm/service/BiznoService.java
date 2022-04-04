package com.namyang.nyorder.comm.service;

import java.util.Map;

import com.namyang.nyorder.comm.vo.BiznoVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : MDB upload sample page
 * 파일명  : BiznoService.java
 * 작성자  : GAIN
 * 작성일  : 2022. 1. 24.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 24.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
public interface BiznoService {

	
	/**
	 * @Method Name : selectBizno
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : GAIN
	 * @Method 설명 : 
	 * @param param
	 * @return List<BiznoVO>
	 */
	public BiznoVO selectBizno(BiznoVO param);

	/**
	 * @Method Name : selectBiznoList
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 사업자번호 - 대리점코드 조회
	 * @param vO
	 * @return Map<String,Object>
	 */
	public Map<String, Object> selectBiznoList(BiznoVO vO);
	
	

}

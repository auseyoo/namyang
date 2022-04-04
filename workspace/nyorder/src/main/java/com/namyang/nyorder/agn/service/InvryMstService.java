package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 재고 관리 Service
 * 파일명  : InvryMstService.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 14.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface InvryMstService {
	
	/**
	 * 매입처 조회
	 */
	/**
	 * @Method Name : selectPuchList
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPuchList(InvryMstVO param);
	
	/**
	 * 재고 관리 리스트 조회
	 */
	/**
	 * @Method Name : selectInvryMstList
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : LEEJUN
	 * @Method 설명 : 재고 관리 리스트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectInvryMstList(InvryMstVO param);
	
	/**
	 * @Method Name : saveInvryMst
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 저장
	 * @param param
	 * @return InvryMstVO
	 */
	public String saveInvryMst(List<InvryMstVO> param);	
}



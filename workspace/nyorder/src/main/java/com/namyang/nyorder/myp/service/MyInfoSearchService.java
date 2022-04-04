package com.namyang.nyorder.myp.service;

import java.util.List;

import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;
import com.namyang.nyorder.myp.vo.AgenMstVO;
import com.namyang.nyorder.myp.vo.MyInfoSearchVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 내 정보 조회 Service
 * 파일명  : MyInfoSearchService.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 3.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 3.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface MyInfoSearchService {

	/**
	 * @Method Name : selectAgenMst
	 * @작성일 : 2022. 1. 4.
	 * @작성자 : YESOL
	 * @Method 설명 : 대리점 정보 조회 (임시: 차후 SAP에서 조회)  
	 * @param param
	 * @return AgentMstVO
	 */
	public AgenMstVO selectAgenMst(MyInfoSearchVO param);
	
	/**
	 * @Method Name : selectAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param
	 * @return MyInfoSearchVO
	 */
	public List<AgenAcctInfoVO> selectMyInfoSearch(MyInfoSearchVO param);
	
	/**
	 * @Method Name : saveAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 내 정보 저장
	 * @param vo
	 * @return
	 * @throws Exception int
	 */
	public int saveAgenAcctInfo(MyInfoSearchVO vo) throws Exception;
}

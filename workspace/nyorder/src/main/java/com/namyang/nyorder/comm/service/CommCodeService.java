package com.namyang.nyorder.comm.service;

import java.util.List;

import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.PrdClsVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 공통 코드 관리 Service
 * 파일명  : CommCodeService.java
 * 작성자  : YESOL
 * 작성일  : 2021. 12. 31.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 12. 31.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface CommCodeService {

	/**
	 * @Method Name : selectCommCodeList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 공통 코드 리스트 조회
	 * @param param
	 * @return List<CommCodeVO>
	 */
	public List<CommCodeVO> selectCommCodeList(CommCodeVO param);
	
	/**
	 * @Method Name : saveCommCodeList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 공통 코드 리스트 저장 
	 * @param vo
	 * @return String
	 */
	public String saveCommCodeList(List<CommCodeVO> vo);

	/**
	 * @Method Name : selectPrdCls
	 * @작성일 : 2022. 1. 20.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품 분류 조회
	 * @param param
	 * @return List<PrdClsVO>
	 */
	public List<PrdClsVO> selectPrdCls(PrdClsVO param);

}

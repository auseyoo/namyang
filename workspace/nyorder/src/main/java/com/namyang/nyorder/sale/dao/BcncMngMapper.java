package com.namyang.nyorder.sale.dao;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.sale.vo.AgenVendVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처 관리 Mapper
 * 파일명  : BcncMngMapper.java
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
public interface BcncMngMapper {

	/**
	 * @Method Name : selectAgentEmplList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : 이웅일
	 * @Method 설명 : 대리점 담당자 조회
	 * @param param1
	 * @return List<AgenVendVO>
	 */
	public List<AgenVendVO> selectAgentEmplList(AgenVendVO param);


	/**
	 * @Method Name : selectBcncMngList
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 거래처 조회
	 * @param param
	 * @return List<AgenVendVO>
	 */
	public List<AgenVendVO> selectBcncMngList(AgenVendVO param);

	/**
	 * @Method Name : megBncn
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 저장
	 * @param param
	 * @return Intrger
	 */
	public int megBncn(AgenVendVO param);

	/**
	 * @Method Name : megVendEmpl
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 대리점 담당 저장
	 * @param vo
	 * @return Intrger
	 */
	public int megVendEmpl(List<AgenVendVO> vo);

	/**
	 * @Method Name : selectBcncMngDtl
	 * @작성일 : 2022. 1. 14.
	 * @작성자 : WOONGIL
	 * @Method 설명 : 거래처 상세 조회
	 * @param vo
	 * @return HashMap
	 */
	public AgenVendVO selectBcncMngDtl(AgenVendVO param);

	/**
	 * @Method Name : megVendEmpl
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 담당자 저장
	 * @param param
	 * @return Intrger
	 */
	public int megVendEmpl(AgenVendVO param);

	/**
	 * @Method Name : megBcncSprt
	 * @작성일 : 2022. 1. 21.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 저장
	 * @param param
	 * @return Intrger
	 */
	public int megBcncSprt(AgenVendVO param);

	/**
	 * @Method Name : selectBcncMngList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 조회
	 * @param param
	 * @return List<AgenVendVO>
	 */
	public List<AgenVendVO> selectBcncSprtList(AgenVendVO param);

	/**
	 * @Method Name : selectUseBcncSec
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 사용 지원내역구분 조회
	 * @param param
	 * @return List<AgenVendVO>
	 */
	public String selectUseSprtSec(AgenVendVO param);


	/**
	 * @Method Name : selectBncSprtDtl
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 상세
	 * @param param
	 * @return AgenVendVO
	 */
	public AgenVendVO selectBncSprtDtl(AgenVendVO param);
}

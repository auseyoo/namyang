package com.namyang.nyorder.cst.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.cst.vo.CstDlvNtcVO;
import com.namyang.nyorder.cst.vo.CstPrdDlvyVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 배달 관리 Service
 * 파일명  : DlvMngService.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 28.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 28.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface DlvMngService {

	/**
	 * @Method Name : selectDailOrdDlvList
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : YESOL
	 * @Method 설명 : 지역 배달 리스트 조회
	 * @param param
	 * @return List<CstPrdDlvyVO>
	 */
	public List<CstPrdDlvyVO> selectDailDlvAreaList(CstPrdDlvyVO param);

	/**
	 * @Method Name : selectDailDlvDetailList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 품목 리스트 조회
	 * @param param
	 * @return CstPrdDlvyVO
	 */
	public List<CstPrdDlvyVO> selectDailDlvDetailList(CstPrdDlvyVO param);

	/**
	 * @Method Name : selectDailDlvCstDetailList
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 고객 정보 조회
	 * @param param
	 * @return List<CstPrdDlvyVO>
	 */
	public List<CstPrdDlvyVO> selectDailDlvCstDetailList(CstPrdDlvyVO param);
	
	/**
	 * @Method Name : selectCstDlvNtcList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 전달사항 리스트 조회
	 * @param param
	 * @return List<CstDlvNtcVO>
	 */
	public List<CstDlvNtcVO> selectCstDlvNtcList(CstDlvNtcVO param);

	/**
	 * @Method Name : selectDlvCstList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 고객 리스트 조회  (SELECT BOX)
	 * @param param
	 * @return List<CstPrdDlvyVO>
	 */
	public List<CstPrdDlvyVO> selectDlvCstList(CstPrdDlvyVO param);

	/**
	 * @Method Name : selectDlvAreaList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 지역 리스트 조회  (SELECT BOX)
	 * @param param
	 * @return Map<String,Object>
	 */
	public List<CstPrdDlvyVO> selectDlvAreaList(CstPrdDlvyVO param);

	/**
	 * @Method Name : addCstDlvNtc
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 전달사항 저장
	 * @param vo
	 * @return String
	 */
	public int addCstDlvNtc(CstDlvNtcVO vo);

	/**
	 * @Method Name : rmvCstDlvNtc
	 * @작성일 : 2022. 2. 8.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 전달사항 삭제
	 * @param list
	 * @return String
	 */
	public String rmvCstDlvNtc(List<CstDlvNtcVO> list);

	/**
	 * @Method Name : saveAreaDlvOrdr
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : YESOL
	 * @Method 설명 : 지역 순서 변경
	 * @param list
	 * @return String
	 */
	public String saveAreaDlvOrdr(List<CstPrdDlvyVO> list);

	/**
	 * @Method Name : saveDlvCstDtl
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 고객 배송 정보 수정
	 * @param list
	 * @return String
	 */
	public String saveDlvCstDtl(List<CstPrdDlvyVO> list);

}
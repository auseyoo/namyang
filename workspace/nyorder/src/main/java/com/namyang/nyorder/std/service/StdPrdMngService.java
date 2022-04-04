package com.namyang.nyorder.std.service;

import java.util.List;

import com.namyang.nyorder.std.vo.StdPrdBndChgVO;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.std.vo.StdPrdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준벙보관리 - 표준 제품 관리 Service
 * 파일명  : StdPrdMngService.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface StdPrdMngService {

	
	/**
	 * @Method Name : selectPrdMstList
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품 조회(SAP기준) 
	 * @param param
	 * @return List<StdPrdMngVO>
	 */
	public List<StdPrdMngVO> selectPrdMstList(StdPrdMngVO param);
	
	/**
	 * @Method Name : selectStdPrdMngList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 조회(대리점기준)
	 * @param param
	 * @return List<StdPrdMngVO>
	 */
	public List<StdPrdMngVO> selectStdPrdMngList(StdPrdMngVO param);

	/**
	 * @Method Name : selectStdPrdMngDetail
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 상세 조회
	 * @param param
	 * @return List<StdPrdMngDetailVO>
	 */
	public StdPrdMngDetailVO selectStdPrdMngDetail(StdPrdMngDetailVO param);

	/**
	 * @Method Name : saveStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 등록
	 * @param vo
	 * @return String
	 */
	public String saveStdPrdDetail(StdPrdMngDetailVO vo);

	/**
	 * @Method Name : delStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 삭제
	 * @param vo
	 * @return String
	 */
	public String delStdPrdDetail(StdPrdMngDetailVO vo);

	/**
	 * @Method Name : saveStdPrdOrdr
	 * @작성일 : 2022. 1. 13.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 순서 저장
	 * @param vo
	 * @return String
	 */
	public String saveStdPrdOrdr(List<StdPrdMngDetailVO> list);

	/**
	 * @Method Name : addStdPrdList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 리스트 저장
	 * @param list
	 * @return String
	 */
	public String addStdPrdList(List<StdPrdMngDetailVO> list);

	/**
	 * @Method Name : saveStdPrdBndChgList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품 일괄 변경 - 저장
	 * @param list
	 * @return String
	 */
	public String saveStdPrdBndChgList(List<StdPrdBndChgVO> list);

	/**
	 * @Method Name : selectStdPrdBndChgList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품 일괄 변경 - 리스트 조회
	 * @param param
	 * @return List<StdPrdBndChgVO>
	 */
	public List<StdPrdBndChgVO> selectStdPrdBndChgList(StdPrdBndChgVO param);

	

}

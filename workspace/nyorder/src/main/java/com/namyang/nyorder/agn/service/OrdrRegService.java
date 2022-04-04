package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.OrdRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문 등록 Service
 * 파일명  : OrdrRegService.java
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
public interface OrdrRegService {
	/**
	 * @Method Name : selectSdtPrdList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준제품 리스트 조회(방판)
	 * @param param
	 * @return OrdRegVO
	 */
	public Map<String, Object> selectSdtPrdList(OrdRegVO param);
	
	/**
	 * @Method Name : saveOrdRegList
	 * @작성일 : 2022. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문등록 정보 저장
	 * @param param
	 * @return OrdRegVO
	 */
	public String saveOrdRegList(List<OrdRegVO> param) throws Exception;
	
	/**
	 * @Method Name : selectPrdMstSapList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품 조회(SAP기준)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public List<OrdRegVO> selectPrdMstSapList(OrdRegVO param);
	
	/**
	 * @Method Name : selectMkslPrdList
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준제품 리스트 조회(시판)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public Map<String, Object> selectMkslPrdList(OrdRegVO param);
	
	/**
	 * @Method Name : selectTmprtPrdList
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준제품 리스트 조회(상온)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public Map<String, Object> selectTmprtPrdList(OrdRegVO param);
	
}

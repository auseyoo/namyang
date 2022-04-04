package com.namyang.nyorder.cst.service;

import java.util.List;

import com.namyang.nyorder.cst.vo.CstMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 관리  Service 
 * 파일명  : CstMngService.java
 * 작성자  : DongJoo
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    DongJoo     최조 프로그램 작성
 *
 ****************************************************/
public interface CstMngService {
	
	/**
	 * @Method Name : selectArea
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : DongJoo
	 * @Method 설명 : area 조회
	 * @param param
	 * @return List<CstMngVO>
	 */
	public List<CstMngVO> selectArea(CstMngVO param);

	/** 
	 * @Method Name : selectCstArea
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : DongJoo
	 * @Method 설명 : area - 애음자 조회
	 * @param param
	 * @return List<CstMngVO>
	 */
	public List<CstMngVO> selectCstArea(CstMngVO param);

	
	/** 
	 * @Method Name : selectCstContract
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : DongJoo
	 * @Method 설명 : 애음자 관리 - 배달 정보(탭) - 지역, 애음자 검색 -> 계약 정보
	 * @param param
	 * @return List<CstMngVO>
	 */
	public List<CstMngVO> selectCstContract(CstMngVO param);
	
	List<CstMngVO> selectPopPrdSearchList(CstMngVO param);
	
	int saveFreeDsctPop(List<CstMngVO> list) throws Exception;
	
	int saveCstPrd(CstMngVO param);
	
	int savePdRerv(List<CstMngVO> list) throws Exception;
	
	int saveReDlv(CstMngVO list) throws Exception;
	
	int saveCntrEnd (List<CstMngVO> list) throws Exception;
	

}

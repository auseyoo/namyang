package com.namyang.nyorder.cst.dao;

import java.util.List;

import com.namyang.nyorder.cst.vo.CstMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 관리  Mapper
 * 파일명  : CstMngMapper.java
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
public interface CstMngMapper {

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
	 * @Method 설명 : area 애음자 조회
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
	
	int saveFreeDsctPop(CstMngVO param);
	
	
	public List<CstMngVO> selectPopPrdSearchList(CstMngVO param);
	
	int saveCstPrd(CstMngVO param);
	
	int saveCstPttn(CstMngVO param);
	int saveCstPrdUntpc(CstMngVO param);
	int saveCstPrdPrmt(CstMngVO param);
	
	int savePdRerv(CstMngVO param);
	
	int saveReDlv(CstMngVO param);
	
	int updCstPrdUntpc(CstMngVO param);
	
	

}

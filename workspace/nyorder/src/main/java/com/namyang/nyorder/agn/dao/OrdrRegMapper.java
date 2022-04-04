package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.OrdRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문 등록 Mapper
 * 파일명  : OrdrRegMapper.java
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
public interface OrdrRegMapper {
	/**
	 * @Method Name : selectSdtPrdList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문등록 표준제품 리스트 조회(방판)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public List<OrdRegVO> selectSdtPrdList(OrdRegVO param);
	
	/**
	 * @Method Name : insertOrdMst
	 * @작성일 : 2021. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 마스터 저장
	 * @param param
	 * @return int
	 */
	public int insertOrdMst(OrdRegVO param);
	
	/**
	 * @Method Name : insertOrdPrd
	 * @작성일 : 2021. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 상세 저장
	 * @param param
	 * @return int
	 */
	public int insertOrdPrd(OrdRegVO param);
	
	/**
	 * @Method Name : insertOrdPrd
	 * @작성일 : 2021. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 상세 수정
	 * @param param
	 * @return int
	 */
	public int updateOrdPrd(OrdRegVO param);
	
	/**
	 * @Method Name : selectOrdRegConfirm
	 * @작성일 : 2021. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 내역 확인
	 * @param param
	 * @return OrdRegVO
	 */
	public int selectOrdRegConfirm( OrdRegVO param );
	
	/**
	 * @Method Name : selectOrdSeqKey
	 * @작성일 : 2021. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 PK 조회
	 * @param param
	 * @return OrdRegVO
	 */
	public OrdRegVO selectOrdSeqKey( OrdRegVO param );
	
	/**
	 * @Method Name : selectPrdMstSapList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품 마스터 조회(방판)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public List<OrdRegVO> selectPrdMstSapList(OrdRegVO param);
	
	/**
	 * @Method Name : selectMkslPrdList
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문등록 표준제품 리스트 조회(시판)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public List<OrdRegVO> selectMkslPrdList(OrdRegVO param);
	
	/**
	 * @Method Name : selectTmprtPrdList
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문등록 표준제품 리스트 조회(상온)
	 * @param param
	 * @return List<OrdRegVO>
	 */
	public List<OrdRegVO> selectTmprtPrdList(OrdRegVO param);
	
	/**
	 * @Method Name : selectGrfeCnt
	 * @작성일 : 2021. 2. 08.
	 * @작성자 : 윤이준
	 * @Method 설명 : 총무 존재 여부 조회
	 * @param param
	 * @return int
	 */
	public int selectGrfeCnt( OrdRegVO param );
	
	/**
	 * @Method Name : selectOrderCnt
	 * @작성일 : 2021. 2. 08.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문일 주문여부 조회
	 * @param param
	 * @return int
	 */
	public int selectOrderCnt( OrdRegVO param );
	
	/**
	 * @Method Name : selectGrfrOrdCnt
	 * @작성일 : 2021. 2. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 총무 주문 건수 조회
	 * @param param
	 * @return int
	 */
	public int selectGrfrOrdCnt( OrdRegVO param );
	
	/**
	 * @Method Name : selectAgenClsTmInfo
	 * @작성일 : 2022. 3. 23.
	 * @작성자 : 윤이준
	 * @Method 설명 : 대리점 마감시간 조회
	 * @param param
	 * @return String
	 */
	public String selectAgenClsTmInfo(OrdRegVO param);
}

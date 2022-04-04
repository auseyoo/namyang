package com.namyang.nyorder.std.dao;

import java.util.List;

import com.namyang.nyorder.std.vo.StdPrdBndChgVO;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.std.vo.StdPrdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준벙보관리 - 표준 제품 관리 Mapper
 * 파일명  : StdPrdMngMapper.java
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
public interface StdPrdMngMapper {

	/**
	 * @Method Name : selectPrdMstList
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품 마스터 조회
	 * @param param
	 * @return List<StdPrdMngVO>
	 */
	public List<StdPrdMngVO> selectPrdMstList(StdPrdMngVO param);

	/**
	 * @Method Name : selectStdPrdMngList
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 조회
	 * @param param
	 * @return List<StdPrdMngVO>
	 */
	public List<StdPrdMngVO> selectStdPrdMngList(StdPrdMngVO param);

	/**
	 * @Method Name : selectStdPrdMngDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 상세 조회 
	 * @param param
	 * @return List<StdPrdMngDetailVO>
	 */
	public StdPrdMngDetailVO selectStdPrdMngDetail(StdPrdMngDetailVO param);

	/**
	 * @Method Name : insertStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 등록
	 * @param vo
	 * @return String
	 */
	public int insertStdPrdDetail(StdPrdMngDetailVO vo) ;

	/**
	 * @Method Name : UpdateStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 수정
	 * @param vo void
	 */
	public int UpdateStdPrdDetail(StdPrdMngDetailVO vo);

	/**
	 * @Method Name : delStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 삭제
	 * @param vo void
	 */
	public int delStdPrdDetail(StdPrdMngDetailVO vo);

	/**
	 * @Method Name : updateStdPRdYn
	 * @작성일 : 2022. 1. 13.
	 * @작성자 : YESOL
	 * @Method 설명 : 기존 제품 표준 N 수정
	 * @param vo void
	 */
	public void updateStdPRdYn(StdPrdMngDetailVO vo);
	/**
	 * @Method Name : updateStdPrdOrdr
	 * @작성일 : 2022. 1. 13.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품 표준 순서변경 
	 * @param vo void
	 */
	public void updateStdPrdOrdr(StdPrdMngDetailVO vo);

	/**
	 * @Method Name : updateStdAllPrdOrdr
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품 순서변경 전체 순서 조정
	 * @param vo
	 * @return int
	 */
	public int updateStdAllPrdOrdr(StdPrdMngDetailVO vo);

	/**
	 * @Method Name : insertStdPrdBndChg
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품 일괄 변경 - 등록
	 * @param vo
	 * @return int
	 */
	public int insertStdPrdBndChg(StdPrdBndChgVO vo);

	
	/**
	 * @Method Name : updateStdPrdBndChg
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품 일괄 변경 - 수정
	 * @param vo
	 * @return int
	 */
	public int updateStdPrdBndChg(StdPrdBndChgVO vo);
	
	
	
	/**
	 * @Method Name : delStdPrdBndChg
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품 일괄 변경 - 삭제
	 * @param vo
	 * @return int
	 */
	public int delStdPrdBndChg(StdPrdBndChgVO vo);
	
	
	/**
	 * @Method Name : selectStdPrdBndChgList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품일괄변경 - 리스트 조회 
	 * @param param
	 * @return List<StdPrdBndChgVO>
	 */
	public List<StdPrdBndChgVO> selectStdPrdBndChgList(StdPrdBndChgVO param);

	/**
	 * @Method Name : updateStdPrdBndChgProc
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : YESOL
	 * @Method 설명 :  표준제품일괄변경 - 당일건 변경 적용
	 */
	public void updateStdPrdBndChgProc();
	


}

package com.namyang.nyorder.std.dao;

import java.util.List;

import com.namyang.nyorder.std.vo.StdPchaMngVO;
import com.namyang.nyorder.std.vo.StdPrdCdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 타사제품코드 관리 Mapper
 * 파일명  : StdPrdCdMngMapper.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface StdPrdCdMngMapper {
	
	/**
	 * @Method Name : selectPrdCdPchaList
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 매입처 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<StdPrdCdMngVO> selectPrdCdPchaList(StdPrdCdMngVO param);
	
	/**
	 * @Method Name : selectPrdCdMstList
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 마스터 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<StdPrdCdMngVO> selectPrdCdMstList(StdPrdCdMngVO param);
	
	/**
	 * @Method Name : insertStdPrdCdDetail
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 등록
	 * @param param
	 * @return List<RtgdVO>
	 */
	public int insertStdPrdCdDetail( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : updateStdPrdCdDetail
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 수정
	 * @param param
	 * @return List<RtgdVO>
	 */
	public int updateStdPrdCdDetail( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : removeStdPrdCd
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 삭제
	 * @param param
	 * @return List<RtgdVO>
	 */
	public int removeStdPrdCd( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : getNextPrdDtlCd
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품 코드 생성
	 * @param StdPrdCdMngVO
	 * @return String
	 */
	public String getNextPrdDtlCd( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : insertStdrPrdSpprc
	 * @작성일 : 2022. 2. 28.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품 기준 단가 등록
	 * @param param
	 * @return int
	 */
	public int insertStdrPrdSpprc( StdPrdCdMngVO param );
	
	/**
	 * @Method Name : selectStdrPrdSpprc
	 * @작성일 : 2022. 2. 28.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품기준 단가 조회
	 * @param param
	 * @return StdPrdCdMngVO
	 */
	public StdPrdCdMngVO selectStdrPrdSpprc(StdPrdCdMngVO param);
	
	/**
	 * @Method Name : updateStdrPrdSpprcLastYn
	 * @작성일 : 2022. 2. 28.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품기준 단가 마지막여부 수정( N으로 )
	 * @param param
	 * @return int
	 */
	public int updateStdrPrdSpprcLastYn(StdPrdCdMngVO param);
	
	/**
	 * @Method Name : selectStdPrdMngDetail
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 조회
	 * @param param
	 * @return StdPrdCdMngVO
	 */
	public StdPrdCdMngVO selectStdPrdMngDetail(StdPrdCdMngVO param);
	
	
}

package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.PchaRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 등록 Mapper
 * 파일명  : PchaRegMapper.java
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
public interface PchaRegMapper {
	/**
	 * @Method Name : selectPchaList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<PchaRegVO> selectPchaList(PchaRegVO param);
	
	/**
	 * @Method Name : selectPchaRegList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 제품 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<PchaRegVO> selectPchaRegList(PchaRegVO param);
	
	/**
	 * @Method Name : selectOthComPrdList
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 조회
	 * @param param
	 * @return List<PchaRegVO>
	 */
	public List<PchaRegVO> selectOthComPrdList(PchaRegVO param);
	
	/**
	 * @Method Name : updateOthComPrdYn
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 사용유무 수정
	 * @param param
	 * @return int
	 */
	public int updateOthComPrdYn( PchaRegVO param );
	
	/**
	 * @Method Name : insertOtgOrdPrd
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 등록
	 * @param param
	 * @return int
	 */
	public int insertOtgOrdPrd( PchaRegVO param );
	
	/**
	 * @Method Name : updateOthComPrdLastYn
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입등록 마지막여부 수정
	 * @param param
	 * @return int
	 */
	public int updateOthComPrdLastYn( PchaRegVO param );
	
	/**
	 * @Method Name : selectPchaInfoList
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입등록 정보 조회
	 * @param param
	 * @return PchaRegVO
	 */
	public PchaRegVO selectPchaInfoList( PchaRegVO param );
	
	/**
	 * @Method Name : selectInvryMst
	 * @작성일 : 2022. 3. 8.
	 * @작성자 : 윤이준
	 * @Method 설명 : 재고 테이블 조회
	 * @param param
	 * @return int
	 */
	public int selectInvryMst( PchaRegVO param );
	
	/**
	 * @Method Name : insertInvryMst
	 * @작성일 : 2022. 3. 8.
	 * @작성자 : 윤이준
	 * @Method 설명 : 재고 테이블 등록
	 * @param param
	 * @return int
	 */
	public int insertInvryMst( PchaRegVO param );
	
	/**
	 * @Method Name : insertInvryMstLog
	 * @작성일 : 2022. 3. 8.
	 * @작성자 : 윤이준
	 * @Method 설명 : 재고 테이블 로그등록
	 * @param param
	 * @return int
	 */
	public int insertInvryMstLog( PchaRegVO param );
	
	/**
	 * @Method Name : updateInvryMst
	 * @작성일 : 2022. 3. 8.
	 * @작성자 : 윤이준
	 * @Method 설명 : 재고 테이블 수정
	 * @param param
	 * @return int
	 */
	public int updateInvryMst( PchaRegVO param );
	
	/**
	 * @Method Name : selectYestdInvry
	 * @작성일 : 2022. 3. 8.
	 * @작성자 : 윤이준
	 * @Method 설명 : 전일 재고 조회
	 * @param param
	 * @return PchaRegVO
	 */
	public PchaRegVO selectYestdInvry( PchaRegVO param );
	
	
	/**
	 * @Method Name : selectInvryMstKey
	 * @작성일 : 2022. 3. 8.
	 * @작성자 : 윤이준
	 * @Method 설명 : 재고 시퀀스 조회
	 * @param param
	 * @return PchaRegVO
	 */
	public int selectInvryMstKey( PchaRegVO param );
	
}

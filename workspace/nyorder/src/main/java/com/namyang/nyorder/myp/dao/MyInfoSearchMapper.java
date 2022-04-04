package com.namyang.nyorder.myp.dao;

import java.util.List;

import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;
import com.namyang.nyorder.myp.vo.AgenMstVO;
import com.namyang.nyorder.myp.vo.MyInfoSearchVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 내 정보 조회 Mapper
 * 파일명  : MyInfoSearchMapper.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 3.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 3.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public  interface MyInfoSearchMapper {
	

	/**
	 * @Method Name : selectAgenMst
	 * @작성일 : 2022. 1. 4.
	 * @작성자 : YESOL
	 * @Method 설명 : 대리점 정보 조회 (임시: 차후 SAP에서 조회)
	 * @param param
	 * @return AgenMstVO
	 */
	public AgenMstVO selectAgenMst(MyInfoSearchVO param);
	
	/**
	 * @Method Name : selectAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 입금 계좌 리스트 조회
	 * @param vo
	 * @return List<AgenAcctInfoVO>
	 */
	public List<AgenAcctInfoVO> selectAgenAcctInfo(MyInfoSearchVO param);
	
	/**
	 * @Method Name : insertAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 입금 계좌 등록
	 * @param vo
	 * @return int
	 */
	public int insertAgenAcctInfo(AgenAcctInfoVO vo);
	/**
	 * @Method Name : updateAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 입금 계좌 수정
	 * @param vo
	 * @return int
	 */
	public int updateAgenAcctInfo(AgenAcctInfoVO vo);


}

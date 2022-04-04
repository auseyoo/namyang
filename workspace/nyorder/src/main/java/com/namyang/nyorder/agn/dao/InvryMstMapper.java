package com.namyang.nyorder.agn.dao;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 재고 관리 Mapper
 * 파일명  : InvryMstMapper.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 14.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface InvryMstMapper {

	/**
	 * @Method Name : selectPuchList
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 매입처 리스트 조회
	 * @param param
	 * @return List<InvryMstVO>
	 */
	public List<InvryMstVO> selectPuchList(InvryMstVO param);

	/**
	 * @Method Name : selectInvryMstList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 리스트 조회
	 * @param param
	 * @return List<InvryMstVO>
	 */
	public List<InvryMstVO> selectInvryMstList(InvryMstVO param);
	
	/**
	 * @Method Name : updInvryMst
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 저장
	 * @param param
	 * @return null
	 */
	public void updInvryMst(InvryMstVO param);

	/**
	 * @Method Name : insInvryMstLog
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 로그 저장
	 * @param param
	 * @return null
	 */
	public void insInvryMstLog(InvryMstVO param);
	
	/**
	 * @Method Name : updStdPrdInvryAfterUpd
	 * @작성일 : 2022. 2. 21.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 변경 이후일자 자동 업데이트
	 * @param param
	 * @return null
	 */
	public void updStdPrdInvryAfterUpd(InvryMstVO param);
	
	/**
	 * @Method Name : updateInvryWrhsBefPrmtChg
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 수정/삭제 처리 이전에, 기존 판촉물 입고수량->재고테이블 입고수량에서 '-' 처리하기
	 * @param param
	 * @return null
	 */
	public void updInvryWrhsBefPrmtChg(InvryMstVO param);
	
	/**
	 * @Method Name : updateInvryWrhsAfterPrmtChg
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 등록/수정/삭제 처리 이후에, 재고테이블 입고수량 적용
	 * @param param
	 * @return null
	 */
	public void merInvryWrhsAfterPrmtChg(InvryMstVO param);
}

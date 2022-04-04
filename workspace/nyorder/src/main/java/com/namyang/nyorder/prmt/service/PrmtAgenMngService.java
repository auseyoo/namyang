package com.namyang.nyorder.prmt.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.prmt.vo.PrmtAgenMngVO;
import com.namyang.nyorder.prmt.vo.PrmtAgenRqstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 입고 관리 Service
 * 파일명  : PrmtAgenMngService.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtAgenMngService {
	
	/**
	 * @Method Name : selectPrmtAgenMngList
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPrmtAgenMngList(PrmtAgenMngVO param);	
	
	/**
	 * @Method Name : savePrmtAgenMng
	 * @작성일 : 2022. 2. 28.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 저장
	 * @param param
	 * @return PrmtAgenMngVO
	 */
	public String savePrmtAgenMng(List<PrmtAgenMngVO> list);	

	/**
	 * @Method Name : updateInvryWrhsBefPrmtChg
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고마스터 - 입고수량 갱신
	 * @param param
	 * @return void
	 */
	public void updateInvryWrhsBefPrmtChg(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : updateInvryWrhsAfterPrmtChg
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고마스터 - 입고수량 갱신
	 * @param param
	 * @return void
	 */
	public void updateInvryWrhsAfterPrmtChg(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : selectPrmtList
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPrmtList(PrmtAgenMngVO param);
}



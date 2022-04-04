package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.CrtbRtgdVO;
import com.namyang.nyorder.agn.vo.InvryMstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 크레이트 반납 관리 Service
 * 파일명  : CrtbRtgdService.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 15.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface CrtbRtgdService {
	
	/**
	 * 크레이트 반납 데이터 조회
	 */
	/**
	 * @Method Name : selectCrtbRtgdList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 데이터 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectCrtbRtgdList(CrtbRtgdVO param);	
	
	/**
	 * 크레이트 조회
	 */
	/**
	 * @Method Name : selectCrtbCdList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public List<CrtbRtgdVO> selectCrtbCdList(CrtbRtgdVO param);
	
	/**
	 * @Method Name : saveCrtbRtgd
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 저장
	 * @param param
	 * @return CrtbRtgdVO
	 */
	public String saveCrtbRtgd(List<CrtbRtgdVO> list);		
	
}



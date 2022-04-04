package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품/반송 조회 Service
 * 파일명  : RtgdService.java
 * 작성자  : LEEJUN
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 04.    LEEJUN     최조 프로그램 작성
 *
 ****************************************************/
public interface RtgdService {
	
	/**
	 * @Method Name : selectRtngudList
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : LEEJUN
	 * @Method 설명 : 반품/반송 리스트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectRtngudList(RtgdVO param);
	
	/**
	 * @Method Name : selectRtgdConfmList
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품확인서 리스트 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectRtgdConfmList(RtgdVO param);
}

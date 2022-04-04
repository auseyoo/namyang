package com.namyang.nyorder.agn.service;

import java.util.Map;

import com.namyang.nyorder.agn.vo.OrdrDcsnDlyVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문확정/배송조회  Service
 * 파일명  : OrdrDcsnDlyService.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 15.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 15.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface OrdrDcsnDlyService {
	
	/**
	 * @Method Name : selectOrdrDcsnDlyList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문 리스트 조회
	 * @param param
	 * @return Map<String, Object>
	 */
	public Map<String, Object> selectOrdrDcsnDlyList(OrdrDcsnDlyVO param);
}

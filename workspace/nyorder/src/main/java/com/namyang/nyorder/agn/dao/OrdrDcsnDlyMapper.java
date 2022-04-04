package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.OrdrDcsnDlyVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문확정/배송조회 Mapper
 * 파일명  : OrdrDcsnDlyMapper.java
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
public interface OrdrDcsnDlyMapper {
	/**
	 * @Method Name : selectOrdrDcsnDlyList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문/확정 배송 리스트 조회
	 * @param param
	 * @return List<OrdrDcsnDlyVO>
	 */
	public List<OrdrDcsnDlyVO> selectOrdrDcsnDlyList(OrdrDcsnDlyVO param);
}

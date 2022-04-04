package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품/반송 조회 Mapper
 * 파일명  : RtgdMapper.java
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
public interface RtgdMapper {
	
	/**
	 * @Method Name : selectRtngudList
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : LEEJUN
	 * @Method 설명 : 반품/반송 리스트 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectRtngudList(RtgdVO param);

	/**
	 * @Method Name : selectRtgdConfmList
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품확인서 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectRtgdConfmList(RtgdVO param);
}

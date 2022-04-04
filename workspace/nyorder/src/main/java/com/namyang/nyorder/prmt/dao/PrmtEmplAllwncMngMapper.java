package com.namyang.nyorder.prmt.dao;

import java.util.List;

import com.namyang.nyorder.prmt.vo.PrmtEmplAllwncMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 수당 관리 Mapper
 * 파일명  : PrmtEmplAllwncMngMapper.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtEmplAllwncMngMapper {
	
	/**
	 * @Method Name : selectPrmtEmplAllwncList
	 * * @작성일 : 2022. 3. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 리스트 조회
	 * @param param
	 * @return List<PrmtEmplAllwncMngVO>
	 */
	public List<PrmtEmplAllwncMngVO> selectPrmtEmplAllwncList(PrmtEmplAllwncMngVO param);
	
	/**
	 * @Method Name : updatePrmtEmplAllwnc
	 * @작성일 : 2021. 3. 16.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 수정
	 * @param param
	 * @return int
	 */
	public int updatePrmtEmplAllwnc(PrmtEmplAllwncMngVO param);
}

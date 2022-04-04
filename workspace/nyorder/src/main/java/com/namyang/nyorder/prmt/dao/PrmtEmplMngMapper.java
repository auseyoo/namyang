package com.namyang.nyorder.prmt.dao;

import java.util.List;

import com.namyang.nyorder.prmt.vo.PrmtEmplMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 관리 Mapper
 * 파일명  : PrmtEmplMngMapper.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 14.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtEmplMngMapper {
	
	/**
	 * @Method Name : selectPrmtEmplMngList
	 * * @작성일 : 2022. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 리스트 조회
	 * @param param
	 * @return List<PrmtEmplMngVO>
	 */
	public List<PrmtEmplMngVO> selectPrmtEmplMngList(PrmtEmplMngVO param);
	
	/**
	 * @Method Name : updatePrmtEmplHis
	 * @작성일 : 2021. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 수정
	 * @param param
	 * @return int
	 */
	public int updatePrmtEmplHis(PrmtEmplMngVO param);
	
}

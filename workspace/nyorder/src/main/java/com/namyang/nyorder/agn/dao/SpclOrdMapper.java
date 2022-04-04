package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.SpclOrdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 특수처 주문 조회 Mapper
 * 파일명  : SpclOrdMapper.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 22.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 22.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface SpclOrdMapper {
	/**
	 * @Method Name : selectSpclOrdList
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문 리스트 조회
	 * @param param
	 * @return List<SpclOrdVO>
	 */
	public List<SpclOrdVO> selectSpclOrdList( SpclOrdVO param );
}

package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.SchlMealOrdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 학교급식 주문 조회 Mapper
 * 파일명  : SchlMealOrdMapper.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 14.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface SchlMealOrdMapper {
	/**
	 * @Method Name : selectSchlMealOrdList
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문등록 학교 리스트 조회
	 * @param param
	 * @return List<SchlMealOrdVO>
	 */
	public List<SchlMealOrdVO> selectSchlMealOrdList(SchlMealOrdVO param);
}

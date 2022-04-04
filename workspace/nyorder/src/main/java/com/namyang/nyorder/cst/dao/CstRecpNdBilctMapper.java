package com.namyang.nyorder.cst.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.namyang.nyorder.cst.vo.CstRecpNdBilctVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 방문영수증 및 수금자료 Mapper
 * 파일명  : CstRecpNdBilctInfoMapper.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 25.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 25.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Repository
public interface CstRecpNdBilctMapper {
	/**
	 * @Method Name : selectRecpTargetList
	 * @작성일 : 2022. 3. 28.
	 * @작성자 : 이웅일
	 * @Method 설명 : 애음자 영수증조회
	 * @param param
	 * @return List<CstRecpNdBilctVO>
	 */
	public List<CstRecpNdBilctVO> selectRecpTargetList(CstRecpNdBilctVO param);
}

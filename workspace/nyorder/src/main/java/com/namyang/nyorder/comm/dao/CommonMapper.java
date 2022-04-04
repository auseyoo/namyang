package com.namyang.nyorder.comm.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.namyang.nyorder.comm.vo.CstMstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 공통 코드 관리 Mapper
 * 파일명  : CommCodeMapper.java
 * 작성자  : YESOL
 * 작성일  : 2021. 12. 31.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 12. 31.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Repository
public interface CommonMapper {

	public List<CstMstVO> selectAddr(CstMstVO param);

	
}

package com.namyang.nyorder.comm.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.namyang.nyorder.cmmc.vo.NttVO;
import com.namyang.nyorder.comm.vo.CommVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 메인화면 Mapper
 * 파일명  : MainCodeMapper.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 3. 28.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 28.    	JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Repository
public interface MainMapper {

	public List<NttVO> selectMainNotice();

	public int selectOrdTotAmount(CommVO param);
}

package com.namyang.nyorder.myp.vo;

import java.util.List;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 내 정보 조회 VO
 * 파일명  : MyInfoSearchVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 4.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class MyInfoSearchVO extends CommVO{
	private AgenMstVO agenMst;
	private List<AgenAcctInfoVO> acctInfoList;
}

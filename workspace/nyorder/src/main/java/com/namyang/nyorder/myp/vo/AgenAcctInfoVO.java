package com.namyang.nyorder.myp.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : T_AGEN_ACCT_INFO - 대리점 계좌정보 VO
 * 파일명  : AgenAcctInfoVO.java
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
public class AgenAcctInfoVO extends CommVO {
	private String acctSeq;
	private String acctCd;
	private String bankCd;
	private String stmAcctNo;
	private String acctDpsr;
	private int ordr;
}

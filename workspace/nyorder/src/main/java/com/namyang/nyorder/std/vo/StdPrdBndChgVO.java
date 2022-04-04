package com.namyang.nyorder.std.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 제품 일괄 변경  VO
 * 파일명  : StdPrdBndChgVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 25.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 25.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class StdPrdBndChgVO extends CommVO {
	private String prdBndChgSeq;
	private String prdDtlSeq;
	private String prdSapCd;
	private String prdNm;
	private String puchSeq;
	private String prdSeq;
	private String chgPrdSeq;
	private String chgPrdSapCd;
	private String chgPrdNm;
	private String applDt;
	private String applYn;
	private String useYn;
}

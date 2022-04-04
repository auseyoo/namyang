package com.namyang.nyorder.prmt.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 소요량 요청 관리
 * 파일명  : PrtmAgenRqstVO.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class PrmtAgenRqstVO extends CommVO{
	
	private String prmtAgenSeq;

	private String puchSeq;
	private String prdSeq;
	private String prdSapCd;
	private String prdNm;
	private String prdPayYn;
	private String faltQty;
	private String iddyOrdYn;
		
	private String prmtRqstSeq;
	private String agenBoxQty;
	private String agenIddyQty;
	private String agenQty;
	private String agenOrdDtm;
	private String bhfcBoxQty;
	private String bhfcIddyQty;
	private String bhfcDcsnDtm;
	private String hoffBoxQty;
	private String hoffIddyQty;
	private String hoffDcsnDtm;
	private String untpc;
	private String spprc;
	private String vatSpprc;
	
	private String totCt;
	private String totVatCt;
	private String totAmount;
	
	private String hoffQty;
	private String hoffAmount;
	private String diffQty;
	
	//요청월 정보
	private String dvyfgRqstMonth;
	private String agenClsDt;
	private String bhfcClsDt;
	private String hoffClsDt;
	private String dcsnYn;
	
	//검색
	private String reqYm;
	private String searchPrdCd;
	private String searchPrdNm;
}

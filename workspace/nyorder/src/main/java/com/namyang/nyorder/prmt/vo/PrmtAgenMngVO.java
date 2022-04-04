package com.namyang.nyorder.prmt.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 입출고 관리
 * 파일명  : PrmtAgenMngVO.java
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
public class PrmtAgenMngVO extends CommVO{

	private String rnum;
	private String bhfcSeq;
	private String agenSeq;	

	//공통
	private String wrhsBoxQty;
	private String wrhsIddyQty;
	private String wrhsDt;
	private String prdCd;	
	private String prdNm;
	private String spprc;
	private String vatSpprc;
	private String agenQty;
	private String hoffQty;
	private String wrhsQty;
	private String hoffAmount;
	private String diffQty;
	
	//판촉물 소요량 입고 관리
	private String prmtAgenMngSeq;
	private String prdSeq;
	private String puchSeq;
	private String prmtRqstSeq;
	private String prmtAgenSeq;

	//타사 판촉물 입고 관리
	private String othComPrmtSeq;
	private String dvyfgRqstMonth;
	private String prdDtlSeq;
	private String freeYn;
	private String faltQty;
	private String iddyOrdYn;
	private String rqstQty;
	private String dcsnQty;
	private String untpc;
	private String totCt;
	private String totVatCt;
	private String totAmount;
	private String prdDtlCd;
	
	//검색
	private String reqYm;
	private String searchPrdCd;
	private String searchPrdNm;
	
	private String searchPart;
	private String searchTxt;
	
	private String searchPrmtAgenMngSeq;
	private String searchOthComPrmtSeq;
	
}

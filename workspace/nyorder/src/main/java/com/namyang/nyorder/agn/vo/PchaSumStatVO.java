package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입집계 현황 VO
 * 파일명  : PchaSumStatVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 20.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 20.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class PchaSumStatVO extends CommVO{
	private int puchSeq;			// 매입처 시퀀스
	private String puchCd;			// 매입처 코드
	private String puchNm;			// 매입처 명
	
	private int prdDtlSeq;			//주문상세 시퀀스
	private String prdDtlCd;		//자체코드
	private String stdPrdNm;		//표준제품명
	private int untpc;				//매입단가
	private int faltQty;			//입수량
	private String taxtCd;			//과세구분
	
	private String ordStusList;
	
	private String startDt;
	private String endDt;
	private String monList;
	private String startMon;
	private String endMon;
}

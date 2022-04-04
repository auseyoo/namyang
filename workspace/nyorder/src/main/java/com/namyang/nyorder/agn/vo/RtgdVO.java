package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품/반송 조회 VO
 * 파일명  : RtgdVO.java
 * 작성자  : LEEJUN
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 4.    LEEJUN     최조 프로그램 작성
 * 2022. 1. 26.   JUNGAE     반품/반송조회 그리드 데이터 조회
 *
 ****************************************************/
@Getter
@Setter
public class RtgdVO extends CommVO{

	private String rownum;
	private String ordRtgdSeq;
	private String ordStusCd;
	private String prdSapCd;
	private String prdDtlSeq;
	private String prdDtlCd;
	private String prdNm;						
	private String rtgdSec;	
	private String rtgdSecTxt;	
	private String inPath;						
	private int faltQty;						
	private int reqBoxQty;						
	private int reqIddyQty;						
	private int reqQty;						
	private int dcsnBoxQty;						
	private int dcsnIddyQty;						
	private int dcsnQty;						
	private int untpc;						
	private String taxtCd;	
	private int spprc;						
	private int vatSpprc;
	private int totAmount;
	private String reqDt;						
	private String dcsnDt;	
	private String trnstYn;	
	private String errMsg;
	
	private String reqYm;
	private String searchPart;
	private String searchTxt;
}

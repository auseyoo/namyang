package com.namyang.nyorder.myp.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : T_AGEN_MST 대리점 마스터 VO
 * 파일명  : AgenMstVO.java
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
public class AgenMstVO extends CommVO {
	private String agenCd;
	private String agenNm;
	private String bizNo;
	private String jurNo;
	private String saleCd;
	private String agenPrst;
	private String bizCon;
	private String bizIndu;
	private String zipCd;
	private String addr1;
	private String addr2;
	private String telNo;
	private String prstTelNo;
	private String faxNo;
	private String cashRecpUseYn;
	private String agenEml;
	private String agenUseYn;
	private String clsYnCd;
}

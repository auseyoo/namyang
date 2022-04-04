package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 재고 관리 VO
 * 파일명  : CrtbRtgdVO.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 14.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class CrtbRtgdVO extends CommVO{
	
	private int ord;
	private String selDt;
	private String reqYm;
	private String selLastYmd;
	
	private int crtbRtgdSeq;
	private String prdNm;
	private String rtgdDt;
	private String crtbCd;
	private int yestdQty;
	private int dlvyQty;
	private int reptQty;
	private int coletQty;
	private int rtgdQty;
	private int invryQty;
}

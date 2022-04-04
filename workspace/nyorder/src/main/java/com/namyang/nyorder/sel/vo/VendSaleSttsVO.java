package com.namyang.nyorder.sel.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 월별 매출 현황 VO
 * 파일명  : MnthSaleSttsVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 2. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 10.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class VendSaleSttsVO extends CommVO{
	private String saleDt;
	private int saleQty;
	private int rtgdQty;
	private int prsntQty;
	private int exchgQty;
	private int rtgdCt;
	private int saleCt;
	private int puchQty;
	
	private String suCt;
	private String vatCt;
	private String saleAmt;

	private String srcType;
	private String srcStartDate;
	private String srcEndDate;
	private String srcStartMonth;
	private String srcEndMonth;

	private String emplNm;
	private String agenSeq;
	private String vendSeq;
	private String vendNm; 
	private String vendCd;
}

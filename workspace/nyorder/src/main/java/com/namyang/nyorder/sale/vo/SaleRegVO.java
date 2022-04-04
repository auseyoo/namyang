package com.namyang.nyorder.sale.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매등록 VO
 * 파일명  : SaleRegVO.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 3.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class SaleRegVO extends CommVO{
	private String targetAgenSeq;
	private String targetEmplSeq;
	private String emplNm;
	private String vendSeq;
	private String vendCd;
	private String vendSecCd;
	private String vendSecNm;
	private String vendNm;
	private String useYn;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String vendSaleSeq;
	private String vendSaleDtlSeq;
	private String prdSeq;
	private String prdDtlSeq;
	private String prdNm;
	private String prdSapCd;
	private String prdDtlCd;
	private String saleDt;
	private String faltQty;
	private String pchaUntpc;
	private String saleCt;
	private String rtgdCt;
	private String saleQty;
	private String prsntQty;
	private String rtgdQty;
	private String exchgQty;
	private String speclUntpcYn;
	private String iddyPchaCt;
	private String saleUntpc;
	private String puchSeq;
	private String vendBillSeq;
	private String sumCt;
	private String totPchaCt;
	private String delgAtmptCt;
	private String rlSaleCt;
	private String cashBilct;
	private String cashExcpBilct;
	private String prdDcRate;
	private String prdDcCt;
	private String insPrdDcRate;
	private String insPrdDcCt;
	private String totDcRate;
	private String totDcCt;
	private String atmptCt;
	private String fee;
	private String boxSum;
	private String iddySum;
	private String monthSaleTotCt;
	private String monthDsctTotCt;
	private String monthBilctTotCt;
	private String billDt;
	private String removeYn;
	private String editableYn;

	private String schType;
	private String schTxt;
	private String schStatBillDt;
	private String schEndBillDt;

}

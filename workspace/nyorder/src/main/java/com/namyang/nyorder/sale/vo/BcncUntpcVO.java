package com.namyang.nyorder.sale.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 단가관리 VO
 * 파일명  : BcncUntpcVO.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 2. 3.
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
public class BcncUntpcVO extends CommVO{
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
	private String vendUntpcSeq;
	private String prdSeq;
	private String prdDtlSeq;
	private String saleUntpc;
	private String saleUntpcCt;
	private String saleUntpcVat;
	private String brcd;
	private String iddyBrcd;
	private String etcBrcd;
	private String faltQty;
	private String uptDtm;
	private String uptSeq;
	private String prdNm;
	private String prdSapCd;
	private String prdDtlCd;
	private String iddyPchaCt;
	private String mrgnRate;
	private String mrgn;
	private String applDt;
	private String untpcStusSec;
	private String vendUntpcChgSeq;
	private String befPrdDtlSeq;
	private String aftPrdDtlSeq;
	private String befUntpcSeq;
	private String aftUntpcSeq;
	private String applYn;
	private String puchSeq;
	private String befPrdNm;
	private String befPrdCd;
	private String befSaleUntpc;
	private String aftPrdNm;
	private String aftPrdCd;
	private String aftSaleUntpc;
	private String speclUntpcYn;
	private String saleYn;
	private String bndYn;
	private String removeYn;

	private String puchNm;
	private String puchCd;
	private String chgType;
	private String chgTypeNm;
	private String chgMrgnRate;
	private String chgMrgn;
	private String chgUntpcSeq;
	private String chgSaleUntpc;
	private String chgApplDt;

	private String schType;
	private String schTxt;

}

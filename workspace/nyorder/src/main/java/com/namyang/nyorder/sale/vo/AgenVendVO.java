package com.namyang.nyorder.sale.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처 VO
 * 파일명  : AgenVendVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 * 2022. 1.17.    이웅일      대리점 담당자 관련 항목 추가
 *
 ****************************************************/
@Getter
@Setter
public class AgenVendVO extends CommVO{
	private String targetAgenSeq;
	private String targetEmplSeq;
	private String emplNm;
	private String vendSeq;
	private String vendCd;
	private String vendSecCd;
	private String vendSecNm;
	private String vendNm;
	private String indtCl;
	private String vendPrst;
	private String bizNo;
	private String jurNo;
	private String bizCon;
	private String bizIndu;
	private String vendChag;
	private String vendChagNm;
	private String telNo;
	private String mobNo;
	private String faxNo;
	private String zipCd;
	private String addr1;
	private String addr2;
	private String clsDe;
	private String cntrCd;
	private String vendGtn;
	private String bankCd;
	private String stmAcctNo;
	private String stmDe;
	private String pymMth;
	private String hoffCnsgYn;
	private String cnsgVendCd;
	private String txblPbctYn;
	private String mrgnYn;
	private String brcdPrtYn;
	private String vendStusSec;
	private String vendStusSecNm;
	private String fullAddr;
	private String prstMobNo;
	private String vendEml;
	private String regNm;
	private String updNm;
	private String statDt;
	private String clsDt;
	private String strSecCd;
	private String acctDpsr ;
	private String stmDtCd ;
	private String vendDlvCycle;
	private String saleUntpc;

	/*지원관리*/
	private String vendSprtSeq;
	private String vendSprtSec;
	private String hoffAlotm;
	private String agenAlotm;
	private String ctStatDt;
	private String ctMemo;
	private String subsidSec;
	private String subsidRate;
	private String subsidCt;
	private String subsidStatDt;
	private String subsidClsDt;
	private String sprtPrdSeq;
	private String sprtPrdDtlSeq;
	private String sprtPrdCd;
	private String sprtPrdNm;
	private String prdQty;
	private String prdCt;
	private String prdStatDt;
	private String sprtEqpmnCd;
	private String sprtEqpmnNm;
	private String eqpmnQty;
	private String eqpmnStatDt;
	private String eqpmnClsDt;
	private String eqpmnCt;
	private String etcCt;
	private String etcStatDt;
	private String etcMemo;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String useYn;
	private String updbtn;

	private String schEmplSeq;
	private String schStatDt;
	private String schEndDt;
	private String schUseYn;
	private String schType;
	private String schTxt;


}

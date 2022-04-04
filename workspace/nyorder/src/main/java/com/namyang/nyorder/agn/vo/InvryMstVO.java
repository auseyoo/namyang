package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 재고 관리 VO
 * 파일명  : InvryMstVO.java
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
public class InvryMstVO extends CommVO{
	
	// 매입처 정보
	private String puchSeq;			
	private String puchCd;			
	private String puchNm;			
	
	// 재고 정보
	private String invrySeq;
	private String prdDtlSeq;
	private String prdSeq;
	private String prdSapCd;
	private String stdrDt;
	private String prdNm;
	private String faltQty;
	private String yestdBoxQty;
	private String yestdIddyQty;
	private String wrhsBoxQty;
	private String wrhsIddyQty;
	private String saleBoxQty;
	private String saleIddyQty;
	private String rtgdBoxQty;
	private String rtgdIddyQty;
	private String prsntBoxQty;
	private String prsntIddyQty;
	private String exchgBoxQty;
	private String exchgIddyQty;
	private String invryChgBoxQty;
	private String invryChgIddyQty;
	private String invryBoxQty;
	private String invryIddyQty;
	
	private String searchPart;
	private String searchPuchSeq;
}

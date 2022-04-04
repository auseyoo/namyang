package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 등록 VO
 * 파일명  : PchaRegVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 19.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 19.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class PchaRegVO extends CommVO{
	private int prdDtlSeq;			// 제품상세 시퀀스
	private String agenSeq;			// 대리점 시퀀스
	private String puchSeq;			// 매입처 시퀀스
	private String prdDtlCd;		//자체 코드
	private String stdPrdNm;		//제품명
	private int faltQty;			//입수량(포장수량)
	private String taxtCd;			//과세구분
	private int untpc;				//매입가
	private int spprc;				//매입가(공급)
	private int vat;				//매입가(VAT)
	private int reqBoxQty;			//주문신청 수량(박스)
	private int reqIddyQty;			//주문확정 수량(박스)
	private String othComPrdYn;		//타사제품 사용유무
	
	private String puchCd;			//매입처 코드
	private String puchNm;			//매입처명
	
	private int othOrdPrdSeq;		//타사제품 매입 시퀀스
	private String ordStusDt;		//매입일
	private int boxQty;				//입고 수량 박스
	private int iddyQty;			//입고 수량 낱봉
	private String lastYn;			//마지막 여부
	
	private int invrySeq;			//재고 시퀀스
	private int invryLogSeq;		//재고 로그 시퀀스
	private String stdrDt;			//기준일
	private int yestdBoxQty;		//전일재고 BOX
	private int yestdIddyQty;		//전일재고 낱봉
	private int wrhsBoxQty;			//입고 BOX
	private int wrhsIddyQty;		//입고 낱봉
	private int saleBoxQty;			//판매 BOX
	private int saleIddyQty;		//판매 낱봉
	private int rtgdBoxQty;			//반품 BOX
	private int rtgdIddyQty;		//반품 낱봉
	private int prsntBoxQty;		//증정 BOX
	private int prsntIddyQty;		//증정 낱봉
	private int exchgBoxQty;		//교환 BOX
	private int exchgIddyQty;		//교환 낱봉
	private int invryChgBoxQty;		//재고 조정 BOX
	private int invryChgIddyQty;	//재고 조정 낱봉
	private int invryBoxQty;		//현재고 BOX
	private int invryIddyQty;		//현재고 낱봉
	
	private String regDtm;			//등록일
	private String regSeq;			//등록자
	private String updDtm;			//수정일
	private String updSeq;			//수정자
	
	private String crudMode;
}

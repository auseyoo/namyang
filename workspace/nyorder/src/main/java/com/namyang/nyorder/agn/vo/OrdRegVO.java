package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문 등록 VO
 * 파일명  : OrdRegVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 25.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 25.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class OrdRegVO extends CommVO{
	private int vendSeq;				// 거래처 시퀀스
	private String schlYn;				// 학교 여부
	
	private int prdSeq;					// 제품 시퀀스
	private int puchSeq;				// 매입처 시퀀스
	private int ordSeq;
	private int ordPrdSeq;
	private String iddyPchaCt;			//매입단가(제품상세)
	private String prdDtlSeq;
	
	private String reqBoxQty;
	private String reqIddyQty;
	private String ordDt;
	private String ordStus;
	
	private String storReqBoxQty;		// 점수 BOX 주문량
	private String storReqIddyQty;		// 점수 낱봉 주문량
	private String grfrReqBoxQty;		// 총무 BOX 주문량
	private String grfrReqIddyQty;		// 총무 낱봉 주문량
	
	private String ytdReqBoxQty;		// 전날 박스 주문량
	private String ytdReqIddyQty;		// 전날 낱봉 주문량
	private String bfytdReqBoxQty;		// 전전날 BOX 주문량
	private String bfytdReqIddyQty;		// 전전날 낱봉 주문량
	private String availAmt;			// 여신 잔액
	
	private String puchNm;				// 매입처 명
	private String prdSapCd;			// 제품 코드
	private String prdNm;				// 제품명
	private String lcls;				// 대분류
	private String mcls;				// 중분류
	private String scls;				// 소분류
	private String dcls;				// 세분류
	private String lclsNm;				// 대분류명
	private String mclsNm;				// 중분류명
	private String sclsNm;				// 소분류명
	private String dclsNm;				// 세분류명
	private String prmtCd;				// 판촉물구분, 팜스에 미존재
	private String faltCt;				// 포장비, 팜스에 미존재
	private String brcd;				// 바코드(박스)
	private String iddyBrcd;			// 바코드(낱개)
	private String iddyUntYn;			// 낱봉주문 가능여부
	private String iddyUntYnTx;			// 낱봉주문 가능여부 텍스트
	private String faltQty;				// 내입량(포장수량)
	private String prdStrd;				// 규격
	private String puchYn;				// 메이저 매입처 여부
	private String taxtCd;				// 과세구분
	private String ordUseYn;			// 주문 가능 여부(Y/N)
	private String ordUseYnTx;			// 주문 가능 여부(주문가능, 주문불가)
	private String feeUntpc;			// 수수료 단가
	private String iddyUntpc;			// 낱개단가
	private String spprc;				// 공장도가(공급)
	private String vatSpprc;			// 공장도가(VAT)
	private String valdPd;				// 유통기간
	private String prdUnit;				// 단위
	private String rtgdPermTn;			// 반품허용유무
	private String untpcApplDt;			// 단가적용일
	private String shtnNm;				// 제품 약어(남양)
	private String prdType;				// 제품 타입(팜스)
	private String prdTypeNm;			// 제품 타입명
	private String ordPd;				// 주문 리드타임(배송일)
	private String etcBrcd;				// 기타바코드 (팜스:바코드3)
	private String useYn;			 	// 사용여부
	private String useYnTx;				// 사용여부 (텍스트)
	private String regDtm;				// 등록일
	private String regSeq;				// 등록자
	private String updDtm;				// 수정일
	private String updSeq;				// 수정자
	private String untpc;				// 단가
	private String stdPrdNm;			// 제품명
	private String ordChk;				// 주문가능여부
	private String baseChk;				// 표준제품제외여부
	private String clsTm;				// 마감시간
	private String ordType;				// 주문 유형
	private String dlvDt;				// 출고요청일
	private String invryBoxQty;			// 현재고 BOX
	private String invryIddyQty;		// 현재고 낱봉
	
	private String srcType;
	private String srcKeyword;
	private String srcPrdNm;
	private String srcPrdCd;
	
	private String [] ordPdList;
}

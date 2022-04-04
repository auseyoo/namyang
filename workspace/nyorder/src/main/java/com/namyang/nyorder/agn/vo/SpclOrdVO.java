package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 특수처 주문 조회 VO
 * 파일명  : SpclOrdVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 22.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 22.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class SpclOrdVO extends CommVO{
	private int ordSeq;				// 주문 시퀀스
	private int prdDtlSeq;			// 제품상세 시퀀스
	private int totalReqBoxQty;		// 주문량 BOX
	private int totalReqIddyQty;	// 주문량 낱봉
	private String prdNm;			// 제품이름
	private String prdSapCd;		// 제품코드
	private int faltQty;			// 입수량
	private String ordDt;			// 주문일
	private String carNo;			// 차량번호
	private String drivNm;			// 기사명
	private String startTm;			// 출발시간
	private String pratTm;			// 예정시간
	private String telNo;			// 배송기사 연락처
	private String cosDt;			// 배송일
	private String ordType;			// 주문 유형
	
	private int untpc;				// 매입단가
	private String taxtCd;			// 과세 여부
	private String stdrDate;		// 기준일자
	private String searchType;		// 검색타입
}

package com.namyang.nyorder.std.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 타사제품코드 관리 VO
 * 파일명  : StdPrdCdMngVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class StdPrdCdMngVO extends CommVO{
	private int prdDtlSeq;			//제품상세 시퀀스
	private int stdrSpprcSeq;		//제품 단가 시퀀스
	private String puchSeq;			//매입처 시퀀스
	private String puchNm;			//매입처 명
	private String puchCd;			//매입처 코드
	
	private String stdPrdNm;		//표준제품명
	private String taxtCd;			//과세/면세 구분
	private int spprc;				//공급가액
	private int untpc;				//매입단가
	private String prdOrdr;			//제품순서
	private String useYn;			//사용유무
	private String lastYn;			//마지막여부
	private String stdPrdYn;		//표준제품여부
	private String prdType;			//자재유형
	private int faltQty;			//입수량(포장수량)
	
	private int vat;				//VAT
	private String brcd;			//바코드(박스)
	private String iddyBrcd;		//바코드(낱개)
	private String etcBrcd;			//기타바코드
	private String suiteNm;			//제푼군명
	private String iddyStdr;		//낱개기준
	private String nextPrdDtlCd;
	private String prdDtlCd;		//자체코드
	
	private String regDtm;			//등록일
	private String regSeq;			//등록자
	private String updDtm;			//수정일
	private String updSeq;			//수정자
	
	private String crudMode;
}

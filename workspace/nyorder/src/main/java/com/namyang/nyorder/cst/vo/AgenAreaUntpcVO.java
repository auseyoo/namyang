package com.namyang.nyorder.cst.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgenAreaUntpcVO {
	
	private String areaPrdSeq;
	private String cstSpprcSeq;
	private String agenSeq;
	private String areaNm;
	private String areaSeq; 
	private String emplSeq;
	private String emplNm;
	private String prdSeq;
	private String prdNm;
	private String prdDtlCd;
	private String prdDtlSeq;
	private String puchSeq;
	private int untpc;
	private int spprc;
	private int vatCt;
	private int emplUntpc; // (애음자탭) 판매원 단가
	private int cstUntpc;
	private String emplMrgnCt; // (애음자탭) 판매원 마진
	private String chgApplDt; // 변경 예정 날짜
	private String chgUntpc; // 변경 예정 단가
	private String chgSpprc; 
	private String chgVatCt; 
	private int pchaUntpc; // 매입단가
	private int mrgnCt; // 마진
	private String mrgnRate; // 마진률
	private String chgMrgnCt; // 변경예정 마진
	private String chgMrgnRate; // 변경예정 마진률
	
	private String removeYn; // 삭제여부
	private String lastYn;
	private String mrgnPrdCd; // 판매자/애음자 구분코드
	private String chgType;
	private String targetAreaSeq; // 단가복사하려는 지역코드

	private String befPrdDtlSeq;
	private String befPrdSeq;
	private String aftPrdDtlSeq;
	private String aftPrdSeq;
}

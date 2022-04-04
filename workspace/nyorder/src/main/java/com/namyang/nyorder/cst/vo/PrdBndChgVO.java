package com.namyang.nyorder.cst.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : cst/prdBndChg 
 * 파일명  : PrdBndChgVO.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class PrdBndChgVO extends CommVO {
	//공통
	private String useYn;//사용여부
	private String regDtm;// 등록일
	private String regSeq;// 등록자
	private String updDtm;// 수정일
	private String updSeq;// 수정자
	//T_PRD_MST
	private String prdSeq;
	private String puchSeq;
	private String prdSapCd;//제품코드
	private String prdNm;//제품명
	private String ordUseYn;//주문가능여부
	//T_PRD_DTL
	private String prdDtlSeq;
	private String agenSeq;
	private String prdDtlCd;//자체코드
	private String stdPrdNm;//표준제품명
	private String iddyPchaCt;//메입단가(낱개)
	private String areaStdUntpc;//지역표준단가
	private String cstStdUntpc;//애음자표준단가
	private String saleUntpc;//판매단가(시판)
	private String untpcApplDt;//단가적용일
	private String untpcApplSeq;//단가적용자
	private String lastYn;//마지막 여부 - y
	
	//T_AGEN_AREA
	private String areaNm;//지역명
	private String agenAreaCd;//지역코드
	
	//T_AGEN_AREA_PRD
	private String areaPrdSeq;
	private String areaSeq;
	private String emplSeq;
	private String untpc;//지역단가
	private String spprc;//지역 공급가
	private String vatCt;//지역VAT
	private String totSpprc;//지역 공급가 + 지역 VAT = 애음자단가로 씀
	private String applDt;//적용일
	
	private String chgDt;
	private String untpc2;
}

package com.namyang.nyorder.cst.vo;

import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.util.StringUtil;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 더블작업 관리 VO
 * 파일명  : DoubleDlvMngVo.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 16.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 16.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class DoubleDlvMngVO extends CstPrdDlvyVO {
	private String cstDoubleMstSeq;
	private String cstDoubleDtlSeq;
	private String agenSeq;
	private String areaSeq;
	private String prdDtlSeq;
	private String sendDlvSeq;
	private String rcivDlvSeq;
	private String legacyDlvDt;
	private String chgDlvDt;
	private String doubleSecCd;
	private String returnYn;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String doubleQty;
	private String pttnSeq;

	private String qtyUpdateType;
	private String srcStatDate;
	private String srcEndDate;

}

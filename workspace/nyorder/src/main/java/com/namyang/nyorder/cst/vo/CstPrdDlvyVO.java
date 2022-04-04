package com.namyang.nyorder.cst.vo;

import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.util.StringUtil;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 출고 정보 VO
 * 파일명  : CstPrdDlvyVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 2. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 4.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class CstPrdDlvyVO extends StdPrdMngDetailVO {
	private String cstPrdDlvySeq;
	private String agenSeq;
	private String areaSeq;
	private String cstSeq;
	private String prdSeq;
	private String cstAgenCd;
	private String cstPrdSeq;
	private String dlvyQty;
	private String dlvyDt;
	private String inPosi;
	private String dlvyUntpc;
	private String useYn;
	
	private String prdQty;
	private String boxQty;
	private String unitQty;
	
	private String srcDate;

	private String agenAreaCd;
	private String areaOrdr;
	
	private String emplNm;
	private String emplCd;
	private String areaNm;
	
	private String cstNm;
	private String dlvOrdr;
	private String dlvAddr1;
	private String dlvAddr2;
	
	private String dlvOrdrSeq;
	private String undlvYn;
	
	private String mapLatu;
	private String mapLotu;
	private String laloYn;
	
	private String pttn;
	private String blankYn;
	private String incNtcYn;
	
	public String getDlvAddr() {
		String addr1 = StringUtil.isEmpty(this.dlvAddr1)?"":this.dlvAddr1+" "; 
		String addr2 = StringUtil.isEmpty(this.dlvAddr2)?"":this.dlvAddr2;
		return addr1+addr2;
	}
}

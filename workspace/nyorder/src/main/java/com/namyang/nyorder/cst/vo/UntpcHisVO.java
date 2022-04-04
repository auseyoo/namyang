package com.namyang.nyorder.cst.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UntpcHisVO {
	
	private String agenSeq;
	private String untpcChgType;
	private String prdDtlCd;
	private String prdNm;
	private String emplNm;
	private String areaNm;
	private String areaSeq;
	private int aftUntpc;
	private	String aftMrgnCt;
	private String aftMrgnRate;
	private int befUntpc;
	private String befMrgnCt;
	private String befMrgnRate;
	private String applDt;
	private String applYn;
	private String regDtm;
	
	private String prdDtlSeq;
	private String startDt;
	private String endDt;
}
package com.namyang.nyorder.cst.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CstDiretHisVO {
	
	private String cstSeq;
	private String cstDiretSeq;
	private String regDtm;
	private String cstNm;
	
	private String befAreaSeq;
	private String befAreaNm;
	private String befAgenSeq;
	private String befAgenNm;
	private String befTelNo;
	private String befDlvZipCd;
	private String befDlvAddr1;
	private String befDlvAddr2;
	private String diretCt;
	private String befRmk;
	
	private String aftAreaSeq;
	private String aftAreaNm;
	private String aftAgenSeq;
	private String aftAgenNm;
	private String aftEmplTelNo;
	private String aftAgenTelNo;
	private String aftDlvZipCd;
	private String aftDlvAddr1;
	private String aftDlvAddr2;
	private String aftRmk;
	private String bhfcSeq;
	private String bhfcNm;

	private String diretDtm;
	private String cntrStus;
	private String dcsnDtm;
	private String emplNm;
	private String emplSeq;
	private String areaSeq;
	private String areaNm;
	
	private String mobNo;
	private String telNo;
	private String rjctRson;
	private String bilctMthNm;

	private String curAgenSeq;

	private List<CstCntrVO> cntrList;
	
	private String startDt;
	private String endDt;
	private String dateFlag;
	private String name;
}

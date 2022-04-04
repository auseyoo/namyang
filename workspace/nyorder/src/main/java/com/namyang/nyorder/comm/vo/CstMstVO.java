package com.namyang.nyorder.comm.vo;

import com.namyang.nyorder.util.StringUtil;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CstMstVO  extends CommVO{
	private String cstSeq;
	private String areaSeq;
	private String cstAgenCd;
	private String cstNm;
	private String appctNm;
	private String telNo;
	private String mobNo;
	private String mobNo2;
	private String cstRml;
	private String bilctMth;
	private String stpgDt;
	private String stpgRson;
	private String stpgYn;
	private String dlvZipCd;
	private String dlvAddr1;
	private String dlvAddr2;
	private String reptZipCd;
	private String reptAddr1;
	private String reptAddr2;
	private String cashRecpYn;
	
	public String getDlvAddr() {
		String addr1 = StringUtil.isEmpty(this.dlvAddr1)?"":this.dlvAddr1+" "; 
		String addr2 = StringUtil.isEmpty(this.dlvAddr2)?"":this.dlvAddr2;
		return addr1+addr2;
	}
}

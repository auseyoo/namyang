package com.namyang.nyorder.cst.vo;

import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.util.StringUtil;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CstDlvNtcVO extends CommVO {
	private String dlvNtcSeq;
	private String areaSeq;
	private String cstSeq;
	private String cntt;
	
	private String ntcSecCd;
	private String optDt;
	private String optYn;
	private String useYn;
	
	private String srcDate;
	private String ntcType;
	private String ntcTrgt;
	
	private String dlvAddr1;
	private String dlvAddr2;
	
	public String getDlvAddr() {
		String addr1 = StringUtil.isEmpty(this.dlvAddr1)?"":this.dlvAddr1+" "; 
		String addr2 = StringUtil.isEmpty(this.dlvAddr2)?"":this.dlvAddr2;
		return addr1+addr2;
	}
}

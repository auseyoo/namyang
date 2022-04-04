package com.namyang.nyorder.comm.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Setter
public class CommVO {

	private int pageNo;
	private int pageSize=20;
	private String rowStatus;

	private String id;
	
	private String agenSeq;
	private String emplSeq;
	private String agenCd;
	private String emplCd;
	private String saleCd;
	
	private String regDtm;
	private String regSeq;
	private String regNm;
	
	private String updDtm;
	private String updSeq;
	private String updNm;
	
	private String lastUpdSeq;
	private String lastUpdNm;
	private String lastUpdDtm;
	
	private String totalRow;

	private String crudMode;
	
	public void setSessionInfo(AccountVO accountVO) {
		
		log.debug("#CommVO metName: " + accountVO.getAgenCd() + "==" + accountVO.getAgenSeq() + "==" + accountVO.getEmplCd() + "==" + accountVO.getEmplSeq());
				
		setAgenCd(accountVO.getAgenCd());
    	setAgenSeq(accountVO.getAgenSeq());
    	setEmplCd(accountVO.getEmplCd());
    	setEmplSeq(accountVO.getEmplSeq());		
    	setSaleCd(accountVO.getSaleCd());
		
	}
	

}
